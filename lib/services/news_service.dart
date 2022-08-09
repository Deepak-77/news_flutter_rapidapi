
import 'package:dio/dio.dart';
import 'package:news_flutter_rapidapi/models/news.dart';

import '../api.dart';

class NewsService {

  static Future<List<News>>  getQueryNews(String query) async{
    final dio = Dio();
    try{

      final response = await dio.get(Api.searchNewsApi,
          queryParameters: {
            'q': query,
            'lang':'en'
          },
          options: Options(
              headers: {
          'X-RapidAPI-Host': 'free-news.p.rapidapi.com',
                'X-RapidAPI-Key':
                '158504c85cmsha81af2eeccd0865p1ec204jsn4f931af67096',

              }
          )
      );
      final data = (response.data['articles'] as List).map((news) => News.fromJson(news)).toList();
      return data;

    }on DioError catch (err){
      print(err);
      return [];
    }
  }



  static Future<List<News>>  getNews() async{
    final dio = Dio();
    try{
      await Future.delayed(Duration(seconds: 2));
      final response = await dio.get(Api.searchNewsApi,
          queryParameters: {
            'q': 'science',
            'lang':'en'
          },
          options: Options(
              headers: {
          'X-RapidAPI-Host': 'free-news.p.rapidapi.com',
                'X-RapidAPI-Key':
                '158504c85cmsha81af2eeccd0865p1ec204jsn4f931af67096',

              }
          )
      );
      final data = (response.data['articles'] as List).map((news) => News.fromJson(news)).toList();
      return data;
    }on DioError catch (err){
      print(err);
      return [];
    }
  }




}
