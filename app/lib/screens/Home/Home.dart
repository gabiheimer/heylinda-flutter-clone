import 'package:app/data/meditations.dart';
import 'package:app/templates/ScreenTemplate.dart';
import 'package:app/widgets/MeditationCard.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: add favourites funcionality
    const List<Meditation> favourites = [];
    final primaryColor = Theme.of(context).primaryColor;

    return ScreenTemplate(
      title: "Home",
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 36, bottom: 36, left: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Section(
              title: 'POPULAR',
              meditations: MeditationRepository.popular,
              isPopular: true,
            ),
            _Section(
              title: 'ANXIETY',
              meditations: MeditationRepository.anxiety,
            ),
            _Section(
              title: 'SLEEP',
              meditations: MeditationRepository.sleep,
            ),
            if (favourites.isNotEmpty)
              const _Section(
                title: 'FAVOURITE',
                meditations: favourites,
              ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Meditation> meditations;
  final bool isPopular;

  const _Section({
    Key? key,
    required this.title,
    required this.meditations,
    this.isPopular = false,
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
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
