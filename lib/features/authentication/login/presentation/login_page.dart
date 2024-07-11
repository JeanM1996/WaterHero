import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterhero/core/data/network/network_checker.dart';
import 'package:waterhero/core/presentation/design/atoms/atoms.dart';
import 'package:waterhero/core/presentation/design/tokens/colors.dart';
import 'package:waterhero/core/presentation/utils/custom_dialogs.dart';
import 'package:waterhero/core/presentation/utils/dimens_extension.dart';
import 'package:waterhero/core/presentation/utils/icons_paths.dart';
import 'package:waterhero/core/presentation/utils/routes.dart';
import 'package:waterhero/core/presentation/utils/validators.dart';
import 'package:waterhero/features/authentication/login/presentation/login_controller.dart';
import 'package:waterhero/localization/generated/lang.dart';

/// Esta page envuelve cualquier widget que se le envíe cómo [child]
/// dentro de el [CustomAppBar] y el [NavigationBarHibridoPage]
/// Se puede omitir alguno de ellos si la vista lo requiere
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({
    super.key,
  });
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool emailValid = false;
  bool passwordEntered = false;

  @override
  void initState() {
    _emailController.addListener(() {
      emailValid = _emailController.text.isNotEmpty &&
          validateEmail(_emailController.text, true) == null;
      setState(() {});
    });

    _passwordController.addListener(() {
      passwordEntered = _passwordController.text.isNotEmpty &&
          _passwordController.text.length >= 6;
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //login state and cotroller
    final controller = ref.watch(loginController.notifier);
    final state = ref.watch(loginController);
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(iconsPaths.backgroundAuth),
              fit: BoxFit.cover,
              opacity: .6,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: context.fromLTRB(.06, .1, .06, .06),
                  width: context.width(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const CustomText(
                        'WaterHero',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomText(
                        Lang.of(context).login,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                      ),
                      SizedBox(
                        height: context.height(.01),
                      ),
                      CustomText(
                        Lang.of(context).loginWelcome,
                        fontSize: 16,
                        height: 1.3,
                        fontWeight: FontWeight.w400,
                        textColor: Colors.white,
                      ),
                      SizedBox(
                        height: context.height(.05),
                      ),
                      CustomTextFormField(
                        semanticsLabel: 'email',
                        lowerCase: true,
                        label: Lang.of(context).email,
                        realTimeValidation: true,
                        inputValueType: InputValueType.email,
                        controller: _emailController,
                      ),
                      SizedBox(
                        height: context.height(.025),
                      ),
                      CustomTextFormField(
                        semanticsLabel: 'password',
                        label: Lang.of(context).password,
                        inputValueType: InputValueType.password,
                        controller: _passwordController,
                      ),
                      SizedBox(
                        height: context.height(.025),
                      ),
                      SizedBox(
                        height: context.height(.05),
                      ),
                      InkWell(
                        onTap: () => _onTapRestorePassword(context),
                        child: Container(
                          width: context.width(),
                          alignment: Alignment.center,
                          child: CustomText(
                            Lang.of(context).forgotPassword,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                            textColor: colors.whiteBereus,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: context.height(.03),
                      ),
                      CustomButton(
                        semanticsLabel: 'login',
                        height: 56,
                        enabled: _enableButton(),
                        text: Lang.of(context).login,
                        onPressed: () =>
                            _enableButton() ? _onTap(controller) : null,
                      ),
                      SizedBox(
                        height: context.height(.03),
                      ),
                      CustomButton(
                        semanticsLabel: 'create_account',
                        height: 56,
                        buttonType: ButtonType.secondary,
                        text: Lang.of(context).register,
                        onPressed: () => context.push(Routes.registerRoute),
                      ),
                      SizedBox(
                        height: context.height(.03),
                      ),
                      InkWell(
                        child: Container(
                          width: context.width(),
                          alignment: Alignment.center,
                          child: CustomText(
                            '2024',
                            fontWeight: FontWeight.w400,
                            height: 1.3,
                            textColor: colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  dynamic _onTap(LoginController controller) async {
    final networkStatus = await NetworkChecker.check(context);
    if (networkStatus) {
      CustomDialogs.showLoadingDialog(context);
      final status = await controller.login(
        _emailController.text.toLowerCase(),
        _passwordController.text,
      );

      // ignore: prefer-extracting-callbacks, required this
      CustomDialogs.hideLoadingDialog(context);
      if (status == 'Login success') {
        final storage = await SharedPreferences.getInstance();
        context.go(
          Routes.comsumptionRoute,
          extra: {
            'role': storage.get('role'),
            'name': storage.get('name'),
          },
        );
      } else {
        if (status == 'Wrong credentials') {
          _showWrongCredentials();
        }
        if (status == 'Login error') {
          _showErrorDialog(
            context,
            Lang.of(context).errorOnLogin,
            Lang.of(context).errorOnLoginMessage,
            context.height(.51),
          );
        }
        if (status == 'User locked') {
          _showErrorDialog(
            context,
            Lang.of(context).userDisabled,
            Lang.of(context).userDisabledMessage,
            context.height(.51),
          );
        }
      }
    }
  }

  dynamic _enableButton() {
    return passwordEntered && emailValid;
  }

  dynamic _showWrongCredentials() {
    CustomDialogs.showCustomToast(
      context,
      Lang.of(context).wrongCredentials,
      '',
      true,
      ActionLiteral(
        label: '',
        name: '',
        message1: '',
        message2: '',
        color: colors.darkOverlay,
        showClose: false,
        position: context.height() * .05,
      ),
    );
  }

// ignore: long-method, required logic
  dynamic _showErrorDialog(
    BuildContext context,
    String title,
    String subTitle,
    double height,
  ) {
    CustomDialogs.modalError(context, _onTap);
  }

  dynamic _onTapRestorePassword(BuildContext context) {
    context.push(Routes.recoveryPasswordRoute);
  }
}
