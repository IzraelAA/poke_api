import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:poke_api/core/error/failures.dart';
import 'package:poke_api/features/main_screen/data/models/pokemon_model.dart';
import 'package:poke_api/features/main_screen/domain/repositories/pokemon_repository.dart';

@LazySingleton()
class GetPokemonListUseCase {
  final PokemonRepository repository;

  GetPokemonListUseCase(this.repository);

  Future<Either<Failure, PokemonModel>> call(
      {String limit = '20', String offset = '0'}) async {
    return await repository.fetchPokemonList(limit: limit, offset: offset);
  }
}