# Google Sign-In — OneAI

## 1. Overview

OneAI uses **Firebase Authentication** with **Google Sign-In** as an authentication provider.

The implementation follows the existing **Stacked architecture**, keeping authentication logic inside `AuthService` and exposing it to the UI through the `SignupViewModel`.

### Authentication flow

```text
SignupView
    │
    │ User taps "Continue with Google"
    ▼
SignupViewModel
    │
    │ signInWithGoogle()
    ▼
AuthService
    │
    ├── GoogleSignIn
    │       │
    │       ▼
    │   Google Account
    │       │
    │       ▼
    │   Google ID Token
    │
    └── FirebaseAuth
            │
            ▼
       Firebase User
```

---

# 2. Firebase Project

The existing **OneAI Firebase project** is used for authentication.

The Flutter project was already configured against this Firebase project.

### Configured Firebase platforms

The Firebase project contains:

* Android
* iOS
* Web
* macOS

The following configuration files are present in the Flutter project:

```text
lib/firebase_options.dart
android/app/google-services.json
```

`firebase_options.dart` contains the Firebase configuration for the supported Flutter platforms.

`google-services.json` contains the Android Firebase application configuration.

---

# 3. Firebase CLI / FlutterFire

The following tooling is used:

```text
Flutter
Firebase CLI
FlutterFire CLI
```

The Firebase project can be verified using:

```bash
firebase projects:list
```

FlutterFire configuration can be performed from the Flutter project root using:

```bash
flutterfire configure
```

This command associates the Flutter application with a Firebase project and generates/updates platform configuration such as:

```text
lib/firebase_options.dart
```

and the corresponding native Firebase configuration.

> The existing OneAI project was already configured, so `flutterfire configure` was not rerun unnecessarily.

---

# 4. Firebase Authentication Configuration

Google was enabled as an authentication provider in:

```text
Firebase Console
    → Authentication
    → Sign-in method
    → Google
```

Google provider configuration requires a project support email.

After enabling Google, Firebase Authentication is capable of accepting Google credentials from the Flutter application.

---

# 5. Android SHA Certificate Configuration

During initial testing, Google account selection appeared successfully, but authentication failed with:

```text
GoogleSignInExceptionCode.canceled
```

The Android log also contained:

```text
CredManProvService:
GetCredentialResponse error returned from framework
```

The issue was caused by the **Android SHA certificate fingerprints not being registered in the Firebase Android application configuration**.

### Generate SHA fingerprints

From the Flutter project:

```bash
cd android
./gradlew signingReport
```

The output contains fingerprints for the different build variants:

```text
SHA1
SHA-256
```

The appropriate fingerprints were added in:

```text
Firebase Console
    → Project Settings
    → Your apps
    → Android app
    → SHA certificate fingerprints
```

After adding the SHA fingerprints, Google Sign-In worked successfully.

### Important

When configuring Google Sign-In for Android, the following must correspond correctly:

```text
Flutter Android application
        │
        ├── Application ID
        │
        └── SHA-1 / SHA-256
                │
                ▼
        Firebase Android App
                │
                ▼
          Google OAuth
```

If the SHA fingerprint is missing or incorrect, Google Sign-In may fail after the user selects an account.

---

# 6. Flutter Dependencies

The project already contains the required Firebase and Google authentication packages:

```yaml
dependencies:
  firebase_core:
  firebase_auth:
  google_sign_in:
```

Responsibilities:

| Package          | Responsibility                                          |
| ---------------- | ------------------------------------------------------- |
| `firebase_core`  | Initializes Firebase                                    |
| `firebase_auth`  | Handles Firebase authentication and authenticated users |
| `google_sign_in` | Handles Google account authentication                   |

---

# 7. Firebase Initialization

Firebase is initialized during application startup in `main.dart`:

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GoogleSignIn.instance.initialize();

  await setupLocator();
  await locator<ThemeService>().init();

  setupDialogUi();
  setupBottomSheetUi();

  runApp(const MyApp());
}
```

There are two separate initialization steps:

```dart
Firebase.initializeApp(...)
```

Initializes Firebase.

```dart
GoogleSignIn.instance.initialize()
```

Initializes the Google Sign-In SDK.

Both are performed before `runApp()`.

---

# 8. Stacked Dependency Injection

The application uses Stacked's annotation-based dependency injection.

`AuthService` is registered in `app.dart`:

```dart
@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: SignupView, initial: true),
    MaterialRoute(page: ChatView),
    MaterialRoute(page: UserProfileView),
    MaterialRoute(page: ModelSelectView),
    MaterialRoute(page: SubscriptionView),
    MaterialRoute(page: ProjectView),
    MaterialRoute(page: AllChatView),
  ],

  dependencies: [
    Singleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: ThemeService),
    LazySingleton(classType: ModelSelectionService),
    LazySingleton(classType: AuthService),
  ],
)
class App {}
```

After modifying `app.dart`, regenerate the Stacked generated files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

`app.locator.dart` should not be manually modified.

---

# 9. AuthService

Authentication logic is isolated in:

```text
lib/services/auth/auth_service.dart
```

The service is responsible for:

* Google authentication
* Firebase authentication
* Sign out
* Accessing the current Firebase user

Current implementation:

```dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser =
          await _googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      final AuthCredential credential =
          GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(
        credential,
      );

      return userCredential.user;
    } on FirebaseAuthException {
      rethrow;
    } on GoogleSignInException {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  User? get currentUser => _firebaseAuth.currentUser;
}
```

---

# 10. Google Authentication Process

The implementation uses the current `google_sign_in` API.

### Step 1 — Authenticate with Google

```dart
final GoogleSignInAccount googleUser =
    await _googleSignIn.authenticate();
```

This launches the Google account selection flow.

The user selects a Google account.

---

### Step 2 — Obtain Google authentication information

```dart
final GoogleSignInAuthentication googleAuth =
    googleUser.authentication;
```

The Google authentication object provides the ID token used for Firebase authentication.

---

### Step 3 — Create Firebase credential

```dart
final AuthCredential credential =
    GoogleAuthProvider.credential(
  idToken: googleAuth.idToken,
);
```

The Google ID token is converted into a Firebase `AuthCredential`.

---

### Step 4 — Authenticate with Firebase

```dart
final UserCredential userCredential =
    await _firebaseAuth.signInWithCredential(
  credential,
);
```

Firebase verifies the Google credential and creates or retrieves the corresponding Firebase user.

The resulting Firebase user is:

```dart
userCredential.user
```

---

# 11. ViewModel Integration

The authentication service is injected into `SignupViewModel` through the Stacked locator:

```dart
final authService = locator<AuthService>();
```

The ViewModel exposes the authentication action to the UI:

```dart
Future<void> signInWithGoogle() async {
  if (isBusy) return;

  setBusy(true);

  try {
    final user = await authService.signInWithGoogle();

    if (user != null) {
      debugPrint('Google Sign-In successful');
      debugPrint('UID: ${user.uid}');
      debugPrint('Email: ${user.email}');
      debugPrint('Name: ${user.displayName}');

      // Navigation after successful login
    }
  } on GoogleSignInException catch (e) {
    debugPrint(
      'Google Sign-In error: ${e.code}',
    );
  } on FirebaseAuthException catch (e) {
    debugPrint(
      'Firebase Auth error: ${e.code} - ${e.message}',
    );
  } catch (e) {
    debugPrint(
      'Unexpected authentication error: $e',
    );
  } finally {
    setBusy(false);
  }
}
```

`isBusy` prevents multiple authentication requests while an existing Google authentication request is running.

---

# 12. UI Responsibility

The login/signup UI should not directly interact with:

```text
GoogleSignIn
FirebaseAuth
GoogleAuthProvider
```

Instead, the button calls the ViewModel:

```dart
onPressed: viewModel.isBusy
    ? null
    : viewModel.signInWithGoogle,
```

The responsibility separation is:

```text
SignupView
    │
    │ UI event
    ▼
SignupViewModel
    │
    │ Authentication request
    ▼
AuthService
    │
    ├── GoogleSignIn
    └── FirebaseAuth
```

This keeps the UI independent of the authentication implementation.

---

# 13. Successful Authentication

After successful authentication:

```dart
final user = await authService.signInWithGoogle();
```

the Firebase user contains information such as:

```dart
user.uid
user.email
user.displayName
user.photoURL
```

The authenticated user can also be accessed later through:

```dart
FirebaseAuth.instance.currentUser
```

or through the service:

```dart
authService.currentUser
```

Firebase Console can be used to verify the authenticated account:

```text
Firebase Console
    → Authentication
    → Users
```

The Google account should appear as a Firebase user with Google as the provider.

---

# 14. Sign Out

Sign-out is handled by the `AuthService`:

```dart
Future<void> signOut() async {
  await _googleSignIn.signOut();
  await _firebaseAuth.signOut();
}
```

Both Google Sign-In and Firebase Authentication are explicitly signed out.

---

# 15. Architecture Summary

The final architecture is:

```text
                         SignupView
                             │
                             │ User taps Google
                             ▼
                    SignupViewModel
                             │
                             │ signInWithGoogle()
                             ▼
                        AuthService
                         │       │
                         │       │
                         ▼       ▼
                   GoogleSignIn FirebaseAuth
                         │       │
                         ▼       │
                   Google Account│
                         │       │
                         ▼       │
                     ID Token    │
                         │       │
                         └───┬───┘
                             ▼
                       Firebase Auth
                             │
                             ▼
                       Firebase User
```

This structure also allows additional authentication providers to be added without moving authentication logic into the UI.

---

# 16. Future Apple Sign-In

Apple Sign-In will be implemented using the same service-oriented architecture.

The intended structure will be:

```text
                       AuthService
                       /          \
                      /            \
             Google Login       Apple Login
                  │                  │
                  ▼                  ▼
             Google SDK          Apple SDK
                  │                  │
                  └────────┬─────────┘
                           ▼
                      FirebaseAuth
```

The ViewModel can continue to expose simple actions such as:

```dart
signInWithGoogle()
signInWithApple()
```

while the provider-specific implementation remains inside `AuthService`.

---

# 17. Troubleshooting Checklist

If Google Sign-In opens the account picker but fails after selecting an account, verify the following:

### Android package name

Verify the Flutter Android application ID:

```text
android/app/build.gradle
```

or:

```text
android/app/build.gradle.kts
```

### SHA fingerprints

Generate them with:

```bash
cd android
./gradlew signingReport
```

Verify that the required SHA-1 and SHA-256 fingerprints are registered in Firebase.

### Firebase Android configuration

Verify:

```text
android/app/google-services.json
```

belongs to the same Firebase project and Android application.

### Firebase Google provider

Verify:

```text
Firebase Console
→ Authentication
→ Sign-in method
→ Google
→ Enabled
```

### Firebase initialization

Verify:

```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

runs before authentication.

### Google Sign-In initialization

Verify:

```dart
await GoogleSignIn.instance.initialize();
```

runs before calling:

```dart
GoogleSignIn.instance.authenticate();
```

---

# 18. Current Status

| Component                         | Status                          |
| --------------------------------- | ------------------------------- |
| Firebase project                  | ✅ Configured                    |
| FlutterFire configuration         | ✅ Existing configuration reused |
| Android app                       | ✅ Configured                    |
| iOS app                           | ✅ Configured                    |
| Web app                           | ✅ Configured                    |
| macOS app                         | ✅ Configured                    |
| Firebase Authentication           | ✅ Enabled                       |
| Google provider                   | ✅ Enabled                       |
| Android SHA fingerprints          | ✅ Added                         |
| `firebase_core`                   | ✅ Available                     |
| `firebase_auth`                   | ✅ Available                     |
| `google_sign_in`                  | ✅ Available                     |
| Firebase initialization           | ✅ Implemented                   |
| Google Sign-In initialization     | ✅ Implemented                   |
| `AuthService`                     | ✅ Implemented                   |
| Stacked DI                        | ✅ Implemented                   |
| Google account authentication     | ✅ Tested                        |
| Firebase user creation            | ✅ Verified                      |
| Persistent startup authentication | ⏳ Next                          |
| Complete logout flow              | ⏳ Next                          |
| Apple Sign-In                     | ⏳ Future                        |

## Key Takeaway

The Google authentication implementation follows this principle:

> **The View handles UI, the ViewModel handles UI state and orchestration, and `AuthService` handles authentication-specific logic.**

This keeps the authentication implementation independent of the UI and provides a clean foundation for adding **Apple Sign-In** later.
