# BookRead App

A Flutter-based book reading application with Firebase integration.

## 🌐 Live Demo

The app is automatically deployed to GitHub Pages: [https://iamSaifulhassan.github.io/bookreadapp/](https://iamSaifulhassan.github.io/bookreadapp/)

> **Note**: The app will be deployed automatically when changes are merged to the `main` branch. If you're seeing the README instead of the app, please wait for the first deployment to complete (about 5 minutes after merging). See [GITHUB_PAGES_SETUP.md](GITHUB_PAGES_SETUP.md) for detailed setup instructions and troubleshooting.

## 🚀 Deployment

This app is automatically deployed to GitHub Pages using GitHub Actions.

### How it works:

1. Every push to the `main` or `master` branch triggers the deployment workflow
2. The workflow builds the Flutter web app with the correct base path (`/bookreadapp/`)
3. A `.nojekyll` file is added to prevent GitHub Pages from processing the app with Jekyll
4. The built files are automatically deployed to the `gh-pages` branch
5. GitHub Pages serves the app from the `gh-pages` branch

### First-time Setup:

**Important**: Complete these steps to enable GitHub Pages for this repository:

1. Go to your repository settings: `https://github.com/iamSaifulhassan/bookreadapp/settings/pages`
2. Under "Source", select **Deploy from a branch**
3. Select the **gh-pages** branch and **/ (root)** folder
4. Click **Save**
5. Merge any changes to the `main` branch to trigger the first deployment
6. Wait 5-10 minutes for the initial deployment to complete
7. Your app will be available at: `https://iamSaifulhassan.github.io/bookreadapp/`

For detailed setup instructions and troubleshooting, see [GITHUB_PAGES_SETUP.md](GITHUB_PAGES_SETUP.md).

### Manual Deployment:

You can also trigger a manual deployment:

1. Go to the [Actions tab](https://github.com/iamSaifulhassan/bookreadapp/actions) in your repository
2. Select the "Deploy to GitHub Pages" workflow
3. Click "Run workflow"
4. Select the branch to deploy from (usually `main`)
5. Click "Run workflow"
6. Wait for the workflow to complete (check for a green checkmark ✅)

## 🛠️ Local Development

### Prerequisites:

- Flutter SDK (3.27.2 or later)
- Dart SDK
- Firebase account

### Setup:

1. Clone the repository:
   ```bash
   git clone https://github.com/iamSaifulhassan/bookreadapp.git
   cd bookreadapp
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run -d chrome
   ```

### Building for Web:

To build the web version locally:

```bash
flutter build web --release --base-href /bookreadapp/
```

The built files will be in the `build/web` directory.

## 📱 Features

- Firebase Authentication (Email/Password, Google Sign-In)
- Book management (Downloads, Favorites, To-Read, Completed)
- PDF viewing
- Text-to-speech
- Offline support
- User profiles and settings

## 🏗️ Architecture

The app follows the BLoC (Business Logic Component) architecture pattern with a modular folder structure:

- `lib/auth/` - Authentication logic
- `lib/blocs/` - BLoC state management
- `lib/models/` - Data models
- `lib/repositories/` - Data repositories
- `lib/screens/` - UI screens
- `lib/services/` - Business services
- `lib/themes/` - App theming
- `lib/widgets/` - Reusable widgets

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 👥 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
