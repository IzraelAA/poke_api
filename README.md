Here is a `README.md` file for your project:

```markdown
# PokeAPI Flutter Application

This project is a Flutter-based application that utilizes the PokeAPI to display a list of Pokémon, their details, and statistics. The app is designed with clean architecture principles, Bloc state management, and infinite scrolling for seamless user experience.

---

## Features

- **Pokémon List**: Displays a grid of Pokémon fetched from the PokeAPI.
- **Infinite Scrolling**: Automatically loads more Pokémon as the user scrolls down.
- **Pokémon Details**: View detailed information about each Pokémon, including types, abilities, and base stats.
- **Tab Navigation**: Switch between "About" and "Base Stats" tabs for detailed Pokémon information.
- **Responsive Design**: Optimized for various screen sizes.

---

## Technologies Used

### Languages and Frameworks:
- **Dart**: Primary language for Flutter development.
- **Flutter**: Framework for building the UI.
- **Kotlin/Java**: For Android-specific configurations.
- **Gradle**: Build system for Android.

### Libraries and Tools:
- **Flutter Bloc**: State management solution.
- **Injectable**: Dependency injection for better modularity.
- **HTTP**: For API requests.
- **Percent Indicator**: For visualizing Pokémon stats.
- **PokeAPI**: Public API for Pokémon data.

---

## Project Structure

The project follows clean architecture principles with the following structure:

```
lib/
├── features/
│   ├── main_screen/
│   │   ├── data/
│   │   │   ├── models/          # Data models for Pokémon and their details
│   │   │   ├── data_sources/    # Remote data source for API calls
│   │   ├── domain/
│   │   │   ├── use_cases/       # Use cases for fetching Pokémon data
│   │   ├── presentation/
│   │   │   ├── manager/         # Bloc/Cubit for state management
│   │   │   ├── pages/           # Screens (Home, Pokémon details)
│   │   │   ├── widgets/         # Reusable UI components
├── utils/                       # Utility classes (e.g., colors, text styles)
```

---

## Installation and Setup

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/poke_api_flutter.git
   cd poke_api_flutter
   ```

2. **Install Dependencies**:
   Ensure you have Flutter installed. Then, run:
   ```bash
   flutter pub get
   ```

3. **Run the Application**:
   Connect a device or emulator and run:
   ```bash
   flutter run
   ```

---

## Key Components

### 1. **State Management**:
- The app uses `Bloc` and `Cubit` for managing states like loading, success, and error.

### 2. **Infinite Scrolling**:
- Implemented using a `ScrollController` in the `HomeScreen` to fetch more Pokémon when the user scrolls to the bottom.

### 3. **Clean Architecture**:
- The app separates concerns into `data`, `domain`, and `presentation` layers for better maintainability.

### 4. **Custom Widgets**:
- `PokemonWidget`: Displays a Pokémon in the grid.
- `BaseStatsWidget`: Shows Pokémon stats with a progress bar.
- `AboutPokemonWidget`: Displays general information about a Pokémon.

---

## API Reference

This app uses the [PokeAPI](https://pokeapi.co/) to fetch Pokémon data.

### Endpoints:
- **Pokémon List**: `https://pokeapi.co/api/v2/pokemon?limit=20&offset=0`
- **Pokémon Details**: `https://pokeapi.co/api/v2/pokemon/{id}`

---

## Screenshots

| Home Screen | Pokémon Details |
|-------------|-----------------|
| ![Home](https://via.placeholder.com/150) | ![Details](https://via.placeholder.com/150) |

---

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Commit your changes and push to your fork.
4. Submit a pull request.

---

## License

This project is licensed under the [MIT License](LICENSE).

---

## Acknowledgments

- [PokeAPI](https://pokeapi.co/) for providing the Pokémon data.
- Flutter and Dart community for their amazing tools and libraries.
```