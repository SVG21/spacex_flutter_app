# 🚀 SpaceX Launch Tracker

A Flutter application that fetches and displays SpaceX launch data using the SpaceX API.  
It includes a launch list, launch details, and filtering by year, showcasing API integration, clean architecture, and state management with Riverpod.

---

## 📌 Features
- List of SpaceX launches (Mission name, launch date, success/failure status, mission patch)
- Launch Detail Screen (Displays full-sized mission patch, details, and launch status)
- Filter launches by year (Dropdown menu)
- Pull-to-refresh functionality
- Error handling with retry mechanism
- Riverpod for state management (Lightweight, efficient)
- API Integration with SpaceX API v5

---

## 📌 Setup Instructions

1. Install Flutter & Dart ([Guide](https://docs.flutter.dev/get-started/install))
2. Navigate to the Project Folder
3. Install Dependencies:
   ```sh
   flutter pub get
4. Run the Application
   ```sh
   flutter run

---

## 📌 Folder Structure

* [lib](./lib)
   * [models](./lib/models) - Data models (Launch)
   * [providers](./lib/providers) - State management (Riverpod)
   * [services](./lib/services) - API service (SpaceX API)
   * [views](./lib/views) - UI Screens (Launch List, Launch Details)
   * [widgets](./lib/widgets) - Reusable UI components
   * [utils](./lib/utils) - Helper functions (Date formatting)
   * [main.dart](./lib/main.dart) - Application entry point
* [pubspec.yaml](./pubspec.yaml) - Project dependencies
* [README.md](./README.md) - Documentation

---

## 📌 Technical Choices & Architecture

### State Management: Riverpod

- Used Riverpod for simplicity, performance, and testability.
- `FutureProvider` for managing API calls.
- `StateProvider` for managing selected year filters.

### API Integration

- Fetches SpaceX launch data from SpaceX API v5.
- `GET /launches` → Fetches all launches.
- `GET /launches/{id}` → Fetches details of a specific launch.

### UI Handling

- If a **mission patch image** is not available, a **default rocket icon** (`Icons.rocket_launch`) is displayed instead.
- Ensures that the layout remains consistent and properly aligned even when an image is missing.

### Error Handling

- Displays an error message with a retry button on network failure.
- Handles missing data with placeholders.


---

## 📌 Assumptions & Trade-offs

| **Assumption / Trade-off** | **Justification** |
|----------------------------|-------------------|
| **Using Riverpod instead of Provider or Bloc** | Riverpod is simpler, has better performance, and avoids unnecessary boilerplate code. |
| **Using `FutureProvider` instead of caching data locally** | Keeps data fresh on every request instead of using a local database. |
| **Displaying a default icon when mission patch is missing** | Ensures consistent UI structure without shifting elements. |
| **Minimal UI customization** | Focus is on functionality rather than complex styling or animations. |
| **Not implementing infinite scrolling** | SpaceX API returns a manageable dataset, so pagination is not necessary. |

---

## 📌 Credits

SpaceX API: https://github.com/r-spacex/SpaceX-API
Flutter Documentation: https://flutter.dev
