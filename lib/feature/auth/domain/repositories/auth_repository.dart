import 'package:retrofit/http.dart';
import 'package:sport_calendart_app/feature/auth/domain/entity/models/user.dart';

//@RestApi(baseUrl: 'https://api.t2tc.ru/')
abstract interface class AuthRepository {
  @GET('')
  Future<void> signIn(@Path() String login, @Path() String password);
  @POST('')
  Future<User> signUp(@Path() String login, @Path() String password);

  Future<void> logOut();
}
