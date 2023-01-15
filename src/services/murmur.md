# Murmur

_updated: Nov 30th 2022_

[Comm (Eldwyn)](../infrastructure/servers/eldwyn.md) hosts a
[Murmur](https://www.mumble.info/) instance, the software required for
[Mumble](https://www.mumble.info/), a real-time VoIP solution optimized for
gaming. (You can think of it as a FOSS version of Ventrilo and/or TeamSpeak.)

## iptables

Murmur uses port `64738` by default on both TCP and UDP protocols.

```
-p udp -m multiport --dports 64738
-p tcp -m multiport --dports 64738
```

UDP transport seems to be preferred, but TCP is a useful fallback.

## Configuration

Murmur has a configuration file, in the Debian installation, at
`/etc/mumble-server.ini`, that is very skeletal; most of it is for
bootstrapping (e.g. finding other config files) and basic configuration, such
as listening ports and addresses. It is very well-documented, and only a small
amount was changed--notably, the `registerName` field names the root of the
channel hierarchy.

Before doing anything else, connect to the server and "Register" your account.
This creates a keypair that identfies you to this server. While you can
probably export this key, I'm not aware of how at the time of this writing. In
any case, like IRC NickServ registration, this will prevent other people from
using your nick--which is good, because ACLs are assigned by username.

To administer the running server, run `murmurd -supw PASSWORD` with a
sufficiently strong password; then connect using Mumble to the server as
username `SuperUser`, giving the password just set. This user is special-cased
to bypass all permission checks.

With that done, now would be a good time to add users to the `@admin` group of
the Root channel, including the username of the account you should have just
registered. (You can add any names here, but beware of adding unregistered
ones--anyone could join as them!)

This is strictly all the setup you need; as a member of `@admin`, the default
configuration confers all rights transitively. This group appears to be
special-cased insofar as its members always have all permissions; if one does
not (say, because inheritance was disabled), the user themself is poked into
the ACL with all access.

## Client

Install `mumble` with your favorite package manager.
