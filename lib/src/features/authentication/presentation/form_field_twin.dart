import 'package:flutter/material.dart';
import 'package:smart_fridge/src/features/authentication/presentation/form_field.dart';

class AppAuthFormFieldTwin extends StatelessWidget {
  final String firstLabel;
  final String firstLabelHint;
  final IconData firstIcon;
  final TextInputType firstInputType;
  final TextEditingController firstController;
  final String? Function(String?) firstValidator;
  final bool firstExpands;
  final String secondLabel;
  final String secondLabelHint;
  final IconData secondIcon;
  final TextInputType secondInputType;
  final TextEditingController secondController;
  final String? Function(String?) secondValidator;
  final bool secondExpands;

  const AppAuthFormFieldTwin({
    super.key,
    required this.firstLabel,
    required this.firstLabelHint,
    required this.firstIcon,
    required this.firstInputType,
    required this.firstController,
    required this.firstValidator,
    this.firstExpands = false,
    required this.secondLabel,
    required this.secondLabelHint,
    required this.secondIcon,
    required this.secondInputType,
    required this.secondController,
    required this.secondValidator,
    this.secondExpands = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: AppAuthFormField(
            expands: firstExpands,
            label: firstLabel,
            labelHint: firstLabelHint,
            icon: firstIcon,
            inputType: firstInputType,
            controller: firstController,
            validator: firstValidator,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AppAuthFormField(
            expands: secondExpands,
            label: secondLabel,
            labelHint: secondLabelHint,
            icon: secondIcon,
            inputType: secondInputType,
            controller: secondController,
            validator: secondValidator,
          ),
        ),
      ],
    );
  }
}
