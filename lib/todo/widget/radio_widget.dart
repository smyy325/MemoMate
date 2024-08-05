import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_notebook_project/todo/provider/radio_provider.dart';

class RadioWidget extends ConsumerWidget {
  const RadioWidget( {super.key, required this.titleRadio, required this.categoryColor, required this.valueInput, required this.onChangeValue});

  final String titleRadio;
  final Color categoryColor;
  final int valueInput;
  final VoidCallback onChangeValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radio=ref.watch(radioProvider);
    return Material(
      child: Theme(
        data: ThemeData(unselectedWidgetColor: categoryColor),
        child: RadioListTile(
          activeColor: categoryColor,
          contentPadding: EdgeInsets.zero,
            title: Transform.translate(
                offset: Offset(
                  -22,0
                ),
              child: Text(
                titleRadio,
                style: TextStyle(
                  color: categoryColor,fontWeight: FontWeight.w700,
                ),
              ),
            ),
            value: valueInput,
            groupValue: radio,
            onChanged: (value)=>onChangeValue(),
        ),
      ),
    );
  }
}
