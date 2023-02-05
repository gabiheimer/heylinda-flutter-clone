import 'package:flutter/material.dart';

class FavouriteButton extends StatelessWidget {
  final bool isFavourited;
  final Function() onPress;

  const FavouriteButton({
    super.key,
    required this.isFavourited,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: onPress,
      child: Icon(
        isFavourited ? Icons.favorite : Icons.favorite_outline,
        size: 25,
        color: primary,
      ),
    );
  }
}
