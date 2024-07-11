import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waterhero/core/presentation/design/tokens/tokens.dart';
import 'package:waterhero/features/main/domain/select_option.dart';

class NavigationButton extends StatefulWidget {
  const NavigationButton({
    required this.options,
    required this.answer,
    required this.onSelect,
    super.key,
  });

  /// Opciones del Navegador
  final List<SelectOption>? options;

  /// Selección actual de botón
  final SelectOption? answer;

  /// Función que se ejecuta al seleccionar el botón
  final Function onSelect;

  @override
  State<NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Wrap(
          spacing: widget.options != null
              ? widget.options!.length > 4
                  ? 0
                  : 20
              : 0,
          children: (widget.options ?? [])
              .map(
                (e) => Material(
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    radius: 0,
                    onTap: () => widget.onSelect(e),
                    child: Semantics(
                      label: e.semanticLabel,
                      child: SizedBox(
                        width: e.count != null && e.count! >= 0
                            ? 50
                            : MediaQuery.of(context).size.width * .2,
                        height: e.count != null && e.count! >= 0 ? 55 : 50,
                        child: Stack(
                          fit: StackFit.expand,
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width:
                                  e.count != null && e.count! >= 0 ? 45 : null,
                              height:
                                  e.count != null && e.count! >= 0 ? 45 : null,
                              padding: e.count != null && e.count! >= 0
                                  ? const EdgeInsets.all(5)
                                  : null,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      (widget.answer!.value == e.value)
                                          ? e.description!
                                          : e.icon!,
                                      colorFilter: ColorFilter.mode(
                                        (widget.answer!.value == e.value)
                                            ? colors.white
                                            : colors.gray,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (e.count != null && e.count! > 0)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colors.white,
                                  ),
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        e.count.toString(),
                                        style: TextStyle(
                                          color: colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
