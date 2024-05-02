import 'package:flutter/material.dart';
import 'package:smart_fridge/config/math/scaler.dart';
import 'package:smart_fridge/config/themes/app_theme.dart';
import 'package:smart_fridge/diary/widgets/calendar_modal_view.dart';
import 'package:smart_fridge/utils/formatters/datetime.dart';

class DatePickerController extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final Function(DateTime, DateTime) onDateChange;

  const DatePickerController({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onDateChange,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedDate = AppDatetime.formatDate(DateTime.now());

    return Row(
      children: <Widget>[
        SizedBox(
          height: 38,
          width: 38,
          child: InkWell(
            highlightColor: Colors.transparent,
            borderRadius: const BorderRadius.all(
              Radius.circular(32.0),
            ),
            onTap: () {},
            child: Center(
              child: Icon(
                Icons.keyboard_arrow_left,
                color: AppTheme.grey,
              ),
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.grey.withOpacity(0.2),
            borderRadius: const BorderRadius.all(
              Radius.circular(4.0),
            ),
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              showDialog<dynamic>(
                context: context,
                builder: (BuildContext context) => CalendarModalView(
                  barrierDismissible: true,
                  minimumDate: DateTime.now(),
                  initialEndDate: endDate,
                  initialStartDate: startDate,
                  onApplyClick: (DateTime startData, DateTime endData) {
                    onDateChange(startData, endData);
                  },
                  onCancelClick: () {},
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8,
                    ),
                    child: Icon(
                      Icons.calendar_today,
                      color: AppTheme.grey,
                      size: 18,
                    ),
                  ),
                  Text(
                    formattedDate,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: AppTheme.fontName,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      letterSpacing: -0.2,
                      color: AppTheme.darkerText,
                    ),
                    textScaleFactor: Scaler.textScaleFactor(context),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 38,
          width: 38,
          child: InkWell(
            highlightColor: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(32.0)),
            onTap: () {},
            child: Center(
              child: Icon(
                Icons.keyboard_arrow_right,
                color: AppTheme.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
