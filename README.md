✨**Terraform Apparoch**✨

1)**Terraform Workspace Deployment (Branch-Based)**

This repository uses **Terraform Workspaces** with **branch-based automation** to manage multiple environments such as `dev`, `staging`, and `prod`.

When a commit happens on a specific branch (for example, `dev`),the github action file will be trigged, then corresponding Terraform workspace is selected by using github actions, and the configuration are ready to deployed to that environment and This required manual approval.

2)**Terraform State Management**

This project uses Amazon S3 as the remote backend to securely store and manage Terraform state files.

Each environment (dev, staging, prod) maintains its own separate state file within the same S3 bucket, ensuring full isolation and preventing state conflicts between environments

3)**How It Works**

| Git Branch | Terraform Workspace | Environment  | Action Trigger |
|-------------|---------------------|---------------|----------------|
| `dev`       | `dev`               | Development   | On commit or merge to `dev` |
| `staging`   | `staging`           | Staging       | On commit or merge to `staging` |
| `main`      | `prod`              | Production    | On commit or merge to `main` |

---
4)**Folder Structure**

```
8byte/
├── main.tf
├── variables.tf
├── backend.tf
├── outputs.tf
│
├── .github/
│   └── workflows/
│       └── terraform.yml
|       └── terraform-destory.yml
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

5)**Destory the terraform infra**

This repository includes a GitHub Actions pipeline to safely destroy existing Terraform infrastructure when required.

The destroy workflow uses the same workspace-based approach, ensuring that only the targeted environment (for example, dev, staging, or prod) is affected.

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------

💥**Best practies used in terraform code and github actions**💥

1)**Remote State Management**

Use an S3 bucket to store Terraform state files. Ensures shared and secure state management across environments.

2)**Use Modules for Reusability**

Organize infrastructure into reusable modules such as VPC, EKS, RDS, IAM, and SG. Promotes cleaner, modular, and maintainable code.

3)**Workspaces for Environments**

Manage multiple environments (dev, staging, prod) using Terraform workspaces. Keeps configurations consistent and isolated between environments.

4)**Variables and Locals**

Define environment-specific values in variables.tf. Simplifies parameter management.

5)**Secrets Management**

Do not hardcode credentials in Terraform code. Use AWS Secrets Manager or SSM Parameter Store to fetch sensitive data such as DB credentials.


🚅**Github actions and Funtionality** 🚅


Each environment (dev, staging, prod) is managed via Terraform Workspaces.

The state files are stored remotely in AWS S3.

The AWS authentication in GitHub Actions uses OIDC (no static credentials).

🧩 **GitHub Actions Workflows**
1️⃣ **terraform-dryrun.yml** – Dry Run on Pull Request

Runs automatically on PRs targeting dev, staging, or release.
Performs a Terraform plan (no apply) and comments the result on the PR.

**Functionality**

    Triggers on pull_request
    
    Initializes and validates Terraform
    
    Runs terraform plan
    
    Posts the plan output as a comment

2️⃣ **terraform.yml** – Auto Deploy on Merge

Runs on every push to dev, staging, or release.
Deploys Terraform changes automatically.

**Functionality:**

    Triggers on push events
    
    Selects Terraform workspace (dev, staging, prod)
    
    Validates Terraform
    
    Runs terraform plan and terraform apply
    
    Requires manual approval for production

3️⃣ **terraform-destroy.yml** – Manual Destroy Pipeline

Used to manually destroy Terraform infrastructure from GitHub Actions.
Requires selecting the environment (dev, staging, or prod) before execution.

**Functionality:**

    Triggered manually (workflow_dispatch)
    
    Prompts for environment selection
    
    Runs terraform init, workspace select, and terraform destroy -auto-approve



