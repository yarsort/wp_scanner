import 'package:flutter/material.dart';
import 'package:wp_scanner/system/system.dart';

class ColumnListViewBuilder extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final int itemCount;

  const ColumnListViewBuilder({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection = TextDirection.ltr,
    this.verticalDirection = VerticalDirection.down,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(itemCount, (index) => itemBuilder(context, index)).toList(),
    );
  }
}

class TextFieldWithText extends StatelessWidget {
  final TextEditingController textEditingController;
  final String textLabel;
  final IconData? onPressedEditIcon;
  final IconData? onPressedDeleteIcon;
  final VoidCallback onPressedEdit;
  final VoidCallback onPressedDelete;
  final bool readOnly = true;

  const TextFieldWithText({
    Key? key,
    bool? readOnly,
    required this.textLabel,
    required this.textEditingController,
    required this.onPressedEditIcon,
    required this.onPressedDeleteIcon,
    required this.onPressedEdit,
    required this.onPressedDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 7, 14, 7),
      child: SizedBox(
        height: 40,
        child: TextField(
          keyboardType: TextInputType.text,
          readOnly: readOnly,
          controller: textEditingController,
          decoration: InputDecoration(
            isDense: true,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 2,
              minHeight: 2,
            ),
            contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            border: const OutlineInputBorder(),
            labelStyle: const TextStyle(
              color: Colors.blueGrey,
            ),
            labelText: textLabel,
            suffixIcon: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: const EdgeInsets.fromLTRB(10, 1, 1, 1),
                  onPressed: onPressedEdit,
                  icon: onPressedEditIcon != null
                      ? Icon(onPressedEditIcon, color: iconColor)
                      : Icon(onPressedEditIcon, color: Colors.white),
                ),
                IconButton(
                  onPressed: onPressedDelete,
                  icon: onPressedDeleteIcon != null
                      ? Icon(onPressedDeleteIcon, color: Colors.red)
                      : Icon(onPressedDeleteIcon, color: Colors.white),
                  //icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldWithNumber extends StatelessWidget {
  final TextEditingController textEditingController;
  final String textLabel;
  final IconData? onPressedEditIcon;
  final IconData? onPressedDeleteIcon;
  final VoidCallback onPressedEdit;
  final VoidCallback onPressedDelete;
  final bool readOnly = true;

  const TextFieldWithNumber(
      {Key? key,
      bool? readOnly,
      required this.textLabel,
      required this.textEditingController,
      required this.onPressedEditIcon,
      required this.onPressedDeleteIcon,
      required this.onPressedEdit,
      required this.onPressedDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 7, 14, 7),
      child: SizedBox(
        height: 40,
        child: TextField(
          keyboardType: TextInputType.number,
          readOnly: readOnly,
          controller: textEditingController,
          decoration: InputDecoration(
            isDense: true,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 2,
              minHeight: 2,
            ),
            contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            border: const OutlineInputBorder(),
            labelStyle: const TextStyle(
              color: Colors.blueGrey,
            ),
            labelText: textLabel,
            suffixIcon: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: const EdgeInsets.fromLTRB(10, 1, 1, 1),
                  onPressed: onPressedEdit,
                  icon: onPressedEditIcon != null
                      ? Icon(onPressedEditIcon, color: iconColor)
                      : Icon(onPressedEditIcon, color: Colors.white),
                ),
                IconButton(
                  onPressed: onPressedDelete,
                  icon: onPressedDeleteIcon != null
                      ? Icon(onPressedDeleteIcon, color: Colors.red)
                      : Icon(onPressedDeleteIcon, color: Colors.white),
                  //icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop helper us later
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 && MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    // If our width is more than 1100 then we consider it a desktop
    if (_size.width >= 1100) {
      return desktop;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (_size.width >= 850 && tablet != null) {
      return tablet!;
    }
    // Or less then that we called it mobile
    else {
      return mobile;
    }
  }
}

Widget listTileTitle(String title) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            width: 100,
            decoration: const BoxDecoration(
                border: Border(
              bottom: BorderSide(color: Colors.black12, width: 1.0),
            )),
          ),
        )
      ],
    ),
  );
}

Widget progressLoading() {
  return const SizedBox(
    height: 100,
    child: Column(
      children: [
        SizedBox(width: 20, height: 20, child: CircularProgressIndicator()),
      ],
    ),
  );
}
