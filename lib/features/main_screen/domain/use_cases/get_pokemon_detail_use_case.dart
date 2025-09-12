import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:poke_api/core/error/failures.dart';
import 'package:poke_api/features/main_screen/data/models/pokemon_detail_model.dart';
import 'package:poke_api/features/main_screen/domain/repositories/pokemon_repository.dart';

@LazySingleton()
class GetPokemonDetailUseCase {
  final PokemonRepository repository;

  GetPokemonDetailUseCase({required this.repository});

  Future<Either<Failure, PokemonDetailModel>> call(String url) async {
    return await repository.fetchPokemonDetail(url);
  }
}
