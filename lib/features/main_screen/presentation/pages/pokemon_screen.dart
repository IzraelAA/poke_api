import 'package:flutter/material.dart';
import 'package:poke_api/features/main_screen/data/models/pokemon_detail_model.dart';
import 'package:poke_api/features/main_screen/presentation/widgets/about_pokemon_widget.dart';
import 'package:poke_api/features/main_screen/presentation/widgets/basestats_widget.dart';
import 'package:poke_api/utils/app_color.dart';
import 'package:poke_api/utils/app_text_style.dart';

class PokemonScreen extends StatefulWidget {
  final PokemonDetailModel pokemon;

  const PokemonScreen({super.key, required this.pokemon});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;

  void init(TickerProvider tickerProvider) {
    _tabController = TabController(length: 2, vsync: tickerProvider);
  }

  @override
  void initState() {
    super.initState();
    init(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor()
            .getBackGroundColor(widget.pokemon.types!.first.type!.name!),
        title: Text(
          'Pokemon',
          style: AppTextStyle.pokemonHeader(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                height: 250,
                width: double.infinity,
                color: AppColor()
                    .getBackGroundColor(widget.pokemon.types!.first.type!.name!),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.pokemon.name!,
                      style: AppTextStyle.pokemonHeader(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: widget.pokemon.types!
                          .map(
                            (e) => Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                color: AppColor().getBackGroundColor2(
                                  widget.pokemon.types!.first.type!.name!,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                e.type!.name!,
                                style: AppTextStyle.pokemonBody(
                                    color: Colors.black),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: AppColor()
                      .getBackGroundColor(widget.pokemon.types![0].type!.name!),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 30, left: 20, right: 20),
                          child: TabBar(
                            labelPadding: const EdgeInsets.all(10),
                            indicatorColor: AppColor().getBackGroundColor(
                                widget.pokemon.types![0].type!.name!),
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            controller: _tabController,
                            tabs: [
                              Text(
                                'About',
                                style: AppTextStyle.pokemonBody(
                                    color: Colors.black),
                              ),
                              Text(
                                'Base Stats',
                                style: AppTextStyle.pokemonBody(
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                AboutPokemonWidget(pokemon: widget.pokemon),
                                BaseStatsWidget(pokemon: widget.pokemon),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.25,
            top: MediaQuery.of(context).size.width * 0.25,
            child: SizedBox(
              height: 200,
              width: 200,
              child: Image.network(widget
                  .pokemon.sprites!.other!.officialArtwork!.frontDefault!),
            ),
          )
        ],
      ),
    );
  }
}
