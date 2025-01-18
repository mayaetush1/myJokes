# MyJoke iOS App 

## Overview

The application fetches jokes from a public Joke API, manages concurrent API requests, persists data locally using Core Data, and presents the jokes in an informative and user-friendly manner.

## Technologies Used

*   **Swift:** The primary programming language.
*   **SwiftUI:** For building the user interface.
*   **Combine:** For handling asynchronous operations and data flow.
*   **URLSession:** For making network requests.
*   **Core Data:** For local data persistence.

## Architecture

*   **`MVVM (Model-View-ViewModel)`:** 
    *   The primary architectural pattern for managing UI-related logic and data presentation.
*   **`Coordinator Pattern`:**
    *   Used for navigation management, promoting a clear navigation flow.
*   **`WebService`:**
    *   Responsible for fetching data from the Joke API.
    *   Implements `ApiClientProtocol`.
    *   Limits concurrent API requests to a maximum of 5.
*   **`CoreDataStorageManager`:**
    *   Handles local data storage and retrieval using Core Data.
    *   Implements `StorageManagerProtocol`.
    *   Manages the Core Data stack.
*   **`MainView`:**
    *   Displays a list of joke categories and the count of jokes within each category.
    *   Provides "Pull to Refresh" functionality to fetch new jokes from the server.
    *   Includes an "Add New Joke" button to fetch and store a random joke.
*   **`DetailsView`:**
    *   Shows detailed jokes for a selected category.
    *   Divided into two sections: "Single Part Jokes" and "Two Part Jokes".
    *   Offers filtering of jokes based on flags (e.g., nsfw, religious).
    *   Features a "Back to Top" button to scroll the user to the beginning of the list.
*   **Protocols:**
    *   `ApiClientProtocol`: Defines the interface for API clients.
    *   `StorageManagerProtocol`: Defines the interface for storage managers.

