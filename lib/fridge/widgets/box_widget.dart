import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_fridge/commons/widgets/snackbar.dart';
import 'package:smart_fridge/fridge/models/recognition_model.dart';
import 'package:smart_fridge/src/features/notifications/data/notifications_list_model.dart';

/// Individual bounding box
class BoxWidget extends StatefulWidget {
  final Recognition result;

  const BoxWidget({
    super.key,
    required this.result,
  });

  @override
  _BoxWidgetState createState() => _BoxWidgetState();
}

class _BoxWidgetState extends State<BoxWidget> {
  bool _notificationSent = false;

  var notificationList = GetStorage().read('notifications');

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();

    // Color for bounding box
    Color color = Colors.primaries[(widget.result.label.length +
            widget.result.label.codeUnitAt(0) +
            widget.result.id) %
        Colors.primaries.length];

    if (widget.result.label == 'person' && !_notificationSent) {
      _notificationSent = true;
      addItemToStorage(NotificationListData(
        title: 'Person Detected',
        description: 'Your fridge has been opened! Is that you?!',
        time: DateTime.now().toString(),
      ));
    }

    return Positioned(
      left: widget.result.renderLocation.left,
      top: widget.result.renderLocation.top,
      width: widget.result.renderLocation.width,
      height: widget.result.renderLocation.height,
      child: Container(
        width: widget.result.renderLocation.width,
        height: widget.result.renderLocation.height,
        decoration: BoxDecoration(
            border: Border.all(color: color, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(2))),
        child: Align(
          alignment: Alignment.topLeft,
          child: FittedBox(
            child: Container(
              color: color,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(widget.result.label),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addItemToStorage(NotificationListData item) {
    final localStorage = GetStorage();

    var rawListings = localStorage.read('notifications');

    List<dynamic> notificationList;

    if (rawListings != null) {
      try {
        notificationList = jsonDecode(rawListings);
      } catch (e) {
        print("Error decoding stored data: $e");
        notificationList = [];
      }
    } else {
      notificationList = [];
    }

    notificationList.add(item.toJson());
    localStorage.write('notifications', jsonEncode(notificationList));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppSnackbar.warning(
          message: 'Your fridge has been opened! Is that you?!');
    });
  }
}
