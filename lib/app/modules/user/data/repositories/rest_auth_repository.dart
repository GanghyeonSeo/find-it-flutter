import 'package:find_it/app/modules/user/data/data_sources/remote/user_api.dart';
import 'package:find_it/app/modules/user/domain/repositories/auth_repository.dart';
import 'package:find_it/app/modules/user/domain/repositories/oauth_repository.dart';
import 'package:find_it/app/modules/user/domain/repositories/token_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class RestAuthRepository implements AuthRepository {
  final UserApi _api;
  final TokenRepository _tokenRepository;
  final OAuthRepository _oAuthRepository;

  RestAuthRepository(
    this._api,
    this._tokenRepository,
    this._oAuthRepository,
  );

  @override
  Future<void> login() async {
    final code = await _oAuthRepository.getAuthorizationCode();
    final result = await _api.login(code.authCode);
    await _tokenRepository.saveToken(result.accessToken);
  }

  @override
  Stream<bool> get isSignedIn => _tokenRepository.token.asyncMap(
        (_) async {
          try {
            await _api.info();
            return true;
          } catch (_) {
            return false;
          }
        },
      );

  @override
  Future<void> logout() async {
    await _tokenRepository.deleteToken();
  }
}
