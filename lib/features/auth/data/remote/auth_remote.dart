import 'package:admin_pegawai_bloc/core/network/api_response.dart';
import 'package:admin_pegawai_bloc/features/auth/data/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_remote.g.dart';

@RestApi(baseUrl: "https://be.karlearn.site")
abstract class AuthRemote {
  factory AuthRemote(Dio dio, {String baseUrl}) = _AuthRemote;

  @POST("/api/auth/login")
  Future<ApiResponse<LoginResponse>> login(@Body() LoginRequest payload);

  @GET("/api/me")
  Future<ApiResponse<UserResponse>> profile();

  @POST("/api/auth/logout")
  Future<ApiResponse> logout();
}
