import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterhero/core/data/network/network_checker.dart';
import 'package:waterhero/core/presentation/design/atoms/atoms.dart';
import 'package:waterhero/core/presentation/utils/custom_dialogs.dart';
import 'package:waterhero/core/presentation/utils/dimens_extension.dart';
import 'package:waterhero/core/presentation/utils/icons_paths.dart';
import 'package:waterhero/core/presentation/utils/routes.dart';
import 'package:waterhero/core/presentation/utils/validators.dart';
import 'package:waterhero/features/authentication/register/presentation/register_controller.dart';
import 'package:waterhero/localization/generated/lang.dart';

/// Esta page envuelve cualquier widget que se le envíe cómo [child]
/// dentro de el [CustomAppBar] y el [NavigationBarHibridoPage]
/// Se puede omitir alguno de ellos si la vista lo requiere
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({
    super.key,
  });
  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _serviceCodeController = TextEditingController();

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
    final controller = ref.watch(registerController.notifier);
    final state = ref.watch(registerController);
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
                        Lang.of(context).register,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                      ),
                      SizedBox(
                        height: context.height(.01),
                      ),
                      CustomText(
                        Lang.of(context).registerMessage,
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
                      CustomTextFormField(
                        semanticsLabel: 'name',
                        label: Lang.of(context).name,
                        inputValueType: InputValueType.name,
                        controller: _nameController,
                      ),
                      SizedBox(
                        height: context.height(.025),
                      ),
                      CustomTextFormField(
                        semanticsLabel: 'lastName',
                        label: Lang.of(context).lastName,
                        inputValueType: InputValueType.lastname,
                        controller: _lastNameController,
                      ),
                      SizedBox(
                        height: context.height(.025),
                      ),
                      CustomTextFormField(
                        semanticsLabel: 'serviceCode',
                        label: Lang.of(context).serviceCode,
                        inputValueType: InputValueType.document,
                        controller: _serviceCodeController,
                      ),
                      SizedBox(
                        height: context.height(.05),
                      ),
                      CustomButton(
                        semanticsLabel: 'login',
                        height: 56,
                        enabled: _enableButton(),
                        text: Lang.of(context).registerVerb,
                        onPressed: () =>
                            _enableButton() ? _onTap(controller) : null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        semanticsLabel: 'cancel',
                        height: 56,
                        buttonType: ButtonType.secondary,
                        text: Lang.of(context).cancel,
                        onPressed: () => context.pop(),
                      ),
                      SizedBox(
                        height: context.height(.03),
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

  dynamic _onTap(RegisterController controller) async {
    final networkStatus = await NetworkChecker.check(context);
    if (networkStatus) {
      CustomDialogs.showLoadingDialog(context);
      final status = await controller.register(
        _emailController.text.toLowerCase(),
        _passwordController.text,
        _nameController.text,
        _lastNameController.text,
        _serviceCodeController.text,
      );

      // ignore: prefer-extracting-callbacks, required this
      CustomDialogs.hideLoadingDialog(context);
      if (status) {
        final storage = await SharedPreferences.getInstance();
        context.go(
          Routes.comsumptionRoute,
          extra: {
            'role': storage.get('role'),
            'name': storage.get('name'),
          },
        );
      } else {
        CustomDialogs.modalError(context, _onTap);
      }
    }
  }

  dynamic _enableButton() {
    return passwordEntered && emailValid;
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
}
