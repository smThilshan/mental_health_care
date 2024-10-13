import 'package:dio/dio.dart';

import '../models/news_response_model.dart';

class NewsApi {


  Future<List<ArticleModel>> fetchHealthNews() async {
    final dio = Dio();
    final url = 'https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=e9b2c288d60e4c06998a3b3cefc1f624';

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final newsResponse = NewsResponseModel.fromJson(data);
        if (newsResponse.articles != null) {
          return newsResponse.articles!;
        } else {
          throw Exception('Articles not found in the response');
        }
      } else {
        throw Exception('Failed to load health news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load health news: $e');
    }
  }

}