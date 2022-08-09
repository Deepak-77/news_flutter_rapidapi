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
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottom: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(fontSize: 20),
                indicatorColor: Colors.red,
                tabs: [
                  Tab(
                    text: 'Hollywood',
                  ),
                  Tab(
                    text: 'Gaming',
                  ),
                ]),
          ),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 300,
                child: TabBarView(children: [
                  TabBarWidget('hollywood'),
                  TabBarWidget('gaming'),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Consumer(builder: (context, ref, child) {
                      return TextFormField(
                        onFieldSubmitted: (val) {
                          ref.read(searchNewsProvider.notifier).getQuery(val);
                        },
                        decoration: InputDecoration(
                            hintText: 'Search News',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            border: OutlineInputBorder()),
                      );
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 245,
                      child: Consumer(builder: (context, ref, child) {
                        final newsData = ref.watch(searchNewsProvider);
                        if (newsData.isEmpty) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.purple,
                            ),
                          );
                        } else {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: newsData.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(right: 10),
                                    height: 250,
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            errorWidget: (ctx, string, stk) {
                                              return Image.asset(
                                                'assets/images/noImage.jpg',
                                                fit: BoxFit.cover,
                                              );
                                            },
                                            imageUrl: newsData[index].media,
                                            height: 300,
                                            width: 170,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  newsData[index].title,
                                                  maxLines: 2,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  newsData[index].summary,
                                                  maxLines: 9,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(newsData[index]
                                                    .published_date)
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ));
                              });
                        }
                      }),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
