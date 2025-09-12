// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:poke_api/features/main_screen/data/data_sources/pokemon_data_source.dart'
    as _i219;
import 'package:poke_api/features/main_screen/data/repositories/pokemon_repository.dart'
    as _i246;
import 'package:poke_api/features/main_screen/domain/repositories/pokemon_repository.dart'
    as _i665;
import 'package:poke_api/features/main_screen/domain/use_cases/get_pokemon_detail_use_case.dart'
    as _i947;
import 'package:poke_api/features/main_screen/domain/use_cases/get_pokemon_list_use_case.dart'
    as _i65;
import 'package:poke_api/features/main_screen/presentation/manager/pokemon_cubit.dart'
    as _i386;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i219.PokemonDataSource>(
      () => _i219.PokemonDataSourceImpl());
  gh.lazySingleton<_i665.PokemonRepository>(() => _i246.PokemonRepositoryImpl(
      remoteDataSource: gh<_i219.PokemonDataSource>()));
  gh.lazySingleton<_i947.GetPokemonDetailUseCase>(() =>
      _i947.GetPokemonDetailUseCase(repository: gh<_i665.PokemonRepository>()));
  gh.lazySingleton<_i65.GetPokemonListUseCase>(
      () => _i65.GetPokemonListUseCase(gh<_i665.PokemonRepository>()));
  gh.factory<_i386.PokemonCubit>(() => _i386.PokemonCubit(
        getPokemonListUseCase: gh<_i65.GetPokemonListUseCase>(),
        getPokemonDetailUseCase: gh<_i947.GetPokemonDetailUseCase>(),
      ));
  return getIt;
}
