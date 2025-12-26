# Docker Images Push to Alibaba Cloud Registry

This repository contains a GitHub Actions workflow to pull Docker images from Docker Hub and push them to Alibaba Cloud Container Registry.

## Setup Instructions

### Prerequisites

1. An Alibaba Cloud account with Container Registry enabled
2. A Container Registry namespace created (e.g., `fuli1001`)
3. GitHub repository secrets configured

### Configuring Alibaba Cloud Registry Credentials

**IMPORTANT**: Alibaba Cloud Container Registry requires a **registry-specific password**, which is different from your Alibaba Cloud account password.

#### Steps to Set Up Registry Password:

1. Log in to [Alibaba Cloud Container Registry Console](https://cr.console.aliyun.com/)
2. Navigate to **"Access Credential"** or **"Set Password"** section
3. Set or reset your **registry password** (this is NOT your Alibaba account password)
4. Note your registry username (usually your Alibaba Cloud account email or ID)

#### Configuring GitHub Secrets:

Add the following secrets to your GitHub repository (Settings → Secrets and variables → Actions):

1. **`ALIBABA_CLOUD_USERNAME`**: Your Alibaba Cloud registry username
   - This is typically your Alibaba Cloud account email or account ID
   
2. **`ALIBABA_CLOUD_PASSWORD`**: Your **registry password**
   - ⚠️ **NOT** your Alibaba Cloud account password
   - ⚠️ Must be the registry-specific password set in the Container Registry Console

### Troubleshooting Authentication Errors

If you encounter `"unauthorized: authentication required"` error:

1. **Verify Registry Password**: 
   - Go to Alibaba Cloud Container Registry Console
   - Reset your registry password
   - Update the `ALIBABA_CLOUD_PASSWORD` secret in GitHub

2. **Check Username Format**:
   - Ensure you're using the correct username format
   - For personal accounts: usually your email or account ID
   - For RAM users: you may need to set a separate registry password

3. **Verify Registry URL**:
   - Default: `registry.cn-hangzhou.aliyuncs.com`
   - Ensure it matches your registry region

4. **Test Locally**:
   ```bash
   docker login registry.cn-hangzhou.aliyuncs.com
   # Use your registry username and registry password
   ```

5. **Special Characters in Password**:
   - If your password contains special characters, ensure they're properly saved in GitHub Secrets
   - Consider using a simpler password without special characters

### Workflow Usage

The workflow can be triggered manually via GitHub Actions:

1. Go to Actions → "Push docker images to Alibaba Cloud Registry"
2. Click "Run workflow"
3. Configure the image tags and registry settings
4. Run the workflow

### Supported Images

- Python
- PyTorch
- Node.js
- MongoDB
- mongo-express
- Cloudflared

## Additional Resources

- [Alibaba Cloud Container Registry Documentation](https://www.alibabacloud.com/help/en/acr)
- [Docker Login Action Documentation](https://github.com/docker/login-action)
- [GitHub Actions Secrets Documentation](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
