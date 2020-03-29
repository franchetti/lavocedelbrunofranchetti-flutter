import 'package:flutter_wordpress/flutter_wordpress.dart';
import 'package:html/parser.dart';

class ArticleModel {
  final String title;
  final String excerpt;
  final String featuredMediaUrl;
  final String featuredMediaCaption;
  final String body;

  ArticleModel({
    this.title,
    this.excerpt,
    this.featuredMediaUrl,
    this.featuredMediaCaption,
    this.body,
  });

  factory ArticleModel.fromWordpressPost(Post wordpressPost) => ArticleModel(
        title: parse(wordpressPost.title.rendered).documentElement.text,
        excerpt: parse(wordpressPost.excerpt.rendered).documentElement.text,
        featuredMediaUrl: wordpressPost.featuredMedia.link,
        featuredMediaCaption: wordpressPost.featuredMedia.title.rendered,
        body: parse(wordpressPost.content.rendered).documentElement.text.replaceAll("\n\n", "\n").trim(),
      );
}
