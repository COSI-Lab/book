# Asterisk

_updated: Nov 30th 2022_

[Asterisk](https://www.asterisk.org/) is one of the [Comm (Eldwyn)](../infrastructure/servers/eldwyn.md)
services, providing an extensible media routing and gateway control point for
multimedia of all kinds. It is particularly popular as a PBX (Private Branch
Exchange) for VoIP phones, especially SIP phones.

## iptables

The configuration is non-obvious, so be careful. SIP still, by and large,
expects the end-to-end principle to hold, which is rare on IPv4. (The situation
is much better on IPv6, modulo firewalls, but practical hardware is yet to
support IPv6 well.)

SIP's standard port is `5060`. PJSIP is configured to listen to this. However,
it expects ephemeral UDP ports to work bidirectionally for the RTP streams set
up by SIP. For this reason, the full Linux default ephemeral port range is
exposed. See `/proc/sys/net/ipv4/ip_local_port_range` for the running value.

```
-p udp -m multiport --dports 5060,32768:60999
```

## Configuration

Asterisk is generally well-documented on its own Wiki; see it for details.

You can also can get a local CLI for asterisk via `asterisk -r` as a user
privileged to access its control socket (such as `root`). It has quite a few
uses, including in documentation:

- `help` (alias for `core show help`): Gets help, either on a command or
  listing all commands.
- `core show codecs`/`core show codec <codec>`: Show codecs (for audio/video)
  supported by this software configuration.
- `core show applications`/`core show application <app>`: Show applications
  that can be used from the dialplan.
- `core show functions`/`core show function <func>`: Show functions that can be
  used from the dialplan.
- `core shutdown gracefully`: Restart the server. (`systemd` actually
  relaunches it, by default.)
- `reload` (alias for `module reload`): Reload all server config. You can pass
  an individual module to reload it.
- `module unload`: Remove a module.
- `lua reload` (alias for `module reload pbx_lua.so`): Reload the Lua dialplan.
- `pjsip show endpoints`/`pjsip show endpoint <ep>`: Show information about
  "endpoints" (registered SIP clients), such as where they are (if they have a
  contact).
- `pjsip show channels`/`pjsip show channel <chan>`: Show information about
  active channels (calls that are routing audio).
- `channel originate`: Dial out to an endpoint, then connect them to a dialplan
  extension or other endpoint as if they'd called it themselves.
- `exit`: Leave the CLI. (Doesn't end the server.)

There are several more, of course; let `help` and the wiki be your guide.

Since we're using PJSIP, we need `chan_sip.so` to not use the same port. In
`modules.conf`:

```
[modules]
; ...
noload => chan_sip.so
```

Then, in `pjsip.conf`, set up the basics:

```
[transport-udp]
type=transport
protocol=udp
bind=0.0.0.0

; These are "template sections", see the Asterisk documentation on templating.

[basic_ep](!)
type=endpoint
transport=transport-udp

[phone_ep](!,basic_ep)

[phone_auth](!)
type=auth
auth_type=userpass
; not the actual password
password=super_secret_password

[basic_aor](!)
type=aor
max_contacts=5

[phone_aor](!,basic_aor)

; endpoint: Codecs preferred for the Grandstream GXP1610
[gxp1610](!)
allow=slin48
allow=slin
allow=ulaw
allow=alaw
allow=g723
allow=g729
allow=g722
allow=ilbc
allow=g726

[softphone](!)
allow=slin48
allow=slin
allow=speex32
allow=speex16
allow=speex
allow=ulaw
allow=alaw
allow=opus
allow=gsm

; endpoint: Contexts to enter
[internal](!)
context=internal

; List of hosts

[example_phone](phone_ep,gxp1610,internal)
auth=example_phone
aors=example_phone

[example_phone](phone_auth)
username=example_softphone

[example_phone](phone_aor)
; Doesn't need anything in this section

[example_softphone](basic_ep,softphone,internal)
auth=example_softphone
aors=example_softphone

[example_softphone]
type=auth
auth_type=userpass
username=example_softphone
password=another_super_secret_password

[example_softphone](basic_aor)
```

It would be worthwhile to `pjsip reload` in the Asterisk CLI after writing
this.

The dialplan is established in `extensions.lua`, which loads modules from
`/etc/asterisk/extensions/`; it is a full Lua script, and too complicated and
mutable to document in any useful way. See the live source for an example.

```lua
extensions, hints, registry = {}, {}, {}
local context = {
	extensions = extensions,
	hints = hints,
	registry = registry,
	default_extension = 'internal',
}

function context:extension(name)
	if name == nil then name = self.default_extension end
	if self.extensions[name] == nil then
		self.extensions[name] = {}
	end
	return self.extensions[name]
end

function context.say(speech)
	app.festival(speech:gsub(",", ";"))
end

-- List of modules to load (not the production example)
-- To be found in the search path (see below)
-- Each module is expected to return a function that, when called with a
-- context (as above), registers the necessary entries.
local modules = {
	'conference',
}

package.path = '/etc/asterisk/extensions/?.lua;' .. package.path
for _, name in ipairs(modules) do
	require(name)(context)
end
```

Example `extensions/conference.lua`:

```lua
local room_max = 99

return function(ctx)
	local x = ctx:extension()
	for room = 1, room_max do
		x[tostring(700 + room)] = function()
			app.confbridge(tostring(room))
		end
	end

	x['700'] = function()
		local said_any = false
		ctx.say('Conference rooms. Dial 701 up to ' .. tostring(700 + room_max) .. ' to join a room.')
		for room = 1, room_max do
			local parties = tonumber(channel.CONFBRIDGE_INFO('parties', tostring(room)):get())
			-- app.verbose('Room ' .. tostring(room) .. ': ' .. tostring(parties))
			if parties ~= 0 then
				local noun, exnoun = '', ''
				if not said_any then
					exnoun = 'Extension '
					local plur = 's'
					if parties == 1 then plur = '' end
					noun = ' participant' .. plur
				end
				said_any  = true
				ctx.say(exnoun .. tostring(700 + room) .. ' has ' .. tostring(parties) .. noun .. '.')
			end
		end
		if not said_any then
			ctx.say('No extension is in use.')
		end
	end

	-- Would require the general "help system" to be loaded
	-- table.insert(ctx.help, "For conference, dial 700.")
end
```

## Clients

The hardware phones we have are [Grandstream GXP1610](https://www.grandstream.com/products/ip-voice-telephony-gxp-series-ip-phones/gxp-series-basic-ip-phones/product/gxp1610/gxp1615)s.
In general, Grandstream products work pretty well and are economically priced.
Given that they ship with a GPL2, it's likely they run Linux.

Software phones vary; `linphone` is old but generally reliable, while
`SIPDroid` is one of the few FOSS softphone apps for Android. A full list is
out of scope of this article; just remember to add your endpoint to
`pjsip.conf`.
