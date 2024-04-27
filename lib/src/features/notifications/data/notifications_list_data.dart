class NotificationListData {
  String title;
  String description;
  String time;

  NotificationListData({
    this.title = '',
    this.description = '',
    this.time = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'time': time,
    };
  }

  factory NotificationListData.fromJson(Map<String, dynamic> json) {
    return NotificationListData(
      title: json['title'] as String,
      description: json['description'] as String,
      time: json['time'] as String,
    );
  }
}

List<dynamic> recentNotificationList = [
  NotificationListData(
    title: 'Human Interaction',
    description: 'Your fridge has been opened! Is that you?',
    time: 'now',
  ),
  NotificationListData(
    title: 'Human Interaction',
    description: 'Your fridge has been opened! Is that you?',
    time: 'now',
  ),
  NotificationListData(
    title: 'Human Interaction',
    description: 'Your fridge has been opened! Is that you?',
    time: 'now',
  ),
  NotificationListData(
    title: 'Human Interaction',
    description: 'Your fridge has been opened! Is that you?',
    time: 'now',
  ),
  NotificationListData(
    title: 'Human Interaction',
    description: 'Your fridge has been opened! Is that you?',
    time: 'now',
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
