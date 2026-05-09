import 'package:dio/dio.dart';

class HomeRepository {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://api.lushmkt.com/api',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<Response> getBanners() async {
    return await _dio.get('/banners');
  }

  Future<Response> getCategories() async {
    return await _dio.get('/categories');
  }

  Future<Response> getHotServices() async {
    return await _dio.get('/services/hot');
  }

  Future<Response> getFeaturedProducts() async {
    return await _dio.get('/products/featured');
  }

  Future<Response> getStats() async {
    return await _dio.get('/stats/realtime');
  }
}
