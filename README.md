# Museum App
Listing museum items using Rijk Museum API ( https://data.rijksmuseum.nl/object-metadata/api ).

**Important Note** 
To use the application, we need API key. API key is not present in this repository for safety reasons. 
API key needs to be put in Secret.swift file under Museum/Networking path. If you don't have an API key, reach out to the developer.

## General Info

- Application is implemented using Xcode version 14.3.1 and it has deployment target iOS 14.0. 
- Application uses VIPER  architecture. 
- Application uses only one third party library which is Kingfisher. It is used to fetching and caching images from server.
- Application fetches third party library using SPM. 
- Application has a standalone Networking package which is put in a local Swift Package. It also has it's own unit tests
- Application covers all screen logic parts in Presenter and Interactor with unit tests thanks to extensive usage of dependency injection.
- Application covers error cases and shows error popups to user. If user taps on the Retry button, app tries to recover from the error.

## How to run

- As mentioned earlier, API key should be put in Museum/Networking/Secret.swift
- Opening the Xcode project should fetch the SPM package, Kingfisher, automatically.
- After these actions, simple project run should do the trick. 
