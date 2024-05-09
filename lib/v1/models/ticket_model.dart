

class Ticket {
  String id;
  String artworkPictureUrl;
  String eventTitle;
  String eventDescription;
  String eventCategory;
  String eventLocation;
  String eventDate;
  String organiserName;
  String meetUpInstructions;
  double locationLatCoordinate;
  double locationLongCoordinate;
  int interestedCount;
  List<TicketCategory> ticketCategory;
  List<TicketEventAlbum> ticketEventAlbum;
  List<EventItinerary> eventItinerary;
  List<EventActivities> eventActivities;
  List<ThingsToCarry> thingsToCarry;
  List<WhatIsProvided> whatIsProvided;

  Ticket({
    required this.id,
    required this.artworkPictureUrl,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventLocation,
    required this.eventCategory,
    required this.eventDate,
    required this.organiserName,
    required this.meetUpInstructions,
    required this.locationLatCoordinate,
    required this.locationLongCoordinate,
    required this.ticketCategory,
    required this.ticketEventAlbum,
    required this.interestedCount,
    required this.eventItinerary,
    required this.eventActivities,
    required this.thingsToCarry,
    required this.whatIsProvided,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json["id"],
      artworkPictureUrl: json["artwork_picture_url"],
      eventTitle: json["event_title"],
      eventDescription: json["event_description"],
      eventCategory: json["event_category"],
      eventLocation: json["event_location"],
      eventDate: json["event_date"],
      interestedCount: json["interested_count"] ?? 0,
      organiserName: json["organiser_name"] ?? '' ,
      meetUpInstructions: json["meet_up_instructions"],
      locationLatCoordinate: json["location_lat_coordinate"].toDouble(),
      locationLongCoordinate: json["location_long_coordinate"].toDouble(),
      ticketEventAlbum: List<TicketEventAlbum>.from(
          json["event_media_album"].map((x) => TicketEventAlbum.fromMap(x))),
      ticketCategory: List<TicketCategory>.from(
          json["ticket_category"].map((x) => TicketCategory.fromMap(x))),
      eventItinerary: List<EventItinerary>.from(
          json["event_itinerary"].map((x) => EventItinerary.fromMap(x))),
      eventActivities: List<EventActivities>.from(
          json["event_activities"].map((x) => EventActivities.fromMap(x))),
      thingsToCarry: List<ThingsToCarry>.from(
          json["things_to_carry"].map((x) => ThingsToCarry.fromMap(x))),
      whatIsProvided: List<WhatIsProvided>.from(
          json["what_is_provided"].map((x) => WhatIsProvided.fromMap(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "artwork_picture_url": artworkPictureUrl,
        "event_title": eventTitle,
        "event_category": eventCategory,
        "event_description": eventDescription,
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

class TicketEventAlbum {
  String assetUrl;
  String title;
  String description;

  TicketEventAlbum({
    required this.assetUrl,
    required this.title,
    required this.description,
  });

  factory TicketEventAlbum.fromMap(Map<String, dynamic> json) =>
      TicketEventAlbum(
        assetUrl: json["asset_url"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "asset_url": assetUrl,
        "title": title,
        "description": description,
      };
}

class EventItinerary {
  String assetUrl;
  String title;
  String description;

  EventItinerary({
    required this.assetUrl,
    required this.title,
    required this.description,
  });

  factory EventItinerary.fromMap(Map<String, dynamic> json) => EventItinerary(
        assetUrl: json["asset_url"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "asset_url": assetUrl,
        "title": title,
        "description": description,
      };
}

class EventActivities {
  // String assetUrl;
  String title;
  // String description;

  EventActivities({
    // required this.assetUrl,
    required this.title,
    // required this.description,
  });

  factory EventActivities.fromMap(Map<String, dynamic> json) => EventActivities(
        // assetUrl: json["asset_url"],
        title: json["title"],
        // description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        // "asset_url": assetUrl,
        "title": title,
        // "description": description,
      };
}

class ThingsToCarry {
  String title;
  String description;

  ThingsToCarry({
    required this.title,
    required this.description,
  });

  factory ThingsToCarry.fromMap(Map<String, dynamic> json) => ThingsToCarry(
        title: json["title"],
        description: json["description"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
      };
}

class WhatIsProvided {
  String title;
  String description;

  WhatIsProvided({
    required this.title,
    required this.description,
  });

  factory WhatIsProvided.fromMap(Map<String, dynamic> json) => WhatIsProvided(
        title: json["title"],
        description: json["description"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
      };
}
