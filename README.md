# 🔑 Keyra API

## 📖 Overview

Keyra API is a study project written in Dart using the Vaden Framework
.
It provides a backend for managing:

- 👤 Developer accounts
- 📦 Products
- 🪪 Licenses
- 💻 Device activations

The API is designed to be simple, secure, and extensible, serving as the backend for the [Keyra Dashboard](https://github.com/Luciano-Magnus/keyra-dashboard)
.

##⚡ Features

- 🔐 Developer authentication via API tokens
- 📦 Product CRUD (create, update, delete, list)
- 🪪 License management (generate, validate, revoke)
- 💻 Track activations (device, OS, IP, timestamp)
- 📝 Swagger/OpenAPI docs available

## 🚀 Getting Started
Prerequisites
- Dart SDK (3.0+)
- PostgreSQL (15+)
- Docker (optional)

### Local Development

```sh
git clone https://github.com/Luciano-Magnus/keyra.git
cd keyra
dart pub get
dart run
```
> By default, the API runs on 👉 http://localhost:3001

### Using Docker

```sh
docker build -t keyra-api .
docker run -p 3001:3001 keyra-api
```

## ⚙️ Environment Variables
> Just adjust the aplication_example file and rename it to aplication

## 📂 Project Structure

```sh
src/
├── modules/
│   ├── user/          # User accounts & tokens
│   ├── product/       # Product management
│   ├── license/       # License generation & validation
│   └── activation/    # License activations
├── shared/            # Common utilities
└── main.dart          # App entrypoint
```

## 🎨 Tech Stack
- Dart
- [Vaden Framework](https://vaden.dev/)
- PostgreSQL
- Docker

## 📌 Disclaimer
This project is for **study purposes** only and not intended for production use (yet 😉).

## 🤝 Contributing
Feedback, suggestions, and PRs are welcome!

✨ Made with ❤️ by [Luciano Magnus](https://github.com/Luciano-Magnus)
