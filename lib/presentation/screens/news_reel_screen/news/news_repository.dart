
import 'package:connectapp/presentation/screens/news_reel_screen/news/article.dart';

enum Category { health, general, technology, science }

abstract class NewsRepository {
  Future<List<Article>> fetchAllNews();
  Future<List<Article>> fetchCategory(Category category);
}
