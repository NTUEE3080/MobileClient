class PushNotification {
  PushNotification({
    this.title,
    this.body,
    this.dataTitle,
    this.dataBody,
    this.targetAud,
    this.type,
    this.icon,
  });

  String? icon;
  String? targetAud;
  String? type;
  String? title;
  String? body;
  String? dataTitle;
  String? dataBody;
}
