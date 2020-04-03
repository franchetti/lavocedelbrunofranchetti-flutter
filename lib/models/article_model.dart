import 'package:app/models/category_model.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart';
import 'package:html/parser.dart';

class ArticleModel {
  final int id;
  final String title;
  final String excerpt;
  final String featuredMediaUrl;
  final String featuredMediaCaption;
  final String htmlBody, plainBody;
  final List<CategoryModel> categories;
  final String link;

  ArticleModel({
    this.id,
    this.title,
    this.excerpt,
    this.featuredMediaUrl,
    this.featuredMediaCaption,
    this.htmlBody,
    this.plainBody,
    this.categories,
    this.link,
  });

  factory ArticleModel.fromWordpressPost(Post wordpressPost) => ArticleModel(
        title: parse(wordpressPost.title.rendered).documentElement.text,
        excerpt: parse(wordpressPost.excerpt.rendered).documentElement.text,
        featuredMediaUrl: wordpressPost.featuredMedia != null ? wordpressPost.featuredMedia.link : null,
        featuredMediaCaption: wordpressPost.featuredMedia != null ? wordpressPost.featuredMedia.title.rendered : null,
        htmlBody: wordpressPost.content.rendered,
        plainBody: parse(wordpressPost.content.rendered).documentElement.text.replaceAll("\n\n", "\n").trim(),
        categories:
            wordpressPost.categories != null ? wordpressPost.categories.map((rawCategory) => CategoryModel.fromWordpressPost(rawCategory)).toList() : null,
        link: wordpressPost.link,
        id: wordpressPost.id,
      );
}
