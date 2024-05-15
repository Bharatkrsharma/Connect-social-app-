
import 'package:connectapp/presentation/screens/news_reel_screen/news/article.dart';
import 'package:connectapp/presentation/screens/news_reel_screen/news/article_page.dart';
import 'package:connectapp/presentation/screens/news_reel_screen/news/news_api.dart';
import 'package:connectapp/presentation/screens/news_reel_screen/news/news_repository.dart';
import 'package:flutter/material.dart';

class News extends StatelessWidget {
  News({Key? key}) : super(key: key);

  final api = NewsApi();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'FLUTTER TIMES',
            style: TextStyle(
              //fontFamily: 'EnglishTowne',
                fontSize: 24),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, color: Colors.black),
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.green,
            tabs: [
              tabDetail(context, 'General'),
              tabDetail(context, 'Health'),
              tabDetail(context, 'Technology'),
              tabDetail(context, 'Science'),
              tabDetail(context, 'Top headlines'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FetchNews(future: api.fetchCategory(Category.general)),
            FetchNews(future: api.fetchCategory(Category.health)),
            FetchNews(future: api.fetchCategory(Category.technology)),
            FetchNews(future: api.fetchCategory(Category.science)),
            FetchNews(future: api.fetchAllNews()),
          ],
        ),
      ),
    );
  }

  Tab tabDetail(BuildContext context, String text) {
    return Tab(
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class FetchNews extends StatelessWidget {
  const FetchNews({super.key, required this.future});
  final Future<List<Article>> future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final news = snapshot.data;
            return Scaffold(
              body: ListView.builder(
                  itemCount: news!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ArticlePage(article: news[index]),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          ImageContainer(
                            width: 120,
                            height: 120,
                            margin: const EdgeInsets.all(10.0),
                            borderRadius: 5,
                            imageUrl: news[index].urlToImage,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  news[index].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.clip,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.source, size: 18),
                                    const SizedBox(width: 5),
                                    Text(
                                      news[index].source.name,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(width: 20),
                                    const Icon(Icons.person, size: 18),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        news[index].author,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            );
          }
        });
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key? key,
    this.height = 128,
    this.borderRadius = 24,
    required this.width,
    required this.imageUrl,
    this.margin,
    this.child,
  }) : super(key: key);

  final double width;
  final double height;
  final String imageUrl;
  final EdgeInsets? margin;
  final double borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
