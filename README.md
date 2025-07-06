# Flutter Todo Clean Architecture

A Flutter todo application built with Clean Architecture principles, featuring BLoC state management, dual theme support, and CRUD operations.

## Features

- Create, Read, Update, Delete todos
- Filter todos by completed/uncompleted status
- Clean Architecture with layer separation
- BLoC state management for testability
- Dual theme support (Light/Dark)
- SQLite local storage

## Requirements

- Flutter 3.27.1
- Dart SDK
- Internet connection for initial setup

## Installation

1. Clone the repository:
```bash
git clone https://github.com/JagdishOnGH/todo_clean_arch.git
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate code:
```bash
dart run build_runner build
```

4. Run the app:
```bash
flutter run
```

**Note**: This app won't run on web as SQLite is not supported yet.

## Architecture

The app follows Clean Architecture principles with three main layers:

- **Presentation Layer**: UI components and BLoC state management
- **Domain Layer**: Business logic and use cases
- **Data Layer**: Repository implementations and data sources

This promotes:
- Separation of concerns
- Testability
- Maintainability
- Robust state management
