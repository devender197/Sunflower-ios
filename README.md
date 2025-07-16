# Sunflower iOS App 🌻

This project is an iOS version of the popular Android [Sunflower demo app](https://github.com/android/sunflower), showcasing modern iOS development practices with **SwiftUI**. It's a great resource for developers looking to understand how to build a production-quality iOS app, especially those familiar with Android's Jetpack Compose.

## About The Project

The Sunflower iOS app is a gardening app that helps you identify plants, learn how to care for them, and keep track of the plants in your garden. It's built entirely in Swift and uses the latest iOS technologies.

One of the key aspects of this project is its architectural similarity to the original Android Sunflower app, which uses Jetpack Compose for its UI. This iOS version demonstrates how the declarative UI paradigm of SwiftUI can be used to create a user experience that is both beautiful and highly performant, much like its Compose UI counterpart. This makes it an excellent case study for developers interested in cross-platform development or those transitioning from Android to iOS development.

## Core Technologies

* **SwiftUI:** The entire user interface is built using Apple's modern, declarative UI framework.
* **SwiftData:** For persisting data locally, providing a seamless and powerful way to manage the app's data.
* **MVVM (Model-View-ViewModel):** The app follows the MVVM architectural pattern to ensure a clean separation of concerns and a scalable codebase.

## Class Descriptions

Here's a breakdown of the key classes and their roles in the Sunflower iOS app:

### Application
- **`Sunflower_iosApp.swift`**: The main entry point of the application. It sets up the main window and initializes the `ContentView`.

### Views (UI)
- **`ContentView.swift`**: The root view of the app, which embeds the `HomeScreen`.
- **`HomeScreen.swift`**: The main screen of the app, featuring a tabbed view to switch between "My Garden" and the "Plant List". It uses a `PlantViewModel` to manage its state.
- **`PlantList.swift`**: Displays a grid of available plants that users can add to their garden. It gets its data from the `PlantViewModel`.
- **`Planted.swift`**: This view shows the plants that the user has added to their garden. It uses `@Query` to fetch the planted items directly from SwiftData.
- **`PlantDetailScreen.swift`**: Provides detailed information about a specific plant, including its name, description, and watering needs. It also allows the user to add the plant to their garden.
- **`CustomTopTabbedView.swift`**: A reusable custom view for the tabbed layout on the `HomeScreen`.
- **`PlantCardView.swift`**: A reusable card view to display a plant's image and name in the `PlantList` and `Planted` screens.

### ViewModels
- **`PlantViewModel.swift`**: An `ObservableObject` that fetches the list of plants from a local JSON file and provides it to the views. It ensures that the plant data is loaded only once.

### Models
- **`Plant.swift`**: A `Codable` and `Identifiable` class that represents a plant. It is also a SwiftData `@Model`, which means it can be persisted in the local database.

### API Layer
- **`ApiClient.swift`**: A generic API client for making network requests. While the current version loads data from a local JSON file, this class is designed to be easily extended to fetch data from a remote server.
- **`ApiClientProtocol.swift`, `GetRequestModel.swift`, `PostRequestModel.swift`, `GithubErrors.swift`**: These files define the protocols and models for the API layer, making it robust and easy to test.

### Extensions and Utilities
- **`ApiRequestType.swift`, `DateExtension.swift`**: Useful extensions to simplify API requests and date handling.
- **`Constants.swift`**: A centralized place to store constants used throughout the app.

## A Note on a Familiar Structure

For developers coming from an Android background, the structure of this SwiftUI app will feel remarkably familiar to that of a modern Android app built with Jetpack Compose. Both frameworks embrace a declarative approach to UI development, which leads to similar architectural patterns.

- **Composable Functions vs. SwiftUI Views:** What are `@Composable` functions in Jetpack Compose are essentially `View` structs in SwiftUI. Both are lightweight, reusable components that describe a piece of the UI.
- **State Management:** Both frameworks use a similar state management system. In Compose, you might use `remember { mutableStateOf(...) }`, while in SwiftUI you'll use the `@State` property wrapper. For more complex state management, both have view model-like constructs (`ViewModel` in Android and `@StateObject` or `@ObservedObject` in SwiftUI).
- **Navigation:** While the specific APIs are different, the conceptual approach to navigation is similar. Both frameworks provide a way to define a navigation graph and move between screens in a type-safe manner.

This project serves as a practical example of how your knowledge of modern Android development can be leveraged to quickly become proficient in building beautiful and robust iOS applications with SwiftUI.

## How to Run

1. Clone the repository: `git clone https://github.com/your-username/sunflower-ios.git`
2. Open the project in Xcode.
3. Select a simulator or a physical device.
4. Build and run the app.
