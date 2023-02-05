import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final bool loading;

  const LoadingScreen({super.key, this.loading = false});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    if (loading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(primary),
        ),
      );
    }
    return Container();
  }
}
