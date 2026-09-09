# GitLab

COSI has historicaly hosted a multitude of different git forges, and we currently run GitLab. 
In spring 2026 some COSI members expressed interest in having an alternative to GitHub follwing
it's increasing enshitification by microslop. The GitLab instance originally ran in a VM and 
most of the labs primary repos were migrated over.

In fall 2026 the GitLab instance was moved onto [Janet](../infrastructure/servers/janet.md) to provide
more hardware resources to support users outside of COSI. 

## Maintenance
We currently run GitLab omnibus as a linux package because we are running on bare metal. A better alternative
would be to run on a kubernetes cluster to ensure availability, but that wasn't in the hardware budget when we
set it up. 

One caveat of omnibus is that it *requries* a dedicated administrator. There should always be someone responsible
for keeping the system up to date and watching for security updates as they are not uncommon. As our GitLab is exposed
to the public internet it is incredibly important that we stay on top of security fixes.