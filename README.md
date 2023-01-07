# FastNews

This project is created in order to demonstrate how to use RxSwift within MVVM-C pattern. 

Project has 3 different tabs on the tabbar and it has a minor implementation for UserDefaults, where it saves the posts from the URL : 
https://jsonplaceholder.typicode.com/posts

Basically, posts tab recently added to show how to have a synchronized call within an RxSwift project and how to lock App Launch (Splash) screen and wait until the posts arrive and then we store them locally. 

Sources and Categories tab includes category selection and source selection for the news. Dependecies are injected by using Swinject. Steppers in the viewmodel sends command to Flow and Stepper classes to handle the navigation. Please refer the screeen shots and the source code.

Further imporocements can be done for UI. 
![Simulator Screen Shot - iPhone 14 Pro - 2023-01-07 at 13 09 54](https://user-images.githubusercontent.com/11138262/211149982-774a7ad5-979f-44c8-b030-8896cd6c8698.png)
![Simulator Screen Shot - iPhone 14 Pro - 2023-01-07 at 13 09 59](https://user-images.githubusercontent.com/11138262/211149987-2be63252-e497-4486-a566-581666900c46.png)
![Simulator Screen Shot - iPhone 14 Pro - 2023-01-07 at 13 10 04](https://user-images.githubusercontent.com/11138262/211149995-596b1baf-0a65-497e-aa2b-f503eea7cee1.png)




