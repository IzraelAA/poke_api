import 'package:injectable/injectable.dart';
import 'package:poke_api/core/network/api_url.dart';
import 'package:poke_api/core/network/network_module.dart';
import 'package:poke_api/features/main_screen/data/models/pokemon_detail_model.dart';
import 'package:poke_api/features/main_screen/data/models/pokemon_model.dart';

abstract class PokemonDataSource {
  Future<PokemonModel> fetchPokemonList(
      {String limit = '20', String offset = '0'});

  Future<PokemonDetailModel> fetchPokemonDetail(String url);
}

@LazySingleton(as: PokemonDataSource)
class PokemonDataSourceImpl extends NetworkModule implements PokemonDataSource {
  @override
  Future<PokemonModel> fetchPokemonList(
      {String limit = '20', String offset = '0'}) async {
    final response = await getMethod(
      Endpoint.pokemon,
      withAccessToken: false,
      param: {'limit': limit, 'offset': offset},
    );

    var result = responseHandler(response);
    return pokemonModelFromJson(result);
  }

  @override
  Future<PokemonDetailModel> fetchPokemonDetail(String url) async {
    final response = await getMethod(
      "",
      url: url,
      withAccessToken: false,
    );
    var result = responseHandler(response);
    return PokemonDetailModel.fromJson(result);
  }
}
