import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:waterhero/core/data/network/network_checker.dart';
import 'package:waterhero/core/presentation/design/atoms/atoms.dart';
import 'package:waterhero/core/presentation/utils/custom_dialogs.dart';
import 'package:waterhero/core/presentation/utils/dimens_extension.dart';
import 'package:waterhero/core/presentation/utils/icons_paths.dart';
import 'package:waterhero/core/presentation/utils/routes.dart';
import 'package:waterhero/core/presentation/utils/validators.dart';
import 'package:waterhero/features/authentication/restore_password/presentation/restore_controller.dart';
import 'package:waterhero/localization/generated/lang.dart';

/// Esta page envuelve cualquier widget que se le envíe cómo [child]
/// dentro de el [CustomAppBar] y el [NavigationBarHibridoPage]
/// Se puede omitir alguno de ellos si la vista lo requiere
class RestorePage extends ConsumerStatefulWidget {
  const RestorePage({
    super.key,
  });
  @override
  ConsumerState<RestorePage> createState() => _RestorePageState();
}

class _RestorePageState extends ConsumerState<RestorePage> {
  final TextEditingController _emailController = TextEditingController();

  bool emailValid = false;

  @override
  void initState() {
    _emailController.addListener(() {
      emailValid = _emailController.text.isNotEmpty &&
          validateEmail(_emailController.text, true) == null;
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //login state and cotroller
    final controller = ref.watch(restoreController.notifier);
    final state = ref.watch(restoreController);
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
                        Lang.of(context).forgotMyPassword,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                      ),
                      SizedBox(
                        height: context.height(.01),
                      ),
                      CustomText(
                        Lang.of(context).forgotMyPasswordMessage,
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
                        height: context.height(.05),
                      ),
                      CustomButton(
                        semanticsLabel: 'send',
                        height: 56,
                        enabled: _enableButton(),
                        text: Lang.of(context).send,
                        onPressed: () =>
                            _enableButton() ? _onTap(controller) : null,
                      ),
                      SizedBox(
                        height: context.height(.03),
                      ),
                      CustomButton(
                        semanticsLabel: 'send',
                        height: 56,
                        text: Lang.of(context).cancel,
                        buttonType: ButtonType.secondary,
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

  dynamic _onTap(RestoreController controller) async {
    final networkStatus = await NetworkChecker.check(context);
    if (networkStatus) {
      CustomDialogs.showLoadingDialog(context);
      final status = await controller.restore(
        _emailController.text.toLowerCase(),
      );

      // ignore: prefer-extracting-callbacks, required this
      CustomDialogs.hideLoadingDialog(context);
      if (status) {
        CustomDialogs.showCustomModal(
          child: Container(
            height: context.height(.33),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: context.fromLTRB(.05, .05, .05, .05),
            child: Column(
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 50),
                const SizedBox(height: 20),
                CustomText(
                  Lang.of(context).emailSent,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 20),
                CustomText(
                  Lang.of(context).emailSentMessage,
                  fontSize: 16,
                  height: 1.3,
                  fontWeight: FontWeight.w400,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  semanticsLabel: 'send',
                  height: 56,
                  text: Lang.of(context).ok,
                  onPressed: () {
                    context.pop();
                    context.pushReplacement(Routes.loginRoute);
                  },
                ),
              ],
            ),
          ),
          context: context,
          isFullScreen: false,
        );
      } else {
        CustomDialogs.modalError(context, _onTap);
      }
    }
  }

  dynamic _enableButton() {
    return emailValid;
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
