class NotificationModel {
  final String id;
  final String userId;
  final String category;
  final String title;
  final DateTime eventDate;
  final String description;
  final String longDescription;
  final String action;
  final String? link;
  final List<PurchasedTicket?>? tickets;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.category,
    required this.title,
    required this.eventDate,
    required this.description,
    required this.longDescription,
    required this.action,
    this.link,
     this.tickets,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      userId: json['user_id'],
      category: json['category'],
      title: json['title'],
      eventDate: DateTime.parse(json['event_date']),
      description: json['description'],
      longDescription: json['long_description'],
      action: json['action'],
      link: json['link'],
      tickets: json['ticket'] == null ? []: (json['ticket'] as List)
          .map((ticket) => PurchasedTicket.fromJson(ticket))
          .toList() ,
    );
  }
}

class PurchasedTicket {
  final String id;
  final String ticketId;
  final String ticketVerifiableData;
  final DateTime purchasedDate;

  PurchasedTicket({
    required this.id,
    required this.ticketId,
    required this.ticketVerifiableData,
    required this.purchasedDate,
  });

  factory PurchasedTicket.fromJson(Map<String, dynamic> json) {
    return PurchasedTicket(
      id: json['id'],
      ticketId: json['ticket_id'],
      ticketVerifiableData: json['ticket_verifiable_data'],
      purchasedDate: DateTime.parse(json['Purchased_date']),
    );
  }
}
