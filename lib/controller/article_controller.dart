import 'package:get/get.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ArticleController extends GetxController {
  final allBlog = [].obs;
  final postId = ''.obs;

  setPostId(id) {
    postId(id);
  }

  @override
  void onInit() {
    super.onInit();
    blogData();
  }

  setAllBlog(blogs) {
    allBlog(blogs);
  }

  blogData() async {
    final response = await http.get(
      Uri.parse(
          'https://www.googleapis.com/blogger/v3/blogs/1887870844984411174/posts?key=AIzaSyCQ9jLjt8Ekd1Eq08LXHnycX8deR-heco0'),
    );
    if (response.statusCode == 200) {
      print(response.statusCode);
      final allBlog = json.decode(response.body);
      print('================api==============');
      print(allBlog['items']);
      setAllBlog(allBlog['items']);
      print('=================api=============');
    } else {
      print(response.statusCode);
      throw Exception('Failed *********************');
    }
  }
}
