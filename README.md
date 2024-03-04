# Books
A book listing iOS App. The application targets iOS 15 and provides a list view of books handled by Bitso, along with a detail view for a particular book. 

It incorporates a networking package for making API requests, which is currently implemented locally but designed to be easily moved to a separate remote repository in the future.

![d0d5c517-784e-4d48-b2f2-bebb864cd608](https://github.com/luanachen/Books/assets/24574325/dea444d4-0724-4ae3-87d6-3eb3581ba08c)

Currently, the test coverage is 95,5%:

<img width="1451" alt="Screenshot 2024-03-04 at 13 36 47" src="https://github.com/luanachen/Books/assets/24574325/3551313a-8b61-4907-9be8-e822d461ba54">


## Architecture

When possible, this project follows MVVM architecture. 

This architecture was chosen as it provides separation of concerns by dividing the application into three distinct layers: Model, View, and ViewModel. 

This separation allows for easier maintenance, testing, and scalability of the codebase.

## Features
List view displaying all possible books.

Detail view of a particular book showing information about it.

## Requirements

- iOS 15.0+
- Xcode 15+

## Getting Started
To run the project locally, follow these steps:

- Clone the repository to your local machine.
- Open the project in Xcode.
- Build and run the application on a simulator or a physical iOS device.

## Dependencies
BooksNetworking - a local networking package.

ViewInspector - a third-party framework targeting tests only, was added to easily test SwiftUI views. 


