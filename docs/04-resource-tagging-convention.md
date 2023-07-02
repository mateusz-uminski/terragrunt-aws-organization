# Resource tagging convention

The tables below show the tags used in the organization. The tags are categorized into sections, with certain exceptions. Each section is assigned its unique name, which is added as a prefix to the tag name.

| tag                   | example value             | resources     | required  |
| :---                  | :---:                     | :---:         | :---:     |
| Name                  | mcd-main-vpc-nonprod      | *             | optional  |

| tag                   | example value | resources     | required  |
| :---                  | :---:         | :---:         | :---:     |
| business:cost-center  | 78925         | *             | yes       |

| tag                   | example value     | resources     | required  |
| :---                  | :---:             | :---:         | :---:     |
| tech:project          | microdata         | *             | yes       |
| tech:environment      | dev               | *             | yes       |
| tech:repo             | owner/repo-name   | *             | yes       |
| tech:path             | path/to/stack     | *             | yes       |
| tech:created-date     | DD-MM-YYYY        | *             | yes       |
| tech:updated-date     | DD-MM-YYYY        | *             | yes       |

| tag                   | example value | resources     | required  |
| :---                  | :---:         | :---:         | :---:     |
| ac:project            | microdata     | *             | yes       |

| tag                   | example value             | resources         | required  |
| :---                  | :---:                     | :---:             | :---:     |
| net:tier              | private/public/storage    | network resources | yes       |

| tag                   | example value             | resources     | required  |
| :---                  | :---:                     | :---:         | :---:     |
| data:classification   | internal/restricted/...   | s3,rds        | optional  |
