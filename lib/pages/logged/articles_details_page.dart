
import 'package:flutter/material.dart';
import 'package:mcproject/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/article_model.dart';

class ArticlePage extends StatelessWidget {
  final Article? article;

  ArticlePage({this.article});

  Future<void> openUrl(String url) async {
    final _url = Uri.parse(url);
    if (!await launchUrl(_url, mode: LaunchMode.platformDefault)) { // <--
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(article?.title ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(article?.urlToImage ?? ''), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            const SizedBox(height: 10,),

            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text(
                article!.source!.name ?? '',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15,),

            Text(
              article!.content ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),

            const SizedBox(height: 20,),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     const Text(
                      'Leggi di più',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Barlow',
                        fontSize: 22,
                        color: Colors.blueAccent,
                      ),
                    ),

                    IconButton(
                      onPressed: () async => {
                        openUrl(article?.url as String)
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        size: 24,
                      ),
                    )

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
