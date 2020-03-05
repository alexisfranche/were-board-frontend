
class Event {
  final String name;
  final String description;
  final String address;
  final String datetime;
  final int managerId;
  final int eventId;

  Event(
      {this.name,
      this.description,
      this.address,
      this.datetime,
      this.managerId,
      this.eventId});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventId: json['id'],
      name: json['name'],
      description: json['description'],
      address: json['address'],
      datetime: json['datetime'],
      managerId: json['event_manager_id'] as int,
    );
  }
}