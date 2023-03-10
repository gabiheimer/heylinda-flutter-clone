import 'package:app/data/meditations.dart';
import 'package:app/storage/Storage.dart';
import 'package:app/widgets/MeditationCard.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Meditation> favourites = [];

  void initFavourites() async {
    List<String> storedFavouritesIds = await Storage.getFavourites();
    List<Meditation> storedFavourites = MeditationRepository.meditations
        .where(
          (meditation) => storedFavouritesIds.contains(meditation.id),
        )
        .toList();

    setState(() {
      favourites = storedFavourites;
    });
  }

  void updateFavourites(Meditation meditation) {
    setState(() {
      if (favourites.contains(meditation)) {
        favourites.remove(meditation);
      } else {
        favourites.add(meditation);
      }
    });
  }

  @override
  void initState() {
    initFavourites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: add favourites funcionality
    final primaryColor = Theme.of(context).primaryColor;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 36, bottom: 36, left: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Section(
            title: 'POPULAR',
            meditations: MeditationRepository.popular,
            isPopular: true,
            updateFavourites: updateFavourites,
          ),
          _Section(
            title: 'ANXIETY',
            meditations: MeditationRepository.anxiety,
            updateFavourites: updateFavourites,
          ),
          _Section(
            title: 'SLEEP',
            meditations: MeditationRepository.sleep,
            updateFavourites: updateFavourites,
          ),
          if (favourites.isNotEmpty)
            _Section(
              title: 'FAVOURITE',
              meditations: favourites,
              updateFavourites: updateFavourites,
            ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Meditation> meditations;
  final bool isPopular;
  final void Function(Meditation) updateFavourites;

  const _Section({
    Key? key,
    required this.title,
    required this.meditations,
    this.isPopular = false,
    required this.updateFavourites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 19),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: SizedBox(
            height: isPopular ? 370 : 255,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: meditations.length,
              itemBuilder: (context, index) {
                return MeditationCard(
                  item: meditations[index],
                  isPopular: isPopular,
                  updateFavourites: updateFavourites,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
