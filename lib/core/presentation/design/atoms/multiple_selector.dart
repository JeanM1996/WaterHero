import 'package:flutter/material.dart';
import 'package:waterhero/core/presentation/design/atoms/atoms.dart';
import 'package:waterhero/core/presentation/design/tokens/colors.dart';
import 'package:waterhero/core/presentation/utils/custom_dialogs.dart';
import 'package:waterhero/core/presentation/utils/dimens_extension.dart';

class MultipleSelector extends StatefulWidget {
  const MultipleSelector({
    required this.items,
    required this.context,
    super.key,
    this.label,
    this.hintText,
    this.onChanged,
    this.value,
    this.enabled = true,
    this.error,
    this.errorText,
    this.suffixAction,
    this.hasImage = false,
    this.height,
    this.hideLabel = false,
    this.formField = false,
    this.hasSubtitle = false,
    this.isInkRow = false,
    this.widgetRow = const SizedBox(),
  });
  final List<dynamic> items;
  final String? label;
  final String? hintText;
  final Function(dynamic)? onChanged;
  final List<dynamic>? value;
  final bool? enabled;
  final bool? error;
  final String? errorText;
  final BuildContext context;
  final Widget? suffixAction;
  final bool? hasImage;
  final double? height;
  final bool? hideLabel;
  final bool? formField;
  final bool? hasSubtitle;
  final bool? isInkRow;
  final Widget? widgetRow;
  @override
  State<MultipleSelector> createState() => _MultipleSelectorState();
}

class _MultipleSelectorState extends State<MultipleSelector> {
  @override
  void initState() {
    if (widget.value!.isNotEmpty) {
      //set the status of items of value array to items array
      final items = widget.value;
      widget.items.clear();
      widget.items.addAll(items!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.hideLabel!)
          Container()
        else
          widget.suffixAction != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      '${widget.label}',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      textColor: colors.gray,
                    ),
                    widget.suffixAction!,
                  ],
                )
              //ignore:avoid-nested-conditional-expressions, required logic
              : widget.label != null
                  ? CustomText(
                      widget.label ?? '',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      textColor: colors.gray,
                    )
                  : Container(),
        const SizedBox(height: 10),
        if (widget.isInkRow!)
          InkWell(
            onTap: () => widget.enabled! ? _openBottom() : () {},
            child: widget.widgetRow,
          )
        else
          InkWell(
            onTap: () => widget.enabled! ? _openBottom() : () {},
            child: Container(
              height: widget.height ?? double.infinity,
              decoration: BoxDecoration(
                color: _getBackgroundColor(),
                borderRadius:
                    BorderRadius.circular(widget.formField! ? 30 : 10),
                border: Border.all(
                  color: widget.error == true
                      ? colors.orange
                      : colors.shadowBlack.withOpacity(.3),
                ),
              ),
              padding: context.symetric(.025, 0),
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: SizedBox(
                      child: CustomText(
                        widget.formField!
                            //(5) item.name, item.name, item.name, item.name, item.name
                            ? widget.value!.isEmpty
                                ? widget.hintText ?? ''
                                //ignore: avoid-nested-conditional-expressions, required logic
                                : "${_getSelectedItemsCounts() == 0 ? "" : "(${_getSelectedItemsCounts() + 1})"} ${widget.value!.where((element) => element.isSelected).map((e) => e.name).toList().join(", ")}"
                            : "${widget.value!.isEmpty ? widget.hintText ?? "" : widget.value!.where((element) => element.isSelected).first.name} ${_getSelectedItemsCounts() == 0 ? "" : "+${_getSelectedItemsCounts()}"}",
                        textColor: colors.black,
                        fontSize: widget.formField! ? 15 : 13,
                        fontWeight: FontWeight.w500,
                        maxLines: widget.formField! ? 1 : 2,
                        overflow:
                            widget.formField! ? TextOverflow.ellipsis : null,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Icon(
                      Icons.expand_more,
                      color: colors.gray,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Color _getBackgroundColor() {
    return widget.enabled!
        ? widget.value!.isEmpty
            ? colors.white
            //ignore:avoid-nested-conditional-expressions, required logic
            : widget.formField!
                ? colors.white
                : colors.blue.withOpacity(.15)
        : colors.grey10;
  }

  dynamic _getSelectedItemsCounts() {
    return widget.value!.length > 1
        ? widget.items.where((element) => element.isSelected).length - 1
        : 0;
  }

  dynamic _calculateListHeight() {
    //avoid overflow 80 pixels
    if (widget.items.length > 6) {
      return MediaQuery.of(context).size.height * .6 - 105;
    }
    if (widget.items.length > 3) {
      return MediaQuery.of(context).size.height * .4 - 80;
    }
    if (widget.items.isNotEmpty) {
      return MediaQuery.of(context).size.height * .3 - 80;
    }
  }

  //ignore: long-method, required logic
  dynamic _openBottom() {
    CustomDialogs.showBottomSheet(
      context: context,
      child: IntrinsicHeight(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: context.all(.05),
                child: Row(
                  children: [
                    CustomText(
                      widget.label ?? '',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      textColor: colors.black,
                    ),
                    const Spacer(),
                    //close button
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: Icon(
                          Icons.close,
                          color: colors.gray,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //line separator
              Container(
                width: double.infinity,
                height: 1,
                color: colors.whiteBereus,
              ),
              SizedBox(
                child: Container(
                  height: _calculateListHeight(),
                  padding: context.symetric(.02, 0),
                  child: widget.items.isEmpty
                      ? Container()
                      //checkbolisttile
                      : ListView.builder(
                          itemCount: widget.items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 1,
                              ),
                              child: Column(
                                children: <Widget>[
                                  CheckboxListTile(
                                    activeColor: colors.blue,
                                    dense: true,
                                    //rounded rectangle
                                    checkboxShape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),

                                    //font change
                                    title: CustomText(
                                      widget.items[index].name,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      textColor: colors.black,
                                    ),
                                    value: widget.items[index].isSelected,
                                    subtitle: widget.hasSubtitle!
                                        ? CustomText(
                                            '${widget.items[index].subtitle}',
                                            fontWeight: FontWeight.w400,
                                            textColor: colors.gray,
                                          )
                                        : null,
                                    //ignore:avoid-nested-conditional-expressions, required logic
                                    secondary: widget.hasImage!
                                        ? ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                            child: Image.network(
                                              widget.items[index].image,
                                              width: 30,
                                              height: 30,
                                            ),
                                          )
                                        : null,
                                    //ignore:prefer-extracting-callbacks, req logic
                                    onChanged: (bool? val) {
                                      setState(() {
                                        //copywith to update the list
                                        final item = widget.items[index]
                                            .copyWith(isSelected: val);
                                        widget.items[index] = item;

                                        widget.onChanged!(widget.items);
                                        //close and open to update the list
                                        Navigator.pop(context);
                                        //open
                                        _openBottom();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
