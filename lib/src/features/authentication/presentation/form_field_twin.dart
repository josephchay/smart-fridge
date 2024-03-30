import 'package:flutter/material.dart';
import 'package:smart_fridge/src/features/authentication/presentation/form_field.dart';

class AppAuthFormFieldTwin extends StatelessWidget {
  const AppAuthFormFieldTwin({
    super.key,
    required this.firstLabel,
    required this.firstLabelHint,
    required this.firstIcon,
    required this.firstInputType,
    required this.secondLabel,
    required this.secondLabelHint,
    required this.secondIcon,
    required this.secondInputType,
    this.firstExpands = false,
    this.secondExpands = false,
  });

  final bool firstExpands;
  final String firstLabel;
  final String firstLabelHint;
  final IconData firstIcon;
  final TextInputType firstInputType;
  final bool secondExpands;
  final String secondLabel;
  final String secondLabelHint;
  final IconData secondIcon;
  final TextInputType secondInputType;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: AppAuthFormField(
            label: firstLabel,
            labelHint: firstLabelHint,
            icon: firstIcon,
            inputType: firstInputType,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AppAuthFormField(
            label: secondLabel,
            labelHint: secondLabelHint,
            icon: secondIcon,
            inputType: secondInputType,
          ),
        ),
      ],
    );
  }
}
