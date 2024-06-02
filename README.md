# NewsAPI Application

Welcome to the NewsAPI Application! This project demonstrates the implementation of a news application using the NewsAPI across four different architectural patterns: MVC, MVVM-C, VIP, and VIPER. Each branch of this repository showcases a different architecture to highlight various approaches to structuring an iOS application.

## Features

- Fetches the latest news from the NewsAPI.
- Displays news articles with titles, descriptions, and images.
- Supports different architectural patterns for comparison.

## Architectures

### [MVC (Model-View-Controller)](https://github.com/canamaemindevar/NewsApp/tree/MVC)
The MVC architecture is one of the most commonly used patterns. It separates the application into three main components: the Model, the View, and the Controller. This pattern is straightforward and easy to implement, making it suitable for smaller applications.

### [MVVM-C (Model-View-ViewModel-Coordinator)](https://github.com/canamaemindevar/NewsApp/tree/MVVM-C)
MVVM-C enhances the traditional MVVM pattern by introducing Coordinators to handle navigation and flow. This architecture provides better separation of concerns and improved testability, especially for complex applications.

### [VIP (View-Interactor-Presenter)](https://github.com/canamaemindevar/NewsApp/tree/VIP)
The VIP pattern breaks down the components into more granular roles, making the code more modular and testable. It emphasizes unidirectional flow and clear separation between the UI and business logic.

### [VIPER (View-Interactor-Presenter-Entity-Router)](https://github.com/canamaemindevar/NewsApp/tree/viper)
VIPER takes modularity and separation of concerns to the next level. By adding Entities and Routers, this architecture ensures each component has a single responsibility, making the application highly testable and maintainable.

## Installation

To run this project locally, follow these steps:

1. Clone the repository:
   ```sh
   git clone https://github.com/canamaemindevar/NewsApp.git
2. Navigate to the desired branch:
   ```sh
   git checkout <branch-name>
3. Open the project in Xcode:
   ```sh
   open NewsAPIApp.xcodeproj
4. Build and run the application:
   ```sh
   Cmd + R
