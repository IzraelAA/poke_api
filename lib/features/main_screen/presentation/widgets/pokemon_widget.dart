import 'package:flutter/material.dart';
import 'package:poke_api/features/main_screen/data/models/pokemon_detail_model.dart';
import 'package:poke_api/utils/app_color.dart';
import 'package:poke_api/utils/app_text_style.dart';

class PokemonWidget extends StatelessWidget {
  final PokemonDetailModel pokemon;
  final VoidCallback onTap;

  const PokemonWidget({super.key, required this.pokemon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Extract the primary type name for reuse
    final String primaryType = pokemon.types?.isNotEmpty == true
        ? pokemon.types![0].type?.name ?? 'Unknown'
        : 'Unknown';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor().getBackGroundColor(primaryType),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Stack(
          children: [
            // Pokemon Image
            Positioned(
              bottom: 1,
              right: 1,
              child: Image.network(
                pokemon.sprites?.other?.officialArtwork?.frontDefault ?? '',
                fit: BoxFit.contain,
                height: 65,
                width: 65,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.image_not_supported,
                  size: 65,
                  color: Colors.grey,
                ),
              ),
            ),
            // Pokemon Name and Types
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Pokemon Name
                Text(
                  pokemon.name ?? 'Unknown',
                  style: AppTextStyle.pokemonHeader(color: Colors.white),
                ),
                // Pokemon Types
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: pokemon.types?.map((type) {
                    final String typeName = type.type?.name ?? 'Unknown';
                    return Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColor().getBackGroundColor2(primaryType),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        typeName,
                        style: AppTextStyle.pokemonBody(color: Colors.black),
                      ),
                    );
                  }).toList() ??
                      [],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}