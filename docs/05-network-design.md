# Network design

## IP addressing

The `10.0.0.0/9` range was used for IP addressing planning. During the planning, the address ranges shown in the table below should be excluded.

| ip ranges to avoid    |                               |
| :---                  | :---:                         |
| common choice         | 10.0.0.0/16 - 10.15.0.0/16    |
| aws default           | 172.31.0.0/16                 |
| gcp default           | 10.128.0.0/9                  |
| vpn                   | 172.16.0.0/16                 |
| docker default        | 172.17.0.0/16                 |
| k8s calico default    | 192.168.0.0/16                |
| office                | 192.168.16.0/24               |

The number of ranges needed was calculated from the following formula:
```
number of ranges = number of accounts * number of regions in each account *  number of vpc in each region
number of ranges = (3 accounts + one reserved) * (us-east-1 + eu-west-1 + one region reserved) * (main vpc + reserved vpc)
number of ranges = 4 * 3 * 2 = 24
```

IP addressing plan for the `microcloud` organization:
| account name          | vpc       | us-east-1     | eu-west-1     | reserved      |
| :---                  | :---:     | :---:         | :---:         | :---:         |
| microcloud-management | -         | -             | -             | -             |
| microcloud-shared     | main      | 10.16.0.0/16  | 10.18.0.0/16  | 10.20.0.0/16  |
|                       | reserved  | 10.17.0.0/16  | 10.19.0.0/16  | 10.21.0.0/16  |
| microcloud-nonprod    | main      | 10.22.0.0/16  | 10.24.0.0/16  | 10.26.0.0/16  |
|                       | reserved  | 10.23.0.0/16  | 10.25.0.0/16  | 10.27.0.0/16  |
| microcloud-prod       | main      | 10.28.0.0/16  | 10.30.0.0/16  | 10.32.0.0/16  |
|                       | reserved  | 10.29.0.0/16  | 10.31.0.0/16  | 10.33.0.0/16  |
| reserved              | main      | 10.34.0.0/16  | 10.36.0.0/16  | 10.38.0.0/16  |
|                       | reserved  | 10.35.0.0/16  | 10.37.0.0/16  | 10.39.0.0/16  |

The following ranges can still be used in the organization: `10.40.0.0/16 - 10.127.0.0/16`

## VPC structure
Each VPC in the organization is designed as a 3 tier VPC. Such a VPC consists of the following tiers:
- **public subnets**: both inbound and outbound traffic to the public internet are allowed.
- **private subnets**: each subnet has its own NAT gateway. Outbound traffic to the public internet and only inbound traffic from the organizations VPC is allowed.
- **storage subnets**: inbound traffic is limited to only come from the private subnets, and outbound traffic is allowed only to the VPC.

The number of subnets needed was calculated from the following formula (each range is divided in equal subnets):
```
number of subnets = number of AZs * number of tiers
number of subnets = (3 AZs + one reserved) * (3 tiers + one reserved)
number of subnets = 4 * 4 = 16

10.x.y.z/16 => 65534  # available ip addresses in each vpc
65534 / 16 = 4095  # each subnet should have 4095 addresses

10.x.y.z/20 => 4096  # network mask that should be used
```

Each subnet has available `4095-5` addresses. These addresses are reserved in each subnet:
```
.0 => network address
.1 => vpc router
.2 => dns resolver
.3 => future use
.<last> => network broadcast address
```

An example vpc design:

![](./assets/example-vpc-design.drawio.svg)
