import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sport_calendart_app/feature/auth/domain/code_model.dart';
import 'package:sport_calendart_app/feature/auth/domain/entity/auth_login_request.dart';
import 'package:sport_calendart_app/feature/auth/domain/entity/auth_request.dart';
import 'package:sport_calendart_app/feature/auth/domain/entity/auth_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @PUT("/auth/activate")
  Future<AuthResponse> checkEmailCode(@Body() CodeModel body);

  @POST("/auth/login")
  Future<void> signInWithEmailAndPassword(@Body() AuthLoginRequest body);

  @POST("/auth/register")
  Future<void> signUp(@Body() AuthRequest body);

  @POST("/auth/sign-out")
  Future<void> signOut();
}
