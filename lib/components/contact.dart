import 'package:flutter/material.dart';

class ExtraPage extends StatelessWidget {
  const ExtraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Text('From Team Gigi', style: Theme.of(context).textTheme.headline4),
                  const SizedBox(height: 10),
                  const Text('Features in development'),
                  const SizedBox(height: 10),
                  const Text('Cloud Sync'),
                  const SizedBox(height: 10),
                  const Text('Sharing'),
                  const SizedBox(height: 10),
                  const Text('Cross device use'),
                  const SizedBox(height: 10),
                  const Text('And much more'),
                  const SizedBox(height: 50),

                  const Text('Copyright @Morpheus'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
