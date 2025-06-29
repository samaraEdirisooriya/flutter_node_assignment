# E-Commerce Flutter & Node.js Assignment

This project is a full-stack e-commerce application built with a Flutter frontend and a Node.js (Express) backend. It demonstrates modern state management using BLoC (Business Logic Component) for Flutter and a RESTful API for backend operations.

## Features

### Frontend (Flutter)
- Built with Flutter and Dart
- State management using flutter_bloc (BLoC pattern)
- Product listing, add, edit, and delete
- Authentication (login/register)
- Responsive UI for mobile
- Error handling and loading indicators
- Uses Dio for HTTP requests
- Environment variables for API endpoints

### Backend (Node.js)
- Express.js REST API
- MongoDB (or any database) for product and user data
- Authentication endpoints
- CRUD operations for products
- Organized with controllers, models, and routes

## Project Structure

```
frontend/
  ecom/           # Flutter app
    lib/
      blocks/     # BLoC files (auth, product)
      models/     # Data models
      repository/ # API/data repositories
      screens/    # UI screens
      widgets/    # Reusable widgets
    pubspec.yaml  # Flutter dependencies
backend/
  server.js       # Express server entry
  controllers/    # Route controllers
  models/         # Mongoose models
  routes/         # Express routes
```

## How to Run

### Backend
1. `cd backend`
2. `npm install`
3. `node server.js`

### Frontend
1. `cd frontend/ecom`
2. `flutter pub get`
3. `flutter run`

## BLoC Overview
- **AuthBloc**: Handles authentication state (login, register, logout)
- **ProductBloc**: Handles product CRUD (load, add, update, delete)

## API Endpoints (Sample)
- `POST /api/auth/login` - Login
- `POST /api/auth/register` - Register
- `GET /api/products` - List products
- `POST /api/products` - Add product
- `PUT /api/products/:id` - Update product
- `DELETE /api/products/:id` - Delete product

## Environment Variables
- Flutter uses `.env` for API base URLs
- Node.js uses `.env` for DB connection, JWT secret, etc.


---
**Assignment by [Maduvantha Edirisooriya]**
