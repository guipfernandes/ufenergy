# UFenerGy

An application for UFG energy control

## Requirements
- Android Studio
- Android SDK (Installed with Android Studio)
- Flutter SDK

## Configuration
```console
flutter pub get
```

- Create an .env file based on the .env.template file
- Create an environment variable MAPS_API_KEY with the value of the API Key created for the Maps SDK for Android on Google Cloud Platform

## Release
### Git Flow (Release start)
- On develop
```git
git flow release start {version}
```

##### Update `pubspec.yaml`:
- Version: 1.0.1+2 -> [versionName]+[versionCode]
    - [versionName]: 1.0.1 (Major.Minor.Patch)
    - [versionCode]: Bump 1 in each new release

##### Git Flow (Release finish)
```git
git commit -am "{version}"
git flow release finish {version}
```

##### Build
- Need key.properties to generate release version (Available on Google Drive)
```console
flutter clean
flutter build appbundle --release
```

##### Git (Push to remote origin)
```git
git push --follow-tags origin master develop
```
