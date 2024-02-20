import 'package:get/get.dart';
import 'package:zula/v1/models/ticket_model.dart';
import 'package:zula/v1/services/api_service.dart';

class TickerController extends GetxController {
  var ticketsToBuy = 1.obs;
  List tickets = [
    'https://images.quicket.co.za/0563469_0.jpeg',
    'https://images.quicket.co.za/0561245_0.jpeg'
  ];

  var ticketPageIsLoading = true.obs;
  final _eventTickets = <Ticket>[].obs;
  List<Ticket> get retrievedEvnetTickets => _eventTickets;

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
      }
    });
  }
}
