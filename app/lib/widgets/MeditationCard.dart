import 'package:app/data/meditations.dart';
import 'package:app/styles/Colors.dart';
import 'package:app/widgets/DownloadButton.dart';
import 'package:flutter/material.dart';

class MeditationCard extends StatelessWidget {
  final Meditation item;
  final bool isPopular;

  const MeditationCard({super.key, required this.item, this.isPopular = false});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyText1?.color;
    final double imageHeight = isPopular ? 250 : 135;
    const double cardWidth = 250;

    return Container(
      width: cardWidth,
      margin: const EdgeInsets.only(right: 10),
      child: Card(
        elevation: 1,
        child: InkWell(
          // TODO: add navigation onTap
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: cardWidth,
                height: imageHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(item.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.subtitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${item.time} minutes",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: PredefinedColors.purple900,
                          ),
                        ),
                        const DownloadButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
