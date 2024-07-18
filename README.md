# News App with Riverpod

This is a Flutter application that displays news articles fetched from an API and allows users to save their favorite articles. The app uses Riverpod for state management and persists saved articles to a local Sembast database. Additionally, the app automatically fetch fresh content from the API to check if there is new top headlines. Unit tests are included in the project.

## Features

1. **Save News Items**: Users can save news articles by tapping the "save" or "favorite" icon button available on each article. Saved articles are persisted to a local SQLite database.
2. **Auto-Refresh**: The application auto-refreshes to fetch fresh content from the API using a suitable background worker/service strategy.
3. **Unit Tests**: The project includes unit tests to ensure the functionality of the application.

## Getting Started

### Prerequisites

- Flutter SDK: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- Dart: [Dart Installation Guide](https://dart.dev/get-dart)
- IDE: [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)

### Installation

1. **Clone the repository:**

   ```sh
   git clone https://github.com/fjoshalv/newsRiverpod.git
   cd news-app-riverpod
   ```

2. **Install dependencies:**

   ```sh
   flutter pub get
   ```

3. **Setup .env file:**

   Create a file named `.env` in the `assets` directory with the following keys:

   ```
   NEWS_API_URL=<your_news_api_url>
   NEWS_API_KEY=<your_news_api_key>
   ```

4. **Run the application:**

   ```sh
   flutter run
   ```

## Directory Structure

```
lib/
│
├── main.dart
├── src/
│   ├── feature/
│   │   ├── data
│   │   ├── domain
│   │   ├── application
│   │   ├── presentation
│   ├── design/
│   ├── routing/
│   ├── shared/
│   ├── utils/
│   ├── app.dart
│
├── tests/
│    ├── src/
│    │   │  feature/
│    │   │   ├── data
│    │   │   ├── domain
│    │   │   ├── application
│    │   │   ├── presentation
│    │   │  shared/
│    │   │  mocks.dart
```

## Running Tests

To run the unit tests, use the following command:

```sh
flutter test
```

## Contributions

Contributions are welcome! Please fork the repository and submit a pull request for any changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
