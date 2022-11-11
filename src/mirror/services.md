# Services

There are some services on Mirror whose documentation does not fit well in the documentation of the software project. These are mostly configuration and documentation about services running on Mirror. 

## RKHunter

_updated: Nov. 6th 2022_

[RKHunter](https://rkhunter.sourceforge.net/) or "Rootkit Hunter" is a script that checks linux systems for signs of known linux rootkits. Assuming other security measures are well followed we should not expect Mirror to become infected with a rootkit. It might be worth an investment in running the tool automaticaaly (maybe daily?) but we don't currently have satisfactory methods of sending mail when warnings occur. Until then (and maybe forever) here is some instructions on manually running RKHunter. 


**Install:**

```
sudo apt install rkhunter
```

**Update:**

This command tells RKHunter to check for newly added software packages. We don't install software often, but it isn't a bad idea to run this event once in a while.

```
sudo rkhunter --propupd
```

**Usage:**

```
sudo rkhunter --check --skip-keypress --report-warnings-only
```

| Flag | Meaning |
| :--: | :--- |
| `--checkall` | Runs all tests. |
| `--skip-keypress` | RKHunter has a pretty annoying "press ENTER for the next scan". This disables that. |
| `--report-warnings-only` | Recommended when using `--skip-keypress` otherwise it's easy to miss results. |

**False positives:**

```
Warning: The command '/usr/bin/lwp-request' has been replaced by a script: /usr/bin/lwp-request: Perl script text executable
```

This seems to be a wellknown issue on debian based machines. 2 attempts have been made to stop this error without success.

**Configuration:**

_Current there is no configuration past what is installed by default._
