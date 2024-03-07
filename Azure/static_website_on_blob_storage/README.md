## Basic Terraform commands
- ### Initialise Terraform
    ```bash
    terraform init
    ```

- ### Clean up code
    ```bash
    terraform fmt
    ```

- ### Validate code
    ```bash
    terraform validate
    ```

- ### Create a Terraform execution plan
    ```bash
    terraform plan -out main.tfplan
    ```
    **or**
    ```bash
    terraform plan
    ```

- ### Apply a Terraform execution plan
    ```bash
    terraform apply main.tfplan
    ```
    **or**
    ```bash
    terraform apply
    ```

- ### Clean up resources
    ```bash
    terraform plan -destroy -out main.destroy.tfplan
    ```
    ```bash
    terraform apply main.destroy.tfplan
    ```

    **or**
    ```bash
    terraform destroy
    ```