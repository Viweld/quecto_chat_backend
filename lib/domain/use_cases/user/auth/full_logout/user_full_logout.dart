import '../../../../../core/interfaces/token_manager_facade.dart';

// Use-case
// -----------------------------------------------------------------------------
class UserFullLogout {
  UserFullLogout(this._tokenManagerFacade);

  final TokenManagerFacade _tokenManagerFacade;

  // ---------------------------------------------------------------------------
  Future<void> call(String userId) async {
    // clear user whitelist
    await _tokenManagerFacade.clearUserWhitelist(userId);
  }
}
