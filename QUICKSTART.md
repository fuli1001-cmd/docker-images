# Quick Start Guide: Fixing the Docker Login Issue

## The Problem
Your GitHub Actions workflow is failing with this error:
```
Error: Error response from daemon: Get "https://registry.cn-hangzhou.aliyuncs.com/v2/": unauthorized: authentication required
```

## The Solution (5 Minutes)

### Step 1: Get Your Registry Password
1. Go to [Alibaba Cloud Container Registry Console](https://cr.console.aliyun.com/)
2. Log in with your Alibaba Cloud account
3. Click **"Access Credential"** (访问凭证) in the left menu
4. Click **"Set Password"** or **"Reset Password"**
5. Create a new password and save it securely

⚠️ **Important**: This is NOT your Alibaba Cloud account password. It's a separate password just for the container registry.

### Step 2: Update GitHub Secrets
1. Go to your GitHub repository: https://github.com/fuli1001-cmd/docker-images
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Update or create these two secrets:

   **Secret 1: `ALIBABA_CLOUD_USERNAME`**
   - Value: Your Alibaba Cloud email or account ID
   - Example: `your-email@example.com` or your account ID

   **Secret 2: `ALIBABA_CLOUD_PASSWORD`**
   - Value: The registry password you just created in Step 1
   - ⚠️ Use the REGISTRY password, not your account password

### Step 3: Test Locally (Optional but Recommended)
Before running the GitHub Action, test your credentials:

```bash
docker login registry.cn-hangzhou.aliyuncs.com
# When prompted:
# Username: <your registry username>
# Password: <your registry password>
```

If this succeeds, your credentials are correct!

### Step 4: Run the Workflow
1. Go to **Actions** → **"Push docker images to Alibaba Cloud Registry"**
2. Click **"Run workflow"**
3. Fill in the image tags or use the defaults
4. Click **"Run workflow"**

The workflow should now succeed! ✅

## Still Having Issues?

### Check These Common Problems:

1. **Wrong password type**: Make sure you're using the registry password, not your account password
2. **Typos in secrets**: Delete and recreate both secrets carefully
3. **Special characters**: If your password has special characters, try creating a simpler one
4. **Wrong username**: Use your email or account ID, not a display name

### Need More Help?

- See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for detailed debugging steps
- See [README.md](README.md) for complete documentation
- Check the Alibaba Cloud Console to verify your namespace exists

## Summary

The workflow code is correct. You just need to:
1. ✅ Set a registry password in Alibaba Cloud
2. ✅ Update GitHub Secrets with the correct credentials
3. ✅ Re-run the workflow

That's it! 🎉
