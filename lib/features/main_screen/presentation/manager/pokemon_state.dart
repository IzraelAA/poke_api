part of 'pokemon_cubit.dart';

@immutable
abstract class PokemonState {}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonLoaded extends PokemonState {
  final PokemonModel pokemons;
  final List<PokemonDetailModel> pokemonsDetail;
  final bool loadingMore;

  PokemonLoaded(
      {required this.pokemons,
      required this.pokemonsDetail,
      this.loadingMore = false});
}

class PokemonError extends PokemonState {
  final String message;

  PokemonError({required this.message});
}
