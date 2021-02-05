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


## Areas for improvement

* The caching system could be more personalized to cache followers for each users and not have to clear cache every time the user signs out.
* Handle empty states for lists to show an illustration and a refresh button
* Authenticate user using access token not just userID. (I only used userID as the app doesn't have access to any private data, it only shows public info like followers list and their tweets)
* Ideally, I would have invested more than 15 mins in designing the user interface.
* Implement header that stretches to top when bouncing from scroll.
* Make profile picture and background clickable to present a fullscreen image overlay.


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

Also please provide a struct/class named **TwitterKeysProvider** inside TXKit module like the following:
```
struct TwitterKeysProvider {
    static let consumerKey = "YOUR_CONSUMER_KEY"
    static let consumerSecretKey = "YOUR_SECRET_KEY"
}
```

## Author
Mario Mouris, mario@mariomouris.me
