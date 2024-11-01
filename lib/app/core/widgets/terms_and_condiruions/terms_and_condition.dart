import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

// ignore: must_be_immutable
class Policy extends StatelessWidget {
  Policy({super.key, this.radius = 10, required this.mdFile})
      : assert(
            mdFile.contains('.md'), 'The file must contain the .md extension');

  double radius;
  final String mdFile;

  MarkdownStyleSheet _buildMarkdownStyle(BuildContext context) {
    return MarkdownStyleSheet(
      h1: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
      h2: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.blueGrey,
      ),
      p: TextStyle(
          fontSize: 12, color: Colors.black87, overflow: TextOverflow.clip),
      blockquote: TextStyle(
        color: Colors.grey,
        fontStyle: FontStyle.italic,
      ),
      code: TextStyle(
        backgroundColor: Colors.grey[200],
        fontFamily: 'Courier',
        fontSize: 14,
      ),
      listBullet: TextStyle(
        color: Colors.blueAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: Future.delayed(const Duration(milliseconds: 150))
                    .then((value) {
                  return rootBundle.loadString('assets/markdown/$mdFile');
                }),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Markdown(
                        data: snapshot.data!,
                        styleSheet: _buildMarkdownStyle(context),
                        shrinkWrap:
                            true, // Helps limit content to avoid overflow
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(radius),
                          bottomRight: Radius.circular(radius)))),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(radius),
                        bottomRight: Radius.circular(radius))),
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                child: Text(
                  'Close',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(overflow: null),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
