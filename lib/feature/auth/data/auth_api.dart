import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../domain/entity/models/token_model.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST("/auth/activate")
  Future<TokenModel> checkEmailCode(@Body() Map<String, String> body);

  @POST("/auth/login")
  Future<void> signInWithEmailAndPassword(@Body() Map<String, String> body);

  @POST("/auth/register")
  Future<void> signUp(@Body() Map<String, String> body);

  @POST("/auth/sign-out")
  Future<void> signOut();
}
