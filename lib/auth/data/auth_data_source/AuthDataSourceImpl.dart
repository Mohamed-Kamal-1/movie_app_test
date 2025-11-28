import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/auth/data/models/register_model.dart';
import '../../../core/app_const/app_const.dart';
import 'AuthDataSource.dart';

@injectable
class AuthDataSourceImpl implements AuthDataSource {
  final Dio dio;

  AuthDataSourceImpl(this.dio);

  @override
  Future<RegisterModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
  }) async {
    final response = await dio.post(
      AppConst.registerUrl,
      data: {
        "name": name,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "phone": phone,
        "avaterId": avaterId,
      },
    );

    final data = response.data['data'];

    if (data is Map<String, dynamic>) {
      return RegisterModel.fromJson(response.data);
    } else if (data is List && data.isNotEmpty) {
      final firstItem = data[0];
      if (firstItem is Map<String, dynamic>) {
        return RegisterModel.fromJson(firstItem);
      } else {
        throw Exception('Invalid response format: List item is not a Map');
      }
    } else {
      throw Exception('Invalid response data');
    }
  }
}
