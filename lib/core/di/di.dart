import 'package:admin_pegawai_bloc/core/utils/token_manager.dart';
import 'package:admin_pegawai_bloc/features/auth/data/remote/auth_remote.dart';
import 'package:admin_pegawai_bloc/features/auth/data/repository/auth_repository_impl.dart';
import 'package:admin_pegawai_bloc/features/auth/domain/repository/auth_repository.dart';
import 'package:admin_pegawai_bloc/features/auth/domain/usecase/auth_usecase.dart';
import 'package:admin_pegawai_bloc/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:admin_pegawai_bloc/features/pegawai/data/remote/pegawai_remote.dart';
import 'package:admin_pegawai_bloc/features/pegawai/data/repository/pegawai_repository_impl.dart';
import 'package:admin_pegawai_bloc/features/pegawai/domain/repository/pegawai_repository.dart';
import 'package:admin_pegawai_bloc/features/pegawai/domain/usecase/pegawai_usecase.dart';
import 'package:admin_pegawai_bloc/features/pegawai/presentation/cubit/pegawai_cubit.dart';
import 'package:admin_pegawai_bloc/features/presensi/data/remote/presensi_remote.dart';
import 'package:admin_pegawai_bloc/features/presensi/data/repository/presensi_repository_impl.dart';
import 'package:admin_pegawai_bloc/features/presensi/domain/repository/presensi_repository.dart';
import 'package:admin_pegawai_bloc/features/presensi/domain/usecase/presensi_usecase.dart';
import 'package:admin_pegawai_bloc/features/presensi/presentation/cubit/presensi_cubit.dart';
import 'package:admin_pegawai_bloc/features/verifikasi/data/remote/verifikasi_remote.dart';
import 'package:admin_pegawai_bloc/features/verifikasi/data/repository/verifikasi_repository_impl.dart';
import 'package:admin_pegawai_bloc/features/verifikasi/domain/repository/verifikasi_repository.dart';
import 'package:admin_pegawai_bloc/features/verifikasi/domain/usecase/verifikasi_usecase.dart';
import 'package:admin_pegawai_bloc/features/verifikasi/presentation/cubit/verifikasi_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final getIt = GetIt.instance;

void setup() {
  final String kelompok1Url = dotenv.get("KELOMPOK_1_BASE_URL");
  final String kelompok2Url = dotenv.get("KELOMPOK_2_BASE_URL");

  final dio = Dio(
    BaseOptions(
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? token = await TokenManager.getAccessToken();

        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        if (e.response?.statusCode == 401) {}
        return handler.next(e);
      },
    ),
  );

  getIt.registerSingleton<Dio>(dio);
  // feature auth
  getIt.registerFactory(() => AuthRemote(getIt(), baseUrl: kelompok1Url));
  getIt.registerFactory<AuthRepository>(() => AuthRepositoryImpl(getIt()));
  getIt.registerFactory(() => AuthUsecase(authRepository: getIt()));
  getIt.registerFactory(() => AuthCubit(getIt()));

  // feature pegawai
  getIt.registerFactory(() => PegawaiRemote(getIt(), baseUrl: kelompok2Url));
  getIt.registerFactory<PegawaiRepository>(
    () => PegawaiRepositoryImpl(getIt()),
  );
  getIt.registerFactory(() => PegawaiUsecase(getIt()));
  getIt.registerFactory(() => PegawaiCubit(getIt()));

  // feature verifikasi
  getIt.registerFactory(() => VerifikasiRemote(getIt(), baseUrl: kelompok2Url));
  getIt.registerFactory<VerifikasiRepository>(
    () => VerifikasiRepositoryImpl(getIt()),
  );
  getIt.registerFactory(() => VerifikasiUsecase(getIt()));
  getIt.registerFactory(() => VerifikasiCubit(getIt()));

  // feature presensi
  getIt.registerFactory(() => PresensiRemote(getIt(), baseUrl: kelompok1Url));
  getIt.registerFactory<PresensiRepository>(
    () => PresensiRepositoryImpl(getIt()),
  );
  getIt.registerFactory(() => PresensiUsecase(getIt()));
  getIt.registerFactory(() => PresensiCubit(getIt()));
}
