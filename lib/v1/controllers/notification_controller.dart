import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zula/v1/models/notification_model.dart';
import 'package:zula/v1/services/api_service.dart';

class NotificationController extends GetxController {

  var notficationPageIsLoading = true.obs;
  final _notificationEvents = <NotificationModel>[].obs;

  List<NotificationModel> get retrievedNotifications => _notificationEvents;

  @override
  onInit() {
    getNotifications();
    super.onInit();
  }
// 5248a3fa-81c3-4170-b136-34c0f0a54ef2
//${GetStorage().read('user_id')
  getNotifications() {
    ApiService.getRequest(
      endPoint: '/get_user_notifications/${GetStorage().read('user_id')?? '5248a3fa-81c3-4170-b136-34c0f0a54ef2'}',
      service: Services.application,
    ).then((response) {
      notficationPageIsLoading(false);
      if (response['payload']['status'] >= 200 &&
          response['payload']['status'] < 300) {
        _notificationEvents.value =
            (response['payload']['notifications'] as List)
                .map((e) => NotificationModel.fromJson(e))
                .toList();
      }
    });
  }
}
