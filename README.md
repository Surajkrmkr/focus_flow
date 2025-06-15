# 🚀 FocusFlow

**FocusFlow** is a modern and minimal task manager application built with Flutter and powered by Firebase. Designed to help users manage their daily tasks efficiently, the app supports user authentication, real-time task updates, and a sleek light UI with smooth interactions.

---

## 🌟 Features

- 🔐 **Firebase Authentication** – Secure login and sign-up support
- ✅ **Task Management** – Add, edit, delete, and mark tasks as completed
- 🔄 **Real-Time Sync** – Tasks sync live using Firestore
- 🎨 **Modern UI** – Clean, gradient, light-mode design
- 🧱 **Modular Codebase** – Clean architecture with GetX state management
- 🧪 **Unit & Widget Tests** – Ensures code quality and reliability

---

## 🛠️ Getting Started

### 📦 Prerequisites

Ensure you have the following installed:

- Flutter SDK (`3.10+`)
- Dart
- Firebase CLI
- Android Studio / Xcode / VS Code
- A Firebase project with Email/Password Auth and Firestore enabled

### 🔧 Setup Instructions

1. **Clone the repository**

   ```bash
   git clone https://github.com/surajkrmkr/focus_flow.git
   cd focusflow
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Connect Firebase**

   - Create a project on [Firebase Console](https://console.firebase.google.com/)
   - Enable **Email/Password Authentication**
   - Enable **Cloud Firestore**
   - Download the `google-services.json` (for Android) and/or `GoogleService-Info.plist` (for iOS)
   - Place them in the appropriate platform directories:

     - `android/app/google-services.json`
     - `ios/Runner/GoogleService-Info.plist`

4. **Run the app**

   ```bash
   flutter run
   ```

---

## 🧪 Running Tests

To run unit tests:

```bash
flutter test
```

---

## 📁 Project Structure

```
lib/
├── data/
│   ├── models/
│   ├── services/
│   └── repositories/
├── presentation/
│   ├── controllers/
│   ├── screens/
│   └── widgets/
├── main.dart
test/
```

---

## 💡 Additional Notes

- **State Management:** The app uses **GetX** for routing and reactive state handling.
- **Error Handling:** Errors during login/signup are displayed using `Get.snackbar`.
- **Unit Tests:** Services and controllers are unit tested using mock implementations.
- **Widget Separation:** UI is built using reusable widgets to improve readability and testability.

---

## 📷 Screenshots (Optional)

### Login Flow

![Sample Video](https://github.com/Surajkrmkr/focus_flow/raw/main/screenshots/login.mov)

### Task Management

![Sample Video](https://github.com/Surajkrmkr/focus_flow/raw/main/screenshots/task.mov)

---

## 📝 To-Do

* [ ] **Google Sign-In Integration**
  Add support for signing in via Google for easier access.

* [ ] **Push Notifications**
  Notify users about pending or due tasks using Firebase Cloud Messaging (FCM).

* [ ] **Task Reminders & Deadlines**
  Allow users to set deadlines and receive scheduled reminders.

* [ ] **Task Categories or Tags**
  Enable filtering tasks by categories (e.g., Work, Personal, Urgent).

* [ ] **Search & Sort Tasks**
  Provide functionality to search and sort tasks by date, status, or title.

* [ ] **Local Storage Fallback**
  Implement offline task saving and sync when back online.

* [ ] **Dark/Light Theme Toggle**
  Let users switch between themes manually.

* [ ] **Profile Management**
  Allow users to view and update their profile information and profile picture.

* [ ] **Unit Tests Expansion**
  Add more comprehensive test coverage for controller logic and error scenarios.

* [ ] **Settings Page**
  Add app settings such as notification preferences, theme toggle, etc.

---
