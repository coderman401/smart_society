import 'package:builders_group/src/app/features/login/login_presenter.dart';
import 'package:builders_group/src/app/routes/app_route_name.dart';
import 'package:builders_group/src/l10n/app_localizations.dart';
import 'package:builders_group/src/shared/services/modal_service.dart';
import 'package:builders_group/src/shared/widgets/app_text_field.dart';
import 'package:builders_group/src/shared/widgets/property_list.dart';
import 'package:builders_group/src/theme/app_button_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> implements LoginViewContract {
  String selectedProperty = '';
  bool terms = false;
  bool isLoading = false;
  late LoginPresenter _presenter;
  TextEditingController phoneController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    _presenter = LoginPresenter(this);
    if (selectedProperty.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ModalService.modalBottomSheet(
          context,
          PropertyList(),
          AppLocalizations.of(context).translate('select_property'),
        ).then((value) {
          setState(() {
            selectedProperty = value;
          });
        });
      });
    }
  }

  _doLogin() {
    setState(() {
      isLoading = true;
      String phone = phoneController.value.text;
      _presenter.doLogin(phone);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceContainer,
      body: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(),
            Text(
              'LOGO',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
            ),
            Text(
              AppLocalizations.of(
                context,
              ).translate('welcome_to', args: [selectedProperty]),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 240,
              child: SvgPicture.asset(
                'assets/images/bg.svg',
                width: size.width,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 16,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    hint: 'Please Enter Phone Number',
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    controller: phoneController,
                    prefix: SizedBox(
                      width: 48,
                      child: Center(
                        child: Text(' +91', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: terms,

                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              terms = value;
                            });
                          }
                        },
                      ),
                      Flexible(
                        flex: 1,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    '${AppLocalizations.of(context).translate('agree_to')} ',
                                style: TextStyle(color: colorScheme.onSurface),
                              ),
                              TextSpan(
                                text: AppLocalizations.of(
                                  context,
                                ).translate('terms_and_conditions'),
                                style: TextStyle(
                                  color: colorScheme.primary,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' ${AppLocalizations.of(context).translate('and')} ',
                                style: TextStyle(color: colorScheme.onSurface),
                              ),
                              TextSpan(
                                text: AppLocalizations.of(
                                  context,
                                ).translate('privacy_policy'),
                                style: TextStyle(
                                  color: colorScheme.primary,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                            style: TextStyle(color: colorScheme.onSurface),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: size.width,
                    child: ElevatedButton(
                      onPressed: !isLoading ? _doLogin : null,
                      style: AppButtonStyles.filled(context),
                      child:
                          !isLoading
                              ? Text(
                                AppLocalizations.of(context).translate('login'),
                              )
                              : Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void loginError(String message) {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void loginSuccess() {
    setState(() {
      isLoading = false;
    });
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouteName.home,
      (route) => false,
    );
  }
}
