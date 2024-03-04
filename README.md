
# Overview
The infrastructure has been created using a 3-tier architecture approach with terraform.

# Installation
See [pre-commit](https://pre-commit.com/#installation) for installation instructions.

## 3-tier architecture
A 3-tier architecture is a software architecture pattern that divides an application into three interconnected layers: presentation layer (also known as the user interface or client layer), business logic layer (also known as the application or service layer), and data storage layer (also known as the data layer). This modular approach separates the concerns of presentation, logic, and data management, making the system more scalable, maintainable, and flexible. The presentation layer handles user interaction and displays information to users, the business logic layer processes data and implements application logic, and the data storage layer manages data persistence and retrieval.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## ToDo
- Fix pre-commit hook terraform_docs not populating docs tags.
- Draw a sketch of the architecture using 3-tier.
- Update the IaC code to include appropriate resources in application, presentation and data tiers.
- Update the IaC code to include resources for High Availability, Resource based access control (RBAC), Security (Encryption in transit and at rest, WAF) Observability and Fault tolerance(Auto-scaling).
