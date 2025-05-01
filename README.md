# 🛍️ Shop With Friends - Mobile Developer Assessment (Flutter)

This is a coding assessment for mobile developers applying to work on real-time collaborative features in a Flutter application. The project simulates a feature that allows users to invite a friend and shop together via a shared cart experience.
—

—

## 🎯 Objective


Implement the **Shop With Friends** flow using Flutter. A user should be able to:


- Create a shopping session and invite a friend via a session ID
- The friend joins the session, temporarily enters a shared cart state
- Both users can add items to the cart, which syncs in real-time.
- Once done, the friend exits the shared state, and the original user continues.


---


## 🧱 Project Structure

```bash
/lib
  /application
    /routes
    /theme
  /core
    /components
    /constants
    /network
        /auth_service
        /sgared_cart_service
    /utils
  /features
    /feature
        /data
            /datasources
                /remote
                /local
            /mappers
            /models
            repositories
        /domain
            /entities
            /repositories
            /usecase
        /presentation
            /pages
            /providers
            /widgets
  main.dart
```

## Installation Instructions

(Install APK Directly - RECOMMENDED)

1. Download the bundled apk located in /assessment_build/
2. Copy to an Android device (11 or above).
3. Run apk and install.
4. Repeat on another compatible device to test real-time sync function.

(Run through IDE)

1. Clone the repository to local machine.
2. Setup project and gradle configuration (where necessary).
3. Configure Firebase and connect to app (replace existing firebase configuration).
4. Connect physical device or emulator.
5. Run the application.
6. Repeat on another device (physical or emulator) to test real-time sync function.

## State Management & Routing

Provider and AutoRoute were employed in this project as opposed to the other option of using Stacked and Stacked_Router. This is due to the fact that stacked uses provider under the hood. Using Provider directly eliminates whatever limitations which the author of Stacked may have inadvertently created and limited knowledge of Stacked_Router.

## Project Notes

Flutter version 3.27.1 (Stable channel)
Current iteration allows multiple friends to share a cart.
Does not support creating more than one cart (session). Would cause conflicts and cause application to act unpredictably.
The products list was hardcoded as opposed to using dummy json 'https://dummyjson.com/products' so as to create a more fine tuned product model.

## Suggestions for Improvement.

Allow for user regitration for easy handling and tracking of network calls.
Allow for creating/joining of multiple sessions without restarting application.
