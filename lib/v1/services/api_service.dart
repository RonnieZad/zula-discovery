//  ZOFI CASH MOBILE APP
//
//  Created by Ronald Zad Muhanguzi .
//  2022, Zofi Cash App. All rights reserved.

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:http/retry.dart';

enum Services {
  authentication,
  payment,
  application,
  network,
}

class ApiService {
  static final ApiService _instance = ApiService._();

  // using a factory is important
  // because it promises to return _an_object of this type
  // but it doesn't promise to make a new one.
  factory ApiService() {
    return _instance;
  }

  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  ApiService._();

// static String authApi({version = 'v1', environment = 'staging'}) => 'https://${environment}-auth-api.zoficash.com/api/$version';
  static String authApi({version = 'v1', environment = 'staging'}) =>
      'https://zula-api-gateway-v1.fly.dev/auth';

  static String applicationApi({version = 'v1', environment = 'staging'}) =>
      'https://zula-api-gateway-v1.fly.dev/application';
  static String paymentApi({version = 'v1', environment = 'staging'}) =>
      'https://zula-api-gateway-v1.fly.dev/payment';

  static String networkApi({version = 'v1', environment = 'staging'}) => '';

  static getApi({required Services apiService, required String version}) {
    switch (apiService) {
      case Services.authentication:
        return authApi(version: version);
      case Services.payment:
        return paymentApi(version: version);
      case Services.application:
        return applicationApi(version: version);
      case Services.network:
        return networkApi(version: version);

      default:
    }
  }

  ///Generic get request method, takes params [endpoint] : `String`, [tokenRequired] : `bool`, [apiVersion] : `String`
  ///and returns response if response body is not empty, and gracefully throws error statusCode 500 if any
  ///and catches any network exception that may result

  // static Future<Map<String, dynamic>> getRequest(
  //     {required String endPoint,
  //     required Services service,
  //     bool tokenRequired = true,
  //     apiVersion = 'v1'}) async {
  //   try {
  //     // CustomOverlay.showLoaderOverlay(duration: 2);
  //     // String token = tokenRequired ? GetStorage().read('token') : '';
  //     // ignore: prefer_typing_uninitialized_variables
  //     var requestResponse;
  //     var client = RetryClient(http.Client(), retries: 5);

  //     await client
  //         .get(
  //           Uri.parse(
  //               getApi(apiService: service, version: apiVersion) + endPoint),
  //           // headers: {'Authorization': 'Bearer $token'}
  //         )
  //         .timeout(
  //           Duration(seconds: 20),
  //           onTimeout: () {
  //             print("opppsss");
  //             return requestResponse;
  //           },
  //         )
  //         .then((response) async => requestResponse = {
  //               'statusCode': response.statusCode,
  //               'payload':
  //                   response.body.isNotEmpty ? jsonDecode(response.body) : {},
  //             })
  //         .catchError((onError) {
  //           // Errors.displayException(onError);
  //           return requestResponse = {
  //             'statusCode': 500,
  //             'payload': {'error': 'Something wrong happened'}
  //           };
  //         });
  //     return requestResponse;
  //   } on Exception catch (exception) {
  //     // Errors.displayException(exception);
  //     return {
  //       'statusCode': 500,
  //       'payload': {'error': 'Something wrong happened'}
  //     };
  //   }
  // }

  static Future<Map<String, dynamic>> getRequest({
    required String endPoint,
    required Services service,
    bool tokenRequired = true,
    String apiVersion = 'v1',
  }) async {
    try {
      var client = RetryClient(http.Client(), retries: 20);
      var response = await client
          .get(
            Uri.parse(
                getApi(apiService: service, version: apiVersion) + endPoint),
          )
          .timeout(const Duration(seconds: 10));
      log("from there___ ${response.body}");
      return {
        'statusCode': response.statusCode,
        'payload': response.body.isNotEmpty ? jsonDecode(response.body) : {},
      };
    } on http.ClientException catch (_) {
      return {
        'statusCode': 500,
        'payload': {"status": 500, 'error': 'Client exception occurred'}
      };
    } on TimeoutException catch (_) {
      return {
        'statusCode': 500,
        'payload': {"status": 500, 'error': 'Request timed out'}
      };
    } catch (_) {
      return {
        'statusCode': 500,
        'payload': {"status": 500, 'error': 'Something wrong happened'}
      };
    }
  }

  static Future<Map<String, dynamic>> getNetworkRequest(
      {required String endPoint,
      required Services service,
      bool tokenRequired = true,
      apiVersion = 'v1'}) async {
    try {
      // CustomOverlay.showLoaderOverlay(duration: 2);

      // ignore: prefer_typing_uninitialized_variables
      var requestResponse;
      await http
          .get(
            Uri.parse(endPoint),
          )
          .then((response) async => requestResponse = {
                'statusCode': response.statusCode,
                'payload':
                    response.body.isNotEmpty ? jsonDecode(response.body) : {},
              })
          .catchError((onError) {
        // Errors.displayException(onError);

        return requestResponse = {
          'statusCode': 500,
          'payload': {'error': 'Something wrong happened'}
        };
      });
      return requestResponse;
    } on Exception catch (exception) {
      // Errors.displayException(exception);
      return {
        'statusCode': 500,
        'payload': {'error': 'Something wrong happened'}
      };
    }
  }

  ///Generic post request method, takes params [endpoint] : `String`,  [body]: `Map<String, dynamic>`, [tokenRequired] : `bool`, [apiVersion] : `String`
  ///and returns response if response body is not empty, and gracefully throws error statusCode 500 if any
  ///and catches any network exception that may result
  static Future postRequest(
      {required String endPoint,
      required Services service,
      required Map<String, dynamic> body,
      bool tokenRequired = true,
      bool showloader = true,
      apiVersion = 'v1'}) async {
    try {
      if (showloader) {
        // ScreenOverlay.showLoaderOverlay(duration: 2);
      }

      String? token = tokenRequired ? GetStorage().read('token') : '';

      // ignore: prefer_typing_uninitialized_variables
      var requestResponse;
      await http.post(
          Uri.parse(
              getApi(apiService: service, version: apiVersion) + endPoint),
          body: jsonEncode(body),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          }).then((response) async {
        // dismissAllToast();
        return requestResponse = {
          'statusCode': response.statusCode,
          'payload': response.body.isNotEmpty ? jsonDecode(response.body) : {},
        };
      }).catchError((onError) {
        // Errors.displayException(onError);
        return requestResponse = {
          'statusCode': 500,
          'payload': {'error': 'Something wrong happened'}
        };
      });
      print(requestResponse);
      // dismissAllToast();
      HapticFeedback.lightImpact();
      return requestResponse;
    } on Exception catch (exception) {
      // Errors.displayException(exception);
    }
  }

  // static Future putRequest(
  //     {required String endPoint,
  //     required Services service,
  //     required Map<String, dynamic> body,
  //     bool tokenRequired = true,
  //     bool showloader = true,
  //     apiVersion = 'v1'}) async {
  //   try {
  //     if (showloader) {
  //       ScreenOverlay.showLoaderOverlay(duration: 2);
  //     }

  //     String? token = tokenRequired ? GetStorage().read('token') : '';

  //     // ignore: prefer_typing_uninitialized_variables
  //     var requestResponse;
  //     await http.put(
  //         Uri.parse(
  //             getApi(apiService: service, version: apiVersion) + endPoint),
  //         body: jsonEncode(body),
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //           'Content-Type': 'application/json'
  //         }).then((response) async {
  //       dismissAllToast();
  //       return requestResponse = {
  //         'statusCode': response.statusCode,
  //         'payload': response.body.isNotEmpty ? jsonDecode(response.body) : {},
  //       };
  //     }).catchError((onError) {
  //       // Errors.displayException(onError);
  //       return requestResponse = {
  //         'statusCode': 500,
  //         'payload': {'error': 'Something wrong happened'}
  //       };
  //     });
  //     print(requestResponse);
  //     dismissAllToast();
  //     HapticFeedback.lightImpact();
  //     return requestResponse;
  //   } on Exception catch (exception) {
  //     // Errors.displayException(exception);
  //   }
  // }

  ///Generic patch request method, takes params [endpoint] : `String`,  [body]: `Map<String, dynamic>`, [tokenRequired] : `bool`, [apiVersion] : `String`
  ///and returns response if response body is not empty, and gracefully throws error statusCode 500 if any
  ///and catches any network exception that may result
  // static Future patchRequest(
  //     {required String endPoint,
  //     required Services service,
  //     required Map<String, dynamic> body,
  //     bool tokenRequired = true,
  //     apiVersion = 'v1'}) async {
  //   try {
  //     ScreenOverlay.showLoaderOverlay(duration: 3);
  //     String token = tokenRequired ? GetStorage().read('token') : '';
  //     // ignore: prefer_typing_uninitialized_variables
  //     var requestResponse;
  //     await http
  //         .patch(
  //             Uri.parse(
  //                 getApi(apiService: service, version: apiVersion) + endPoint),
  //             body: body,
  //             headers: {'Authorization': 'Bearer $token'})
  //         .then((response) async => requestResponse = {
  //               'statusCode': response.statusCode,
  //               'response':
  //                   response.body.isNotEmpty ? jsonDecode(response.body) : {},
  //             })
  //         .catchError((onError) {
  //           Errors.displayException(onError);
  //           return requestResponse = {
  //             'statusCode': 500,
  //             'response': {'errors': 'Something wrong happened'}
  //           };
  //         });
  //     return requestResponse;
  //   } on Exception catch (exception) {
  //     Errors.displayException(exception);
  //   }
  // }

  // ///Generic delete request method, takes params [endpoint] : `String`, [tokenRequired] : `bool`, [apiVersion] : `String`
  // ///and returns response if response body is not empty, and gracefully throws error statusCode 500 if any
  // ///and catches any network exception that may result
  // static Future deleteRequest(
  //     {required String endPoint,
  //     required Services service,
  //     bool tokenRequired = true,
  //     apiVersion = 'v1'}) async {
  //   try {
  //     ScreenOverlay.showLoaderOverlay(duration: 3);
  //     String token = tokenRequired ? GetStorage().read('token') : '';
  //     // ignore: prefer_typing_uninitialized_variables
  //     var requestResponse;
  //     await http
  //         .delete(
  //             Uri.parse(
  //                 getApi(apiService: service, version: apiVersion) + endPoint),
  //             headers: {'Authorization': 'Bearer $token'})
  //         .then((response) async => requestResponse = {
  //               'statusCode': response.statusCode,
  //               'response':
  //                   response.body.isNotEmpty ? jsonDecode(response.body) : {},
  //             })
  //         .catchError((onError) {
  //           Errors.displayException(onError);
  //           return requestResponse = {
  //             'statusCode': 500,
  //             'response': {'errors': 'Something wrong happened'}
  //           };
  //         });
  //     return requestResponse;
  //   } on Exception catch (exception) {
  //     Errors.displayException(exception);
  //   }
  // }

  // static Stream<Map<String, dynamic>> getRequestStream(
  //     {required String endPoint,
  //     required Services service,
  //     bool tokenRequired = true,
  //     apiVersion = 'v1'}) {
  //   final StreamController<Map<String, dynamic>> _controller =
  //       StreamController<Map<String, dynamic>>();
  //   String token = tokenRequired ? GetStorage().read('token') : '';

  //   _getData(endPoint, token, service, apiVersion)
  //       .then((data) => _controller.add(data))
  //       .catchError((error) => _controller.addError(error))
  //       .whenComplete(() => _controller.close());

  //   return _controller.stream;
  // }

  // static Future<Map<String, dynamic>> _getData(String endPoint, String token,
  //     Services service, String apiVersion) async {
  //   try {
  //     var requestResponse;
  //     await http
  //         .get(
  //             Uri.parse(
  //                 getApi(apiService: service, version: apiVersion) + endPoint),
  //             headers: {'Authorization': 'Bearer $token'})
  //         .then((response) async => requestResponse = {
  //               'statusCode': response.statusCode,
  //               'response':
  //                   response.body.isNotEmpty ? jsonDecode(response.body) : {},
  //             })
  //         .catchError((onError) => requestResponse = {
  //               'statusCode': 500,
  //               'response': {'errors': 'Something wrong happened'}
  //             });
  //     return requestResponse;
  //   } on Exception catch (exception) {
  //     Errors.displayException(exception);
  //     return {
  //       'statusCode': 500,
  //       'response': {'errors': 'Something wrong happened'}
  //     };
  //   }
  // }
}
