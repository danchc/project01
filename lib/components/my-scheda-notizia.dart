import 'package:flutter/material.dart';

import '../model/article_model.dart';
import '../pages/logged/articles_details_page.dart';

Widget customListTile(Article article, BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    child: InkWell(
      enableFeedback: true,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticlePage(
                  article: article,
                )));
      },
      child: Container(
        margin: const EdgeInsets.all(12.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [
               BoxShadow(
                color: Colors.black12,
                blurRadius: 3.0,
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(article.urlToImage ?? ''), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),

            const SizedBox(height: 8.0,),

            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text(
                article.source!.name ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Barlow'
                ),
              ),
            ),

            const SizedBox(height: 8.0,),

            Text(
              article.title ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Barlow',
                fontSize: 16.0,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
