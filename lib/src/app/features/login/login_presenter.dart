import 'package:builders_group/src/shared/services/shared_preferences_service.dart';

abstract class LoginViewContract {
  void loginSuccess();
  void loginError(String message);
}


class LoginPresenter {
  late SharedPreferencesService _preferencesService;
  final LoginViewContract _view;

  LoginPresenter(this._view) {
    _preferencesService = SharedPreferencesService();
  }

  Future<void> doLogin(String phone) async {
    await Future.delayed(Duration(seconds: 5));
    _preferencesService.setData('JWT_TOKEN', phone);
    _view.loginSuccess();
  }

}
