import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_flutter_rapidapi/models/news.dart';
import 'package:news_flutter_rapidapi/services/news_service.dart';


final newsProvider = StateNotifierProvider.family<GetQueryNews, List<News>, String>((ref, String query) => GetQueryNews(query: query));

class GetQueryNews extends StateNotifier<List<News>>{

  GetQueryNews({required this.query}) : super([]){
    getQuery();
  }


  final String query;

  Future<void> getQuery() async {
    final response = await NewsService.getQueryNews(query);
    state = response;
  }
}


final searchNewsProvider = StateNotifierProvider<SearchNewsProvider, List<News>>((ref) => SearchNewsProvider());

class SearchNewsProvider extends StateNotifier<List<News>> {

  SearchNewsProvider() : super([]) {
    getData();
  }


  Future<void> getData() async {
    await Future.delayed(Duration(seconds: 2));
    final response = await NewsService.getNews();
    state = response;
  }

  Future<void> getQuery(String query) async {
    state = [];
    final response = await NewsService.getQueryNews(query);
    state = response;
  }
}
