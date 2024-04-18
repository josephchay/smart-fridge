class NotificationListData {
  String title;
  String description;
  String time;

  NotificationListData({
    this.title = '',
    this.description = '',
    this.time = '',
  });
}

final List<NotificationListData> recentNotificationList =
    <NotificationListData>[
  NotificationListData(
    title: 'Human Interaction',
    description: 'Your fridge has been opened',
    time: 'now',
  ),
  NotificationListData(
    title: 'Item Duration',
    description: 'Your cabbage has been placed here for 24 days.',
    time: '2 hours ago',
  ),
  NotificationListData(
    title: 'Human Interaction',
    description: 'Your fridge has been opened',
    time: '3 hours ago',
  ),
];

final List<NotificationListData> yesterdayNotificationList =
    <NotificationListData>[
  NotificationListData(
    title: 'Human Interaction',
    description: 'Your fridge has been opened',
    time: '5:17pm',
  ),
  NotificationListData(
    title: 'Item Duration',
    description: 'Your Eggs have been placed here for 30 days.',
    time: '9am',
  ),
];
