import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_flutter_rapidapi/main_screen.dart';

// Future<String> getData() async{
//   print('not loading');
// await Future.delayed(Duration(seconds: 2));
// return "Loading....";
// }

void main() async{
  //final data=getData().then((value) => print(value)).catchError((err)=>print(err));
  // try{
  //   final data= await getData();
  //   print(data);
  // }catch(err){
  //   print(err);
  // }
  runApp(ProviderScope(child: Home()));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
