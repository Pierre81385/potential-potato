class TimeOfDay {
  final int hour;
  final int minute;

  TimeOfDay({
    required this.hour,
    required this.minute,
  });

  factory TimeOfDay.fromJson(Map<String, dynamic> json) {
    return TimeOfDay(
      hour: json['hour'],
      minute: json['minute'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hour': hour,
      'minute': minute,
    };
  }
}
