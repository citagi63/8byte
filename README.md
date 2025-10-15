Terraform Workspace Deployment (Branch-Based)

This repository uses **Terraform Workspaces** with **branch-based automation** to manage multiple environments such as `dev`, `staging`, and `prod`.

When a commit happens on a specific branch (for example, `dev`), the corresponding Terraform workspace is selected, and the configuration is automatically deployed to that environment.

---

How It Works

| Git Branch | Terraform Workspace | Environment  | Action Trigger |
|-------------|---------------------|---------------|----------------|
| `dev`       | `dev`               | Development   | On commit or merge to `dev` |
| `staging`   | `staging`           | Staging       | On commit or merge to `staging` |
| `main`      | `prod`              | Production    | On commit or merge to `main` |

---



