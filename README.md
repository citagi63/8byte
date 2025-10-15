**Terraform Workspace Deployment (Branch-Based)**

This repository uses **Terraform Workspaces** with **branch-based automation** to manage multiple environments such as `dev`, `staging`, and `prod`.

When a commit happens on a specific branch (for example, `dev`),the github action file will be trigged, then corresponding Terraform workspace is selected by using github actions, and the configuration are ready to deployed to that environment and This required manual approval.

---

**How It Works**

| Git Branch | Terraform Workspace | Environment  | Action Trigger |
|-------------|---------------------|---------------|----------------|
| `dev`       | `dev`               | Development   | On commit or merge to `dev` |
| `staging`   | `staging`           | Staging       | On commit or merge to `staging` |
| `main`      | `prod`              | Production    | On commit or merge to `main` |

---
**Folder Structure**

```8byte/
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
    │   ├── backend.tf
    │   └── outputs.tf
    │
    ├── iam/
    │   ├── main.tf
    │   ├── variables.tf
    │   ├── backend.tf
    │   └── outputs.tf
    │
    ├── RDS/
    │   ├── main.tf
    │   ├── variables.tf
    │   ├── backend.tf
    │   └── outputs.tf
    │
    ├── sg/
    │   ├── main.tf
    │   ├── variables.tf
    │   ├── backend.tf
    │   └── outputs.tf
    │
    └── vpc/
        ├── main.tf
        ├── variables.tf
        ├── backend.tf
        └── outputs.tf```




