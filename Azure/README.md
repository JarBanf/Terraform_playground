# Terraform with Azure
## Set up workspace
### Installing Terraform on Mac
1. Install homebrew.
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
2. Install terraform.
    ```bash
    brew tap hashicorp/tap
    brew install hashicorp/tap/terraform
    ```
3. Check installation.
    ```bash
    terraform -version
    ```
    return: `Terraform v1.7.4 on darwin_amd64`.

### Install Azure CLI on Mac
1. Update brew repository information, and then run install command.
    ```bash
    brew update && brew install azure-cli
    ```
2. Check installation.
    ```bash
    az version
    ```
    return: `"azure-cli": "2.58.0","azure-cli-core": "2.58.0","azure-cli-telemetry": "1.1.0","extensions": {}`
3. To upgrade.
    ```bash
    az upgrade
    ```

### Log in to Azure
1. Log in to Azure.
    ```bash
    az login
    ```