import 'package:dartz/dartz.dart';
import 'package:poke_api/core/error/failures.dart';
import 'package:poke_api/features/main_screen/data/models/pokemon_detail_model.dart';
import 'package:poke_api/features/main_screen/data/models/pokemon_model.dart';

abstract class PokemonRepository {
  Future<Either<Failure,PokemonModel>> fetchPokemonList({
    String limit = '20',
    String offset = '0',
  });

  Future<Either<Failure,PokemonDetailModel>> fetchPokemonDetail(String url);
}
