import 'package:active_ecommerce_cms_demo_app/custom/useful_elements.dart';
import 'package:active_ecommerce_cms_demo_app/data_model/blog_mode.dart';
import 'package:active_ecommerce_cms_demo_app/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class BlogDetailsScreen extends StatelessWidget {
  final BlogModel blog;

  BlogDetailsScreen({required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.mainColor,
      appBar: AppBar(
        title: Text(
          blog.title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        leading: UsefulElements.backButton(context),
        backgroundColor: MyTheme.mainColor,
        scrolledUnderElevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Html(
            data: blog.description,
            style: {
              "html": Style(
                  fontSize: FontSize(
                    12,
                  ),
                  backgroundColor: MyTheme.mainColor),
            },
          ),
        ),
      ),
    );
  }
}
