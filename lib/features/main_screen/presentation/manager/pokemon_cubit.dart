// import 'package:bloc/bloc.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:injectable/injectable.dart';
// import 'package:poke_api/features/main_screen/data/models/pokemon_detail_model.dart';
// import 'package:poke_api/features/main_screen/data/models/pokemon_model.dart';
//
// part 'pokemon_state.dart';
//
//
// @Injectable()
// class PokemonCubit extends Cubit<PokemonState> {
//   PokemonCubit() : super(PokemonInitial());
//
//   final String _baseURL = 'https://pokeapi.co/api/v2/pokemon?limit=20&offset=0';
//
//   PokemonModel _pokemons = PokemonModel();
//   final List<PokemonDetailModel> _pokemonsDetail = [];
//
//   Future<void> getPokemon() async {
//     try {
//       emit(PokemonLoading());
//       Uri url = Uri.parse(_baseURL);
//       final response = await http.get(url);
//       final data = pokemonModelFromJson(response.body);
//
//       if (response.statusCode == 200) {
//         _pokemons = data;
//
//         for (var result in _pokemons.results!) {
//           await getPokemonDetail(resultURL: result.url!);
//         }
//
//         emit(PokemonLoaded(pokemons: _pokemons, pokemonsDetail: _pokemonsDetail));
//       }
//     } catch (e) {
//       emit(PokemonError(message: e.toString()));
//     }
//   }
//
//   Future<void> getMorePokemon() async {
//     try {
//       emit(PokemonLoading());
//       Uri url = Uri.parse(_pokemons.next!);
//       final response = await http.get(url);
//       final data = pokemonModelFromJson(response.body);
//
//       if (response.statusCode == 200) {
//         _pokemons = data;
//
//         for (var result in _pokemons.results!) {
//           await getPokemonDetail(resultURL: result.url!);
//         }
//
//         emit(PokemonLoaded(pokemons: _pokemons, pokemonsDetail: _pokemonsDetail));
//       }
//     } catch (e) {
//       emit(PokemonError(message: e.toString()));
//     }
//   }
//
//   Future<void> getPokemonDetail({required String resultURL}) async {
//     try {
//       Uri url = Uri.parse(resultURL);
//       final response = await http.get(url);
//       final data = pokemonDetailModelFromJson(response.body);
//
//       if (response.statusCode == 200) {
//         _pokemonsDetail.add(data);
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:poke_api/features/main_screen/data/models/pokemon_detail_model.dart';
import 'package:poke_api/features/main_screen/data/models/pokemon_model.dart';
import 'package:poke_api/features/main_screen/domain/use_cases/get_pokemon_detail_use_case.dart';
import 'package:poke_api/features/main_screen/domain/use_cases/get_pokemon_list_use_case.dart';

part 'pokemon_state.dart';

@Injectable()
class PokemonCubit extends Cubit<PokemonState> {
  final GetPokemonListUseCase getPokemonListUseCase;
  final GetPokemonDetailUseCase getPokemonDetailUseCase;

  PokemonCubit({
    required this.getPokemonListUseCase,
    required this.getPokemonDetailUseCase,
  }) : super(PokemonInitial());

  PokemonModel _pokemons = PokemonModel();
  final List<PokemonDetailModel> _pokemonsDetail = [];
  bool _isLoadingMore = false; // Prevent multiple API calls

  Future<void> getPokemon() async {
    try {
      emit(PokemonLoading());
      print("Fetching Pokémon list...");
      final result = await getPokemonListUseCase.call(limit: '20', offset: '0');

      result.fold(
        (failure) => emit(PokemonError(message: failure.message)),
        (pokemons) async {
          _pokemons = pokemons;

          for (var result in _pokemons.results!) {
            await _fetchPokemonDetail(result.url!, false);
          }

          emit(PokemonLoaded(
              pokemons: _pokemons, pokemonsDetail: _pokemonsDetail));
        },
      );
    } catch (e) {
      emit(PokemonError(message: e.toString()));
    }
  }

  Future<void> getMorePokemon() async {
    if (_isLoadingMore || _pokemons.next == null) {
      return; // Prevent duplicate calls
    }
    _isLoadingMore = true;

    try {
      final result = await getPokemonListUseCase.call(
        limit: '20',
        offset: (_pokemons.results?.length ?? 0).toString(),
      );


      result.fold(
        (failure) => emit(PokemonError(message: failure.message)),
        (pokemons) async {
          _pokemons.results?.addAll(pokemons.results??[]);

          for (var result in pokemons.results!) {
            await _fetchPokemonDetail(result.url!, true);
          }

          emit(PokemonLoaded(
              pokemons: _pokemons, pokemonsDetail: _pokemonsDetail));
        },
      );
    } catch (e) {
      emit(PokemonError(message: e.toString()));
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<void> _fetchPokemonDetail(String url, bool isMore) async {
    final result = await getPokemonDetailUseCase(url);

    result.fold(
        (failure) =>
            debugPrint('Failed to fetch Pokémon detail: ${failure.message}'),
        (pokemonDetail) {
              _pokemonsDetail.add(pokemonDetail);
            return  emit(PokemonLoaded(
                  pokemons: _pokemons,
                  pokemonsDetail: _pokemonsDetail,
                  loadingMore: isMore));
            });
  }
}
