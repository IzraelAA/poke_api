import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:poke_api/core/error/failures.dart';
import 'package:poke_api/features/main_screen/data/data_sources/pokemon_data_source.dart';
import 'package:poke_api/features/main_screen/data/models/pokemon_detail_model.dart';
import 'package:poke_api/features/main_screen/data/models/pokemon_model.dart';
import 'package:poke_api/features/main_screen/domain/repositories/pokemon_repository.dart';

@LazySingleton(as: PokemonRepository)
class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonDataSource remoteDataSource;

  PokemonRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PokemonModel>> fetchPokemonList(
      {String limit = '20', String offset = '0'}) async {
    try {
      final result = await remoteDataSource.fetchPokemonList(
        limit: limit,
        offset: offset,
      );
      return Right(result);
    } catch (e) {
      print(e.toString());
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PokemonDetailModel>> fetchPokemonDetail(
      String url) async {
    try {
      final result = await remoteDataSource.fetchPokemonDetail(url);
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
