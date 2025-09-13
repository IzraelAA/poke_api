import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_api/features/main_screen/presentation/manager/pokemon_cubit.dart';
import 'package:poke_api/features/main_screen/presentation/pages/pokemon_screen.dart';
import 'package:poke_api/features/main_screen/presentation/widgets/pokemon_widget.dart';
import 'package:poke_api/utils/app_text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<PokemonCubit>().getPokemon();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_scrollController.position.outOfRange) {
      if (context.read<PokemonCubit>().state is PokemonLoaded &&
          (context.read<PokemonCubit>().state as PokemonLoaded).loadingMore ==
              false) {
        context.read<PokemonCubit>().getMorePokemon();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xfff7d346),
        title: Text(
          'Pokedex',
          style: AppTextStyle.pokemonHeader(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<PokemonCubit, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoading && state is! PokemonLoaded) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PokemonLoaded) {
            return Column(
              children: [
                Expanded(child: bodyOrientation(state)),
              ],
            );
          } else if (state is PokemonError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }

  Widget bodyOrientation(PokemonLoaded state) {
    return OrientationBuilder(
      builder: (context, orientation) {
        int crossAxisCount = orientation == Orientation.portrait ? 2 : 4;
        return GridView.count(
          padding: const EdgeInsets.all(20),
          controller: _scrollController,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          crossAxisCount: crossAxisCount,
          childAspectRatio: 1.4,
          children: [
            ...state.pokemonsDetail.map(
              (pokemon) => PokemonWidget(
                pokemon: pokemon,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PokemonScreen(pokemon: pokemon),
                    ),
                  );
                },
              ),
            ),
            if (state.loadingMore)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
          ],
        );
      },
    );
  }
}
