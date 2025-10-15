**Terraform Workspace Deployment (Branch-Based)**

This repository uses **Terraform Workspaces** with **branch-based automation** to manage multiple environments such as `dev`, `staging`, and `prod`.

When a commit happens on a specific branch (for example, `dev`),the github action file will be trigged, then corresponding Terraform workspace is selected by using github actions, and the configuration are ready to deployed to that environment and This required manual approval.

**Terraform State Management**

This project uses Amazon S3 as the remote backend to securely store and manage Terraform state files.

Each environment (dev, staging, prod) maintains its own separate state file within the same S3 bucket, ensuring full isolation and preventing state conflicts between environments

**How It Works**

| Git Branch | Terraform Workspace | Environment  | Action Trigger |
|-------------|---------------------|---------------|----------------|
| `dev`       | `dev`               | Development   | On commit or merge to `dev` |
| `staging`   | `staging`           | Staging       | On commit or merge to `staging` |
| `main`      | `prod`              | Production    | On commit or merge to `main` |

---
**Folder Structure**

```
8byte/
├── main.tf
├── variables.tf
├── backend.tf
├── outputs.tf
│
├── .github/
│   └── workflows/
│       └── terraform-deploy.yml
│
└── module/
    ├── EKS/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    ├── iam/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    ├── RDS/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    ├── sg/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    └── vpc/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

Using this Terraform configuration, we can provision VPC, EKS, RDS, and Security Groups (SG) for all environments (such as dev, staging, and prod) with a consistent configuration.

The setup is modular, allowing each component (like VPC, IAM, RDS, EKS, etc.) to be managed independently through its respective module.

All key parameters — such as AMI ID, instance type, CIDR blocks, and other environment-specific values — can be easily customized using local variables declared in the root variables.tf file inside the 8byte/ main folder.

**Destory the terraform infra**

This repository includes a GitHub Actions pipeline to safely destroy existing Terraform infrastructure when required.

The destroy workflow uses the same workspace-based approach, ensuring that only the targeted environment (for example, dev, staging, or prod) is affected.
