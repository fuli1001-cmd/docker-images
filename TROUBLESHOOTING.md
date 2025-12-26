# Troubleshooting Guide

## Authentication Error: "unauthorized: authentication required"

This error occurs when the Docker login to Alibaba Cloud Registry fails. Here's how to fix it:

### Root Causes and Solutions

#### 1. Using Account Password Instead of Registry Password ⚠️

**Problem**: Alibaba Cloud Container Registry requires a **separate registry password**, not your Alibaba Cloud account password.

**Solution**:
1. Visit [Alibaba Cloud Container Registry Console](https://cr.console.aliyun.com/)
2. Click on "Access Credential" (访问凭证) in the left menu
3. Click "Set Password" or "Reset Password" to create a registry-specific password
4. Update your GitHub Secret `ALIBABA_CLOUD_PASSWORD` with this new registry password

#### 2. Incorrect Username Format

**Problem**: Using the wrong username format.

**Solution**:
- For personal accounts: Use your Alibaba Cloud account email or account ID
- For RAM (Resource Access Management) users: Use the RAM username and ensure you've set a registry password as a RAM user
- Check the Container Registry Console to confirm your username

#### 3. GitHub Secrets Not Set or Expired

**Problem**: GitHub Secrets `ALIBABA_CLOUD_USERNAME` or `ALIBABA_CLOUD_PASSWORD` are missing, incorrect, or expired.

**Solution**:
1. Go to your GitHub repository
2. Navigate to Settings → Secrets and variables → Actions
3. Verify both secrets exist:
   - `ALIBABA_CLOUD_USERNAME`
   - `ALIBABA_CLOUD_PASSWORD`
4. If they exist, delete and recreate them with the correct values
5. Ensure no extra spaces or hidden characters in the secret values

#### 4. Wrong Registry URL

**Problem**: The registry URL doesn't match your Alibaba Cloud region.

**Solution**:
- Common registry URLs:
  - Hangzhou: `registry.cn-hangzhou.aliyuncs.com`
  - Beijing: `registry.cn-beijing.aliyuncs.com`
  - Shanghai: `registry.cn-shanghai.aliyuncs.com`
  - Shenzhen: `registry.cn-shenzhen.aliyuncs.com`
- Verify your registry URL in the Alibaba Cloud Console
- Update the workflow input parameter `registry` when running the workflow

#### 5. Special Characters in Password

**Problem**: Password contains special characters that aren't properly handled.

**Solution**:
- When setting the registry password, avoid special characters if possible
- If you must use special characters, ensure they're correctly saved in GitHub Secrets
- GitHub Secrets should handle most characters automatically, but verify by testing

### Testing Locally

Before running the GitHub Action, test your credentials locally:

```bash
# Test login with your credentials
docker login registry.cn-hangzhou.aliyuncs.com

# When prompted, enter:
# Username: <your registry username>
# Password: <your registry password> (NOT your account password)
```

If local login succeeds, your credentials are correct. Update your GitHub Secrets with these same values.

### Verification Steps

1. **Reset Registry Password**:
   ```
   Alibaba Console → Container Registry → Access Credential → Reset Password
   ```

2. **Update GitHub Secrets**:
   ```
   GitHub Repo → Settings → Secrets and variables → Actions
   Update ALIBABA_CLOUD_PASSWORD with new registry password
   ```

3. **Test Workflow**:
   ```
   GitHub Actions → Push docker images to Alibaba Cloud Registry → Run workflow
   ```

### Still Having Issues?

If you've tried all the above and still encounter errors:

1. **Check Alibaba Cloud Status**: Verify there are no ongoing service issues
2. **Review Namespace Permissions**: Ensure your account has push permissions to the namespace
3. **Check Network Restrictions**: Verify no firewall or network policies block access to Alibaba Cloud
4. **Review Action Logs**: Check the detailed GitHub Actions logs for additional error messages
5. **Contact Support**: Reach out to Alibaba Cloud support if the issue persists

### Common Error Messages and Meanings

| Error Message | Meaning | Solution |
|---------------|---------|----------|
| `unauthorized: authentication required` | Credentials are invalid or missing | Reset registry password, update GitHub Secrets |
| `denied: requested access to the resource is denied` | No permission to push to namespace | Check namespace permissions |
| `name unknown` | Repository/namespace doesn't exist | Create namespace in Alibaba Console |
| `Get "https://registry.cn-hangzhou.aliyuncs.com/v2/": dial tcp: lookup` | Network/DNS issue | Check network connectivity |

### Quick Checklist

- [ ] Registry password is set in Alibaba Cloud Console (NOT account password)
- [ ] GitHub Secret `ALIBABA_CLOUD_USERNAME` is set correctly
- [ ] GitHub Secret `ALIBABA_CLOUD_PASSWORD` contains the registry password
- [ ] Registry URL matches your Alibaba Cloud region
- [ ] Local `docker login` test succeeds with the same credentials
- [ ] Namespace exists and you have push permissions
- [ ] No special characters causing issues in password

## Additional Resources

- [Alibaba Cloud Container Registry FAQ](https://www.alibabacloud.com/help/en/acr/support/faq-about-errors-of-docker-login-docker-push-and-docker-pull)
- [Docker Login Action Documentation](https://github.com/docker/login-action)
- [GitHub Actions Secrets Guide](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
