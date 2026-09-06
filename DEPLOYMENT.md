# GitHub Pages Deployment Guide

This guide explains how the BookRead app is deployed to GitHub Pages and how to configure it.

## 🎯 Overview

The app uses GitHub Actions to automatically build and deploy the Flutter web app to GitHub Pages whenever code is pushed to the main branch.

## 📋 Prerequisites

- GitHub repository with admin access
- GitHub Actions enabled (enabled by default)
- GitHub Pages feature available (free for public repositories)

## 🔧 One-Time Setup

### Step 1: Enable GitHub Pages

1. Navigate to your repository on GitHub: `https://github.com/iamSaifulhassan/bookreadapp`
2. Click on **Settings** tab
3. Scroll down to **Pages** in the left sidebar
4. Under **Source**:
   - Select **Deploy from a branch**
   - Choose **gh-pages** branch
   - Select **/ (root)** folder
   - Click **Save**

### Step 2: Trigger First Deployment

The first deployment will happen automatically when you:
- Push code to the `main` or `master` branch, OR
- Manually trigger the workflow (see below)

### Step 3: Wait for Deployment

1. Go to the **Actions** tab in your repository
2. You should see a workflow run named "Deploy to GitHub Pages"
3. Wait for it to complete (usually 2-5 minutes)
4. Once complete, go to **Settings > Pages** to see your live URL

## 🚀 Deployment Methods

### Automatic Deployment (Recommended)

The app automatically deploys when you push to `main` or `master` branch:

```bash
git add .
git commit -m "Your changes"
git push origin main
```

### Manual Deployment

You can also trigger deployment manually:

1. Go to the **Actions** tab
2. Click on **Deploy to GitHub Pages** workflow
3. Click **Run workflow** button
4. Select the branch (usually `main`)
5. Click **Run workflow**

## 🔍 Monitoring Deployments

### Check Deployment Status

1. Go to **Actions** tab
2. Click on the latest workflow run
3. Expand the "Deploy to GitHub Pages" job to see detailed logs

### Common Issues

#### Seeing README instead of the app

This usually means the workflow hasn't run yet or the app hasn't been built:

**Solution:**
1. Check if the `gh-pages` branch exists: Go to your repository and click on the branch dropdown
2. If `gh-pages` doesn't exist yet:
   - Merge your changes to the `main` branch to trigger the workflow
   - Wait 5-10 minutes for the first deployment
   - Go to **Actions** tab to monitor the workflow progress
3. If `gh-pages` exists but still showing README:
   - Go to **Settings > Pages**
   - Ensure "Deploy from a branch" is selected
   - Ensure `gh-pages` branch and `/` (root) folder are selected
   - Clear your browser cache (Ctrl+Shift+R or Cmd+Shift+R)
4. If the workflow failed:
   - Go to **Actions** tab
   - Click on the failed workflow run
   - Check the logs for errors

#### Deployment fails with permission error
- Go to **Settings > Actions > General**
- Scroll to **Workflow permissions**
- Select **Read and write permissions**
- Click **Save**

#### 404 Page Not Found
- Ensure the `base-href` in the workflow matches your repository name
- Current setting: `--base-href /bookreadapp/`
- Wait a few minutes after deployment for DNS propagation

#### Firebase not working
- Check that Firebase web configuration is correctly set in `lib/auth/firebase_options.dart`
- Ensure Firebase project allows the GitHub Pages domain in authorized domains

## 🌐 Accessing Your Deployed App

After successful deployment, your app will be available at:

**https://iamSaifulhassan.github.io/bookreadapp/**

## 📝 Technical Details

### Workflow File

The deployment is configured in `.github/workflows/deploy.yml`:

- **Trigger**: Push to main/master branch or manual trigger
- **Flutter Version**: 3.27.2 (stable channel)
- **Build Command**: `flutter build web --release --base-href /bookreadapp/`
- **Jekyll Processing**: Disabled via `.nojekyll` file (added automatically)
- **Deploy Target**: gh-pages branch
- **Deployment Tool**: peaceiris/actions-gh-pages@v3

### .nojekyll File

The workflow automatically creates a `.nojekyll` file in the build output. This is crucial because:
- GitHub Pages uses Jekyll by default to process static sites
- Jekyll ignores files and folders starting with underscores
- Flutter web apps have critical files like `flutter.js` and folders like `_flutter` that start with underscores
- Without `.nojekyll`, these files would be ignored, breaking the app

### Base Href Configuration

The `--base-href /bookreadapp/` flag is crucial for proper routing on GitHub Pages. This ensures:
- Assets load correctly
- Navigation works properly
- Deep linking functions as expected

If you rename your repository, update this value in `.github/workflows/deploy.yml` to match the new repository name.

## 🔐 Security Considerations

### Firebase API Keys

The Firebase configuration contains API keys that are visible in the source code. This is normal for web apps:
- Firebase API keys are not secret
- Security is enforced through Firebase Security Rules
- Review and configure Firebase Security Rules in your Firebase Console

### GitHub Actions Secrets

The workflow uses `GITHUB_TOKEN` which is automatically provided by GitHub Actions. No manual secret configuration is needed.

## 🔄 Updating the Deployment

### Changing Repository Name

If you rename your repository:

1. Update `.github/workflows/deploy.yml`:
   ```yaml
   run: flutter build web --release --base-href /NEW_REPO_NAME/
   ```

2. Update the URL in documentation (README.md, etc.)

### Changing Branch

To deploy from a different branch:

1. Update `.github/workflows/deploy.yml`:
   ```yaml
   on:
     push:
       branches:
         - YOUR_BRANCH_NAME
   ```

## 📞 Support

If you encounter issues:

1. Check the Actions tab for error logs
2. Review Firebase Console for authentication/database issues
3. Verify GitHub Pages settings are correct
4. Check that all dependencies support web platform

## 🎉 Success!

Once setup is complete, your Flutter app will automatically deploy to GitHub Pages with every push to the main branch!
