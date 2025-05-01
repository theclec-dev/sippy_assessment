# 🛍️ Shop With Friends - Mobile Developer Assessment (Flutter)

This is a coding assessment for mobile developers applying to work on real-time collaborative features in a Flutter application. The project simulates a feature that allows users to invite a friend and shop together via a shared cart experience.
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
1. Download the 