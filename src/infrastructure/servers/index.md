# Servers

_updated: Sept 17th 2022_

This chapter contains an alphabetically ordered list of all of COSI's physical server. For our purposes a server is any computer that is mounted on a rack. Our servers are spread across the university colocation in Old Main (colo), SC 334-A (the server room), and the SC 252 (the second floor).

## Capabilities
> Note: Reference benchmark data is provided by https://www.cpubenchmark.net.
> These scores only provide a rough estimate of servers' performance. Especially
> with older CPUs, performance under real-world workloads can vary
> significantly.

| Server Name | CPUs | CPU Family/Model | Cores/Threads | Ref. Bench | RAM Size/Type |
|-------------|------|------------------|---------------|------------|---------------|
| Erised      | 2    | Xeon E5-2630v2   | 6/12          | 7484       | 64 GB DDR3    |
| Gromit      | 2    | Xeon E5-2697v3   | 14/28         | 18717      | 128 GB DDR4   |
| Hydra       | 2    | Opteron 6376     | 16/16         | 5572       | 64 GB DDR3    |
| Janet       | 2    | Xeon E5-2640     | 6/12          | 6325       | 80 GB DDR3    |
| Kasper      | 1    | Xeon E5-2620     | 6/12          | 5290       | 8 GB DDR3     |
| Mirror      | 2    | Xeon E5504       | 4/4           | 1519       | 64 GB DDR3    |
| Caterpillar | 2    | Xeon E5620       | 4/8           | 3502       | 12 GB DDR3    |
| Talos       | 1    | Xeon E3-1220v2   | 4/4           | 4666       | 4 GB DDR3     |
| Tiamat      | 2    | Opteron 6220     | 8/8           | 4753       | 64 GB DDR3    |
| Wallace     | 2    | Xeon E5-2697v3   | 14/28         | 18717      | 128 GB DDR4   |
| Ziltoid     | 1    | Xeon E3-1220v2   | 4/4           | 4666       | 4 GB DDR3     |


## Template

```text
# NAME

_updated: _

<Description & Current Purpose>

| | |
| :--- | :--- |
| Location | <Link to the rack or storage location>
| IP Addresses |
| Deployed | true/false

## Hardware

| | |
| :--- | :--- |
| CPU |
| RAM |
| STORAGE |
| CONNECTIVITY |

## Operating System

| | |
| :--- | :--- |
| OS |
| Distro | 
| Last updated | 
| End of life | 
| Enrolled in COSI auth | true/false
| NFS Mount | true/false

## Services

<Links to services running on the system>

## Notes

<Unstructured but important information to pass on to future maintainers.>
```

