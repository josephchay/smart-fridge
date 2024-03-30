class NotificationListData {
  NotificationListData({
    this.imagePath = '',
    this.titleTxt = '',
  });

  String imagePath;
  String titleTxt;

  static List<NotificationListData> notificationList = <NotificationListData>[
    NotificationListData(
      imagePath: 'assets/images/temp/onion.jpg',
      titleTxt: 'Your onions are about to run out of freshness!',
    ),
    NotificationListData(
      imagePath: 'assets/images/temp/pork.jpg',
      titleTxt: 'Your pork is starting to rot!',
    ),
    NotificationListData(
      imagePath: 'assets/images/temp/cabbage.webp',
      titleTxt: 'Your cabbage is starting to get yellow!',
    ),
  ];
}
