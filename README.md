# ExchangeCurrencyApp

## Overview
ExchangeCurrencyApp is a simple iOS application to display currency exchange rates. Users can view exchange rates, mark specific rates as favorites, and access these rates offline.

## How to Build & Run
1. Clone the repository.
2. Open `ExchangeCurrencyApp.xcodeproj`.
3. Add your SWOP API key to the Keychain via the `KeychainHelper`.
4. Build and run the app.

## Architecture
- **MVVM:** Ensures separation of concerns and testable components.
- **Coordinator Pattern:** Manages navigation and flow between screens, improving modularity.
- **Core Data:** Used for offline storage.
- **Combine:** For reactive binding between ViewModel and Views.

## App Structure
- **Models:** Define the data structures (`CurrencyRate`).
- **ViewModels:** Handle business logic and data fetching.
- **Views:** Present data using UIKit components.
- **Coordinators:** Manage navigation (ApplicationCoordinator, CurrencyRatesCoordinator).
- **Networking:** Manages API interactions using `URLSession`.
- **Persistence:** Handles offline storage with Core Data.

## Offline Mode
- Fetched exchange rates are saved to Core Data.
- Favorites are marked with a boolean flag and stored locally.
- When offline, the app uses Core Data for displaying rates.

## Libraries/Tools
- UIKit
- Combine
- Core Data
- Keychain
- SnapKit
