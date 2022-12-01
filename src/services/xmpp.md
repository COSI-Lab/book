# XMPP

_updated: Nov 30th 2022_

One of [Comm (Eldwyn)](../infrastructure/servers/eldwyn.md)'s services is
a [Prosody](https://prosody.im/) server, which provides the eXtensible
Messaging and Presence Protocol (XMPP), sometimes known by its old name,
Jabber. Ours oversees the `cslabs.clarkson.edu` realm of Jabber IDs (JIDs).

## iptables

XMPP uses TCP by default. Clients usually connect at 5222, while servers (for
inter-realm traffic) connect at 5269. Our server is also configured to provide
a media proxy HTTP server at 5280, and BOSH (a friendlier protocol for HTTP
clients) at 5000.

```
-p tcp -m multiport --dports 5000,5222,5269,5280
```

## Configuration

Debian's prosody has a `conf.avail` and `conf.d`, with living config linked
from `conf.avail` into `conf.d`. The configuration language is Lua; some magic
is done such that variables in the environment are collected and excised
whenever a new `VirtualHost`, `Component`, or the end of the file is reached.
The configuration variables collected to this point are applied to whatever
started _before_ the `VirtualHost` or `Component`; before the first one of
these, the configuration is global.

It is perfectly permissible to define unknown variables, including declaring
functions. Care must be taken to avoid the name from being meaningful in the
future; an underscore `_` prefix is recommended.

This is `conf.avail/cslabs.clarkson.edu.cfg.lua`:

```lua
local function _ssl_config(name) return {
	certificate = "/var/lib/prosody/" .. name .. ".crt",
	key = "/var/lib/prosody/" .. name .. ".key",
}
end

VirtualHost "cslabs.clarkson.edu"

modules_enabled = {
	"iq",  -- Core protocol
	-- Transport:
	"tls",
	"s2s",  -- Server to server
	"c2s",  -- Client to server
	"websocket",

	-- Authentication providers:
	"saslauth",
	"tokenauth",
	"legacyauth",  -- not recommended but needed by some bots
	"dialback",  -- S2S authentication mechanism

	-- Useful features:
	"roster",  -- a.k.a. "friends lists"
	"mam",  -- Remember ("archive") messages while offline
	"muc_mam",  -- Do that in chatrooms, too
	"carbons",  -- Send synchronized copies to other user endpoints
	"admin_adhoc",  -- Administration commands
	"admin_shell",  -- Local administration commands and RCE
	"announce",
	"blocklist",  -- Remember and synchronize blocked users for clients
	"private",  -- XML "private storage", e.g. bookmarks
	"disco",  -- Service discovery
	"smacks",  -- Stanza "acks", useful for clients on finicky networks
	"cloud_notify",  -- Push notifications, for such clients
	"cloud_notify_extensions",  -- For certain iOS clients
	"csi_simple",  -- Allow mobile clients to request throttling
	"tombstones",  -- Deletion records, kept around for sync
	"uptime",
	"version",
	"presence",
	"ping",  -- Latency discovery
	"time",
	"pep",  -- Client published broadcasts, e.g. status, activity...
	"invites",  -- Allow invitations to accounts/friends
	"invites_adhoc",  -- Clientside commands to make invites
	"invites_register",  -- Allow registration with a user invite token
	"register",  -- New user registration
	"groups",  -- "Shared rosters", server configured
	"server_contact_info",  -- (Automatically publishes admins)
	"vcard4",  -- "vCards", user-owned self descriptions
}
-- authentication = "ldap"  -- Eventually...
-- authentication = "cyrus"  -- Or perhaps this
admins = {
	"example@cslabs.clarkson.edu",  -- Not the real list
}
storage = "sql"
archive_expires_after = "never"
muc_log_presences = true
muc_log_expires_after = "never"
disco_items = {
	{"muc.comm.cslabs.clarkson.edu", "Multi-User Conference service"},
	{"pubsub.comm.cslabs.clarkson.edu", "Publish/Subscribe Framework service"},
	{"proxy.comm.cslabs.clarkson.edu", "Mediated SOCKS Proxy service"},
	{"upload.comm.cslabs.clarkson.edu", "HTTP File Sharing service"},
}
groups_file = "/var/lib/prosody/groups.txt"
ssl = _ssl_config("cslabs.clarkson.edu")
-- Registration settings: be careful, or the spambots will proliferate
allow_registration = true
registration_invite_only = true

Component "muc.comm.cslabs.clarkson.edu" "muc"
ssl = _ssl_config("muc.comm.cslabs.clarkson.edu")
Component "pubsub.comm.cslabs.clarkson.edu" "pubsub"
ssl = _ssl_config("pubsub.comm.cslabs.clarkson.edu")
Component "proxy.comm.cslabs.clarkson.edu" "proxy65"
ssl = _ssl_config("proxy.comm.cslabs.clarkson.edu")
Component "upload.comm.cslabs.clarkson.edu" "http_file_share"
ssl = _ssl_config("upload.comm.cslabs.clarkson.edu")
http_file_share_size_limit = 128 * 1024 * 1024
http_file_share_expires_after = "never"
```

Components generally can act as independent subdomains/services; for example,
some other chat gateways register as services. If they're external, they
require a shared secret--do not publish it here in unredacted form.

As can be seen, modern XMPP requires a large amount of extensions. Prosody
comes with many extensions, and further can be installed as Lua packages,
either with your preferred package manager or LuaRocks. See Prosody's
documentation for the list and details.

## Clients

[xmpp.org](https://xmpp.org/) publishes a [list of clients](https://xmpp.org/software/clients/) to peruse for various platforms.
They are fairly varied; definitely try a few.

- [Pidgin](https://pidgin.im/) seems to remain the standard; it supports a few
  chat protocols other than XMPP, and has an interface reminiscent of AOL's
  Instant Messenger (including the dated, bright-bold text, lack of alignment
  or boxing, etc.). It still offers the most features of all clients I've tried
  on Linux.
- [Profanity](https://profanity-im.github.io/) is useful for terminal punks--it
  may well be a fork of weechat, and works in much the same way, slightly
  simplified.
- [Gajim](https://gajim.org/) has a markedly more modern interface, though is a
  bit of a pain to build. It sacrifices some of the more arcane functions for
  aesthetics.
- [Kopete](https://apps.kde.org/kopete/), in the KDE ecosystem, seems to work
  fairly well if you have the rest of the software support. The support for MUC
  (chat rooms) is suspect, however.
- [Dino](https://dino.im/), by default, cannot bypass TLS certificate errors;
  even modifying the source to avoid this, it does not support the creation of
  conferences, merely joining existing ones. It does, however, have a
  pleasantly modern interface.

## Registration

Users need to have accounts to use the XMPP server. We do not allow open
registration; in theory, invite registration works, though ad-hoc commands are
sparse.

From the server, as a privileged user (e.g. `root`), one can create a new user
with `prosodyctl adduser JID` for the appropriate JID (e.g.
`testuser@cslabs.clarkson.edu`). The tool will prompt for a password.

Users can be removed with `deluser` on the same command and passwords set with
`passwd` on the same command. There is no built-in way to list users, but they
are stored in the default backing store at `/var/lib/prosody/prosody.sqlite` (a
`sqlite3` database).

A webservice implements an automatic registration system; try accessing [comm's website](https://comm.cslabs.clarkson.edu/) for details.
