# 📱 FastNews

FastNews is a news application built using **MVVM-C** (Model-View-ViewModel-Coordinator) architecture with **RxSwift**. This project serves as a demonstration of integrating **RxSwift** within an MVVM-C pattern while showcasing dependency injection, navigation handling, and synchronized API calls.

## 🚀 Features

- **Three TabBar Sections**:
  - **Posts**: Fetches and displays posts from [JSONPlaceholder](https://jsonplaceholder.typicode.com/posts).
  - **Sources**: Allows users to select different news sources.
  - **Categories**: Enables category-based filtering for news.
  
- **RxSwift & Concurrency Handling**
  - The **Posts tab** demonstrates a synchronized API call to fetch posts at launch.
  - The **Splash Screen** is locked until the data is fully retrieved and stored in `UserDefaults`.

- **Dependency Injection**  
  - Implemented using **Swinject** for better modularity and testability.

- **Navigation with RxFlow**  
  - **Steppers** in the ViewModel communicate with `Flow` and `Stepper` classes for seamless navigation.

- **Code Quality & Best Practices**
  - **SwiftLint** ensures consistent and clean coding style.
  - **RxDataSources** is used for efficiently managing UI updates.

## 🛠 Technologies & Frameworks

- **RxSwift** & **RxCocoa** – Reactive programming for handling asynchronous tasks and data binding.
- **RxDataSources** – Efficiently managing and updating UITableView & UICollectionView.
- **Swinject** – Lightweight dependency injection framework.
- **RxFlow** – Coordinating navigation flow within the MVVM-C pattern.
- **UserDefaults** – Storing fetched posts locally.
- **SwiftLint** – Enforcing coding style best practices.

## 📷 Screenshots

| Posts Tab | Sources Tab | Categories Tab |
|-----------|------------|---------------|
| ![Posts](https://user-images.githubusercontent.com/11138262/211149982-774a7ad5-979f-44c8-b030-8896cd6c8698.png) | ![Sources](https://user-images.githubusercontent.com/11138262/211149987-2be63252-e497-4486-a566-581666900c46.png) | ![Categories](https://user-images.githubusercontent.com/11138262/211149995-596b1baf-0a65-497e-aa2b-f503eea7cee1.png) |

## 🔧 Future Improvements

- UI/UX Enhancements for a more visually appealing experience.
- Implement offline mode using CoreData or Realm.
- Expand the news API integration for real-world data.

---
