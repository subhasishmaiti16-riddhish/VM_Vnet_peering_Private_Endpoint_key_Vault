# Azure Infrastructure Automation | Terraform & Azure DevOps
## Secure Azure Networking, Private Endpoint & Identity-Based Storage Access

### Project Overview

Designed and implemented an automated, secure Azure infrastructure using **Terraform and Azure DevOps CI/CD**.

The project demonstrates how to build private network connectivity between multiple Azure Virtual Networks, securely access Azure resources without exposing them to the public internet, and transfer data using Managed Identity-based authentication.

### Architecture & Infrastructure Components

- **Azure Resource Group** – Centralized infrastructure resource management.
- **Azure Virtual Network (VNet)** – Created separate VNets for application workloads and private endpoint connectivity.
- **VNet Peering** – Established connectivity between the two VNets.
- **Azure Subnets** – Organized network resources into dedicated subnets.
- **Azure Bastion** – Secure VM access without exposing SSH directly through a public IP.
- **Azure Linux Virtual Machine** – Used as the private client to test connectivity and storage access.
- **Azure Key Vault** – Secure storage and management of sensitive configuration and credentials.
- **Azure Storage Account** – Created a private Blob Storage container.
- **Azure Private Endpoint** – Enabled private connectivity to Azure Blob Storage.
- **Azure Private DNS Zone** – Configured private DNS resolution for the Storage Account.
- **Managed Identity** – Enabled passwordless authentication from the VM to Azure Storage.
- **Azure RBAC** – Granted the required Storage Blob Data Contributor permission.

### Network Architecture

Two separate VNets were configured:

| Component | Configuration |
|---|---|
| Application VNet | `dev-vnet-security` |
| Application VNet CIDR | `10.0.0.0/16` |
| Private Endpoint VNet | `dev-vnet-endpoint` |
| Private Endpoint VNet CIDR | `10.142.0.0/16` |
| VM Subnet | `10.0.1.0/24` |
| Azure Bastion Subnet | `10.0.2.0/24` |
| Private Endpoint Subnet | `10.142.1.0/24` |

VNet Peering was configured between the two VNets to establish network connectivity.

### Private Endpoint & Private DNS Configuration

Configured an Azure Private Endpoint for the Blob Storage service.

- Created the Private DNS Zone: `privatelink.blob.core.windows.net`
- Connected the Private Endpoint to the Storage Account's Blob subresource.
- Configured Private DNS Zone VNet Links for both VNets.
- Enabled private DNS resolution from the VM.

**DNS Resolution Validation:**

```text
devstorageaccount53421.blob.core.windows.net

CNAME:
devstorageaccount53421.privatelink.blob.core.windows.net

Resolved Private IP:
10.142.1.4
```

This confirmed that the Storage Account hostname resolved to the Private Endpoint IP instead of its public IP.

### Secure VM Access Using Azure Bastion

- Deployed an Azure Linux VM in the application VNet.
- Configured Azure Bastion for secure remote access.
- Avoided direct public SSH exposure.
- Used the VM as a client to validate private network connectivity.

### Identity-Based Authentication & Data Transfer

Enabled System Assigned Managed Identity on the Azure VM.

Assigned the `Storage Blob Data Contributor` role to the VM's Managed Identity at the Storage Account scope.

This enabled authenticated access without storing Storage Account access keys or passwords on the VM.

**Validation activities:**

1. Authenticated to Azure using Managed Identity.
2. Listed the Blob Storage container.
3. Created a test file.
4. Uploaded the file to the private Blob container.
5. Listed the uploaded Blob.
6. Downloaded the file back to the VM.
7. Verified the downloaded file content.

### Infrastructure Automation with Terraform & Azure DevOps

Automated infrastructure provisioning using reusable Terraform modules and Azure DevOps pipelines.

Key automation activities:

- Infrastructure provisioning through Terraform.
- Remote Terraform state management using Azure Storage.
- Azure DevOps pipeline integration.
- Azure authentication using Workload Identity Federation (OIDC).
- Modular Terraform configuration for reusable infrastructure components.
- Infrastructure planning and deployment through CI/CD.

### Security Implementation

- Private Endpoint-based Storage connectivity.
- Public network access disabled on the Storage Account.
- Private DNS resolution.
- VNet Peering.
- Azure Bastion for secure VM access.
- Managed Identity authentication.
- Least-privilege RBAC-based data access.
- Azure Key Vault for secret management.

### Final Validation Results

| Test | Result |
|---|---|
| Terraform Infrastructure Deployment | Successful |
| VNet Peering | Configured |
| Azure Bastion VM Access | Configured |
| Private Endpoint Provisioning | Successful |
| Private DNS Resolution | Successful |
| Private IP Resolution (`10.142.1.4`) | Successful |
| HTTPS Connectivity | Successful |
| Managed Identity Authentication | Successful |
| Blob Container Access | Successful |
| Blob Upload | Successful |
| Blob Download | Successful |
| Downloaded File Verification | Successful |

### Technologies Used

`Microsoft Azure` · `Terraform` · `Azure DevOps` · `Azure Networking` · `VNet Peering` · `Private Endpoint` · `Private DNS` · `Azure Bastion` · `Azure Key Vault` · `Azure Storage` · `Managed Identity` · `Azure RBAC` · `Linux` · `CI/CD`

### Key Learning Outcomes

- Implemented secure private connectivity across multiple Azure VNets.
- Understood Private Endpoint and Private DNS integration.
- Implemented identity-based authentication for Azure Storage.
- Automated infrastructure deployment using Terraform and Azure DevOps.
- Validated end-to-end private data transfer without relying on public Storage access.

**Project Status: Successfully Implemented & Validated**

#Azure #Terraform #AzureDevOps #CloudInfrastructure #CloudSecurity #PrivateEndpoint #AzureNetworking #VNetPeering #AzureBastion #KeyVault #ManagedIdentity #DevOps #InfrastructureAsCode #CI_CD

<img width="1027" height="612" alt="image" src="https://github.com/user-attachments/assets/eddd49a6-b187-46e1-a34d-94d067889531" />
