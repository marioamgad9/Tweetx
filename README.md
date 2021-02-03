![App Logo](Images/logo.png)
# Tweetx
The Tweetx app as an iOS sample app and not a real-world application. It's created to perform simple Twitter operations like track followers and see their tweets. Of course a sample app like this is not meant to be scalable, but I've built it with scalability in mind to demonstrate how that would be tackled in a real-world scenario.


## Architecture

This sample app was built using a modular version of MVVM. It's built with scalability and modularity in mind. To be able to plug in or rearrange parts of the system fairly easy.

### Modules

* **Common**: Holds all the common code that is used by all of the project. (Primary/Secondary buttons, common extensions used accross the app)
* **Core**: Holds the dependency containers and coordinators for the project.
* **TXKit**: Holds the business logic and networking part of the project.
* **Main**: Acts as the root view controller and handles switching between the main states of the app.
* **Launch**: Handles launching the app with a loading animation and checks for the authentication status of the user to determine whether or not they should sign in.
* **Onboarding**: Handles authenticating the user and welcoming him/her to the system.
* **Followers**: Handles showing the list of followers for the user and basic actions on them.


## Requirements

- iOS 12.1+
- Xcode 12+
- Swift 5+


## Installation

This sample app was built using [CocoaPods](http://cocoapods.org).
Setup the workspace using:

```bash
$ pod install
```


## Author
Mario Mouris, mario@mariomouris.me
