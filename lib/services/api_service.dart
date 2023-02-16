import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

import '../model/article_model.dart';

class ApiService {

  final endPointUrl =
      "https://newsapi.org/v2/everything?q=fitness&language=it&apiKey=a58c4de70b8d419fafaba8800e311585";

  Future<List<Article>> getArticle() async {
    Response res = await get(Uri.parse(endPointUrl));

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      List<Article> articles =
        body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Can't get the Articles");

    }
  }
}
