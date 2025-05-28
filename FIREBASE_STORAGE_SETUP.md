# Firebase Storage Setup for Profile Images

## Overview
This implementation adds image picker functionality to the Edit Profile screen with Firebase Storage integration for storing and retrieving profile images.

## Prerequisites
1. Firebase project with Authentication and Storage enabled
2. Flutter project already configured with Firebase
3. Required dependencies installed

## Installation Steps

### 1. Install Dependencies
Run the following command in your project root:
```bash
flutter pub get
```

The following packages have been added to `pubspec.yaml`:
- `firebase_storage: ^11.7.7` - For Firebase Storage integration
- `image_picker: ^1.1.2` - For camera and gallery image selection

### 2. Firebase Storage Configuration

#### Enable Firebase Storage
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Navigate to "Storage" in the left sidebar
4. Click "Get started"
5. Choose your storage location
6. Set up security rules (see below)

#### Storage Security Rules
Update your Firebase Storage rules to allow authenticated users to upload profile images:

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // Allow authenticated users to upload/read their own profile images
    match /profile_images/{fileName} {
      allow read, write: if request.auth != null && 
        request.auth.uid == resource.metadata.userId;
    }
    
    // Allow authenticated users to upload new profile images
    match /profile_images/{fileName} {
      allow create: if request.auth != null && 
        request.auth.uid == request.resource.metadata.userId;
    }
  }
}
```

### 3. Platform-Specific Setup

#### Android Permissions
Permissions have been added to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
```

#### iOS Permissions (if targeting iOS)
Add the following to `ios/Runner/Info.plist`:
```xml
<key>NSCameraUsageDescription</key>
<string>This app needs access to camera to take profile pictures</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs access to photo library to select profile pictures</string>
```

## Features Implemented

### 1. Image Picker Service (`lib/services/image_picker_service.dart`)
- Camera capture functionality
- Gallery selection functionality
- Image quality optimization (max 1024x1024, 85% quality)
- Bottom sheet UI for source selection

### 2. Firebase Storage Service (`lib/services/firebase_storage_service.dart`)
- Upload profile images with user-specific paths
- Download URL retrieval
- Image deletion functionality
- Automatic metadata tagging with user ID and timestamp

### 3. Edit Profile Screen Updates
- Profile photo preview (local file or network image)
- Upload progress indicator
- Error handling for upload failures
- Success feedback on completion

### 4. Profile Screen Updates
- Automatic profile image loading on screen initialization
- Network image display with fallback to default icon
- Profile data updates including image URL

## Usage

### Taking/Selecting Profile Picture
1. Open Edit Profile screen
2. Tap the camera icon on the profile picture
3. Choose "Take Photo" or "Choose from Gallery"
4. Image is automatically uploaded to Firebase Storage
5. Success message is shown when upload completes

### Viewing Profile Picture
- Profile pictures are automatically loaded when viewing the Profile screen
- Images are cached by the network image widget for better performance

## Error Handling
- Network connectivity issues
- Firebase Storage upload failures
- Image picker cancellation
- Authentication state validation

## Security Considerations
- Only authenticated users can upload images
- Images are stored with user-specific paths
- File size and quality optimization to reduce storage costs
- Automatic cleanup of old profile images (can be enhanced)

## Next Steps
1. Add image compression for better performance
2. Implement offline caching strategy
3. Add image cropping functionality
4. Integrate with user profile data persistence
5. Add BLoC pattern for state management
6. Implement automatic cleanup of old profile images

## Troubleshooting

### Common Issues
1. **Firebase Storage rules error**: Ensure your security rules allow authenticated users to read/write
2. **Permission denied**: Check platform-specific permissions are properly configured
3. **Image not showing**: Verify Firebase Storage is properly initialized and user is authenticated
4. **Upload failures**: Check network connectivity and Firebase Storage configuration

### Debug Commands
```bash
# Check dependencies
flutter pub deps

# Clean and rebuild
flutter clean && flutter pub get

# Check for platform-specific issues
flutter doctor
```
