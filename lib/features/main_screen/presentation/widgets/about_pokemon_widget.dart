import 'package:flutter/material.dart';
import 'package:poke_api/features/main_screen/data/models/pokemon_detail_model.dart';
import 'package:poke_api/utils/app_color.dart';
import 'package:poke_api/utils/app_text_style.dart';

class AboutPokemonWidget extends StatelessWidget {
  final PokemonDetailModel pokemon;
  const AboutPokemonWidget({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:   [
            Text('Height',style: AppTextStyle.pokemonSubTitle(color: Colors.black),),
            SizedBox(height: 20),
            Text('Weight',style: AppTextStyle.pokemonSubTitle(color: Colors.black),),
            SizedBox(height: 20),
            Text('Ability',style: AppTextStyle.pokemonSubTitle(color: Colors.black),),
          ],
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${pokemon.height! / 10} cm',
              ),
              const SizedBox(height: 20),
              Text(
                '${pokemon.weight! / 10} kg',
              ),
              const SizedBox(height: 20),
              Wrap(
                children: pokemon.abilities!
                    .map(
                      (e) => Container(
                        margin: const EdgeInsets.only(
                          right: 10,
                          bottom: 10,
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                          color: AppColor().getBackGroundColor(
                            pokemon.types![0].type!.name!,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          e.ability!.name!
                            ,style: AppTextStyle.pokemonBody(color: Colors.white)
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
