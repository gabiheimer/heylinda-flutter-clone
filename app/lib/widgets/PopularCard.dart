import 'package:app/data/meditations.dart';
import 'package:app/widgets/DownloadButton.dart';
import 'package:flutter/material.dart';

class PopularCard extends StatelessWidget {
  final Meditation item;

  const PopularCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyText1?.color;
    final primaryColor = Theme.of(context).primaryColor;

    return SizedBox(
      width: 250,
      child: Card(
        elevation: 1,
        child: InkWell(
          // TODO: add navigation onTap
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 250,
                height: 250,
                margin: const EdgeInsets.only(right: 10),
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
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: primaryColor,
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
