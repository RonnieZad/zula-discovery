import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zula/v1/constants/strings.dart';
import 'package:zula/v1/models/ticket_model.dart';
import 'package:zula/v1/services/api_service.dart';

class TickerController extends GetxController {
  var ticketsToBuy = [].obs;
  var totalAmount = 0.0.obs;

  TextEditingController phoneNumberTextEditingController =
      TextEditingController();

  var showPaymentProcessing = false.obs;

  var ticketPageIsLoading = true.obs;
  final _eventTickets = <Ticket>[].obs;
  final filteredEventTickets = <Ticket>[].obs;
  // final _eventTickets = <Ticket>[].obs;
  List<Ticket> get retrievedEventTickets => _eventTickets;
  // List<Ticket> get filteredEventTickets => _eventTickets;

  @override
  onInit() {
    getEventTickets();
    super.onInit();
  }

  getEventTickets() {
    ApiService.getRequest(
            endPoint: '/get_event_tickets', service: Services.application)
        .then((response) {
      print(response['payload']['tickets']);
      ticketPageIsLoading(false);
      if (response['payload']['status'] >= 200 &&
          response['payload']['status'] < 300) {
        _eventTickets.value = (response['payload']['tickets'] as List)
            .map((e) => Ticket.fromJson(e))
            .toList();
        filteredEventTickets.value = _eventTickets;
      }
    });
  }

//implent this to filter ticket events and return filteredEventTickets
  filterEventCategory(int tabIndex) {
    String selectedLabel =
        experienceTabCategories[tabIndex]['label'].toLowerCase();

    if (selectedLabel == 'all') {
      filteredEventTickets.value = retrievedEventTickets;
    } else {
      filteredEventTickets.value = retrievedEventTickets.where((ticket) {
        // Assuming eventType is the property that holds the event label
        String eventType = ticket.eventCategory.toLowerCase();

        // Filter events based on the selected label
        return eventType == selectedLabel;
      }).toList();
    }
  }

  // Define a function to calculate the total amount
  double calculateTotalAmount(ticketCategory) {
    double totalAmount = 0.0;

    for (int i = 0; i < ticketCategory.length; i++) {
      totalAmount += (ticketCategory[i].ticketPrice * ticketsToBuy[i]) +
          1000 * ticketsToBuy[i];
    }

    return totalAmount;
  }

// Define a function to handle incrementing the number of tickets for a category
  void incrementTickets(int index, List<TicketCategory> ticketCategory) {
    if (index < ticketsToBuy.length && ticketsToBuy[index] < 20) {
      // Assuming maximum limit of 20 tickets per category

      ticketsToBuy[
          index]++; // Increment the ticket count at the specified index

      HapticFeedback.selectionClick();
      // Update the total amount
      totalAmount.value = calculateTotalAmount(ticketCategory);
    }
  }

// Define a function to handle decrementing the number of tickets for a category
  void decrementTickets(int index, List<TicketCategory> ticketCategory) {
    if (index >= 0 && index < ticketsToBuy.length) {
      if (ticketsToBuy[index] > 0) {
        // Ensure the count is positive before decrementing
        ticketsToBuy[
            index]--; // Decrement the ticket count at the specified index
      }
      HapticFeedback.selectionClick();
      // Update the total amount
      totalAmount.value = calculateTotalAmount(ticketCategory);
    }
  }
}
