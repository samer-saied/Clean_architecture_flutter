import 'dart:convert';
import '../../../../core/databases/cache/cache_helper.dart';
import '../../../../core/errors/expentions.dart';
import '../models/post_model.dart';

class PostLocalDataSource {
  final CacheHelper cache;
  final String keyPost = "CachedPost";
  final String keyPosts = "CachedPosts";
  PostLocalDataSource({required this.cache});

  cachePost(PostModel? postToCache) {
    if (postToCache != null) {
      cache.saveData(
        key: keyPost,
        value: json.encode(
          postToCache.toJson(),
        ),
      );
    } else {
      throw CacheExeption(errorMessage: "No Internet Connection");
    }
  }

  cacheAllPosts(List<PostModel>? postsToCache) {
    if (postsToCache != null) {
      cache.saveData(key: keyPosts, value: postsToCache.toString());
    } else {
      throw CacheExeption(errorMessage: "No Internet Connection");
    }
  }

  Future<PostModel> getLastPost() {
    // return Future.value([]);
    final jsonString = cache.getDataString(key: keyPost);

    if (jsonString != null) {
      return Future.value(PostModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheExeption(errorMessage: "No Internet Connection");
    }
  }

  Future<List<PostModel>> getLastAllPosts() {
    // return Future.value([]);
    final jsonString = cache.getDataString(key: keyPosts);

    if (jsonString != null) {
      dynamic listPosts = json.decode(jsonString);
      print(listPosts);
      // return Future.value(PostModel.fromJson(json.decode(jsonString)));
      return Future.value([]);
    } else {
      throw CacheExeption(errorMessage: "No Internet Connection");
    }
  }
}
