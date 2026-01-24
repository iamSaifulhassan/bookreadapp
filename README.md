# BookRead App

A Flutter-based book reading application with Firebase integration.

## 🌐 Live Demo

The app is automatically deployed to GitHub Pages: [https://iamSaifulhassan.github.io/bookreadapp/](https://iamSaifulhassan.github.io/bookreadapp/)

## 🚀 Deployment

This app is automatically deployed to GitHub Pages using GitHub Actions.

### How it works:

1. Every push to the `main` or `master` branch triggers the deployment workflow
2. The workflow builds the Flutter web app with the correct base path
3. The built files are automatically deployed to the `gh-pages` branch
4. GitHub Pages serves the app from the `gh-pages` branch

### Setting up GitHub Pages (One-time setup):

To enable GitHub Pages for this repository:

1. Go to your repository settings: `https://github.com/iamSaifulhassan/bookreadapp/settings/pages`
2. Under "Source", select **Deploy from a branch**
3. Select the **gh-pages** branch and **/ (root)** folder
4. Click **Save**
5. Wait a few minutes for the deployment to complete
6. Your app will be available at: `https://iamSaifulhassan.github.io/bookreadapp/`

### Manual Deployment:

You can also trigger a manual deployment:

1. Go to the Actions tab in your repository
2. Select the "Deploy to GitHub Pages" workflow
3. Click "Run workflow"
4. Select the branch to deploy from
5. Click "Run workflow"

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
