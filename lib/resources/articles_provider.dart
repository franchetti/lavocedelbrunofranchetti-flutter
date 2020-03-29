import 'package:app/references.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart';

class ArticlesProvider {
  static Future<List<Post>> getArticles(int page, int perPage) async {
    List<Post> posts = await References.wordPress.fetchPosts(
      postParams: ParamsPostList(
        context: WordPressContext.view,
        pageNum: 1,
        perPage: 20,
        order: Order.desc,
        orderBy: PostOrderBy.date,
      ),
      // fetchAuthor: true,
      fetchFeaturedMedia: true,
      // fetchComments: true,
    );

    return posts;
  }
}
