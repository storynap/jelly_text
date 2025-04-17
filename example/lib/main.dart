import 'package:flutter/material.dart';
import 'package:jelly_text/jelly_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JellyText Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const JellyTextDemo(),
    );
  }
}

class JellyTextDemo extends StatefulWidget {
  const JellyTextDemo({super.key});

  @override
  State<JellyTextDemo> createState() => _JellyTextDemoState();
}

class _JellyTextDemoState extends State<JellyTextDemo> {
  final String _loremIpsum =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod metus eu quam tincidunt, vel ultricies nunc feugiat. Sed auctor tortor vel urna fermentum, sit amet ultrices justo facilisis. Proin consequat, arcu vitae facilisis euismod, justo elit sodales nulla, id tincidunt ligula velit a erat. Donec non velit vel magna fringilla imperdiet. Mauris ullamcorper auctor dignissim. Suspendisse potenti. Ut tempor turpis a luctus sagittis. Curabitur malesuada dui id ex euismod, at tincidunt urna feugiat. Suspendisse potenti. Sed vitae semper elit. Aenean varius, purus id sollicitudin facilisis, tellus lectus congue nulla, vel luctus justo lorem vel nulla.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('JellyText Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Default JellyText:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            JellyText(
              text: _loremIpsum,
              maxLines: 3,
            ),
            const Divider(height: 32),
            const Text(
              'Custom "See more" text:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            JellyText(
              text: _loremIpsum,
              maxLines: 2,
              seeMoreText: 'Read more...',
            ),
            const Divider(height: 32),
            const Text(
              'Custom "See more" style:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 200,
              child: JellyText(
                text: _loremIpsum,
                maxLines: 2,
                seeMoreStyle: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const Divider(height: 32),
            const Text(
              'Custom callback:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            JellyText(
              text: _loremIpsum,
              maxLines: 2,
              seeMoreText: 'Tap for alert',
              onSeeMoreTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Custom action executed!'),
                  ),
                );
              },
            ),
            const Divider(height: 32),
            const Text(
              'Different text styles:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            JellyText(
              text: _loremIpsum,
              maxLines: 3,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.purple,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
