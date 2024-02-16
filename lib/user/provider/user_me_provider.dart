import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wave/common/const/data.dart';
import 'package:wave/common/secure_storage/secure_storage.dart';
import 'package:wave/user/model/user_model.dart';

import '../model/google_login_model.dart';
import '../repository/auth_repository.dart';
import '../repository/user_me_repository.dart';

final userMeProvider =
    StateNotifierProvider<UserMeStateNotifier, UserModelBase?>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    final userMeRepository = ref.watch(userMeRepositoryProvider);
    final storage = ref.watch(secureStorageProvider);

    return UserMeStateNotifier(
      authRepository: authRepository,
      repository: userMeRepository,
      storage: storage,
    );
  },
);

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final AuthRepository authRepository;
  final UserMeRepository repository;
  final FlutterSecureStorage storage;

  UserMeStateNotifier({
    required this.authRepository,
    required this.repository,
    required this.storage,
  }) : super(UserModelLoading()) {
    // 내 정보 가져오기
    getMe();
  }

  Future<void> getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    if (refreshToken == null || accessToken == null) {
      state = null;
      return;
    }

    final resp = await repository.getMe();

    state = resp;
  }

  // UserMeStateNotifier 클래스 내부에 추가
  Future<void> googleLogin(GoogleLoginModel googleLoginModel) async {
    try {
      // 로그인 로딩 상태로 변경
      state = UserModelLoading();

      // AuthRepository의 googleLogin 메서드 호출
      final loginResponse = await authRepository.googleLogin(googleLoginModel: googleLoginModel);

      if (loginResponse.data != null) {
        // 받은 토큰을 안전하게 저장
        await storage.write(key: REFRESH_TOKEN_KEY, value: loginResponse.data!.refreshToken);
        await storage.write(key: ACCESS_TOKEN_KEY, value: loginResponse.data!.accessToken);

        // 저장된 토큰을 이용하여 사용자 정보 가져오기
        final userResp = await repository.getMe();
        // 상태를 업데이트하고 사용자 정보 반환
        state = userResp;
      } else {
        // 로그인 실패 상태로 변경
        state = UserModelError(message: 'Google 로그인에 실패했습니다.');
      }
    } catch (e) {
      // 예외 발생 시 로그인 실패 상태로 변경
      state = UserModelError(message: 'Google 로그인에 실패했습니다.');
    }
  }


  Future<void> logout() async {
    state = null;

    await Future.wait(
      [
        storage.delete(key: REFRESH_TOKEN_KEY),
        storage.delete(key: ACCESS_TOKEN_KEY),
      ],
    );
  }
}
