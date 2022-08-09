import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_flutter_rapidapi/provider/news_provider.dart';
import 'package:news_flutter_rapidapi/widgets/tab_bar_widgets.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontSize: 20),
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: 'Hollywood',
              ),
              Tab(
                text: 'Gaming',
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 300,
              child: TabBarView(children: [
               TabBarWidget('Hollywood'),
                TabBarWidget('Gaming')
              ]),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search News',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  border: OutlineInputBorder()
                ),
              ),

              Container(
                height: 200,
                 child: Consumer(
                 builder: (context, ref, child) {
               final newsData = ref.watch(searchNewsProvider);
               print(newsData);
               if (newsData.isEmpty) {
                 return Container(
                     height: 500,
                     child: Center(
                       child: CircularProgressIndicator(
                         color: Colors.purple,
                       ),
                     ));
               } else {
                 return ListView.builder(
                   shrinkWrap: true,
                   itemCount: newsData.length,
                     itemBuilder: (context, index) {
                       return Container(
                           padding: EdgeInsets.all(10),
                           margin: EdgeInsets.only(right: 10),
                           height: 300,
                           width: 350,
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               ClipRRect(
                                 borderRadius: BorderRadius.circular(15),
                                 child: CachedNetworkImage(
                                   errorWidget: (ctx,string,stk){
                                     return Image.asset('/assets/images/noImage.jpg');
                                   },
                                   imageUrl:newsData[index].media,
                                   height: 200,
                                   width: 350,

                                   fit: BoxFit.cover,
                                 ),
                               ),
                               SizedBox(height: 10,),
                               Text(newsData[index].title,maxLines: 2,),
                               SizedBox(height: 5,),
                               Text(newsData[index].published_date),
                             ],
                           ));
                     });
               }
                 }
                 )
              )
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
