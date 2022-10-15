# COSI Account Management


## Creating a COSI Account

Creating a user requires 2 steps. First we must create a [Kerberos](../services/krb5.md) principal then we can create an [LDAP](../services/ldap.md) DN.

### Creating a Kerberos Principal

There are two ways of creating a Kerberos Principal. Perferrably use your _/admin_ principal to sign into `kadmin` on any service. Or if for some reason you don't have a _/admin_ principal; you should become root on Talos and sign into kadmin using the `kadmin.local` command.


Sign into [Talos](../infrastructure/servers/talos.md)

## Enrolling a server in Central Authentication


