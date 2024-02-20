import 'dart:convert';

class Ticket {
  String artworkPictureUrl;
  String eventTitle;
  String eventLocation;
  String eventDate;
  double locationLatCoordinate;
  double locationLongCoordinate;
  List<TicketCategory> ticketCategory;

  Ticket({
    required this.artworkPictureUrl,
    required this.eventTitle,
    required this.eventLocation,
    required this.eventDate,
    required this.locationLatCoordinate,
    required this.locationLongCoordinate,
    required this.ticketCategory,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      artworkPictureUrl: json["artwork_picture_url"],
      eventTitle: json["event_title"],
      eventLocation: json["event_location"],
      eventDate: json["event_date"],
      locationLatCoordinate: json["location_lat_coordinate"].toDouble(),
      locationLongCoordinate: json["location_long_coordinate"].toDouble(),
      ticketCategory: List<TicketCategory>.from(
          json["ticket_category"].map((x) => TicketCategory.fromMap(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "artwork_picture_url": artworkPictureUrl,
        "event_title": eventTitle,
        "event_location": eventLocation,
        "event_date": eventDate,
        "location_lat_coordinate": locationLatCoordinate,
        "location_long_coordinate": locationLongCoordinate,
        "ticket_category":
            List<dynamic>.from(ticketCategory.map((x) => x.toMap())),
      };
}

class TicketCategory {
  String ticketName;
  int ticketPrice;
  int ticketCount;

  TicketCategory({
    required this.ticketName,
    required this.ticketPrice,
    required this.ticketCount,
  });

  factory TicketCategory.fromMap(Map<String, dynamic> json) => TicketCategory(
        ticketName: json["ticket_name"],
        ticketPrice: json["ticket_price"],
        ticketCount: json["ticket_count"],
      );

  Map<String, dynamic> toMap() => {
        "ticket_name": ticketName,
        "ticket_price": ticketPrice,
        "ticket_count": ticketCount,
      };
}
