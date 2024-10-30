import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ethiosolar_app/app/data/services/api_response.dart';
import 'package:ethiosolar_app/app/core/error/error_codes.dart';
import 'package:ethiosolar_app/app/core/utils/constants/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../../core/utils/store/user_session.dart';
import 'api_constant.dart';

class ApiClient {
  Dio dio = Dio();
  String userId = "", authToken = "";
  Map<String, dynamic> headers = {"Content-Type": "application/json"};

  Logger logger = Logger(printer: PrettyPrinter());
  String? accessToken;
  static final ApiClient instance = ApiClient._internal();

  ApiClient._internal() {
    // createDioClient();
    setUpClient();
  }
  Dio createDioClient() {
    Dio dio = Dio(BaseOptions(baseUrl: ApiConstant.apiURL));
    dio.interceptors.addAll([
      LogInterceptor(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ),
      InterceptorsWrapper(onRequest: (options, handler) async {
        // final accessToken =
        // await _secureStorage.readSecureData(key: StorageKeys.accessToken);
        // options.headers['Authorization'] = 'Bearer $accessToken';
        return handler.next(options);
      }, onError: (
        DioException e,
        ErrorInterceptorHandler handler,
      ) {
        debugPrint(
            'error at dio ${e.error} message ${e.message} response ${e.response}');
        if (kDebugMode) {
          logger.e("Error : ${e.error}");
        }
        handler.next(e);
      })
    ]);

    return dio;
  }

  setUpClient() {
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {

    var interceptor = InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      if (kDebugMode) {
        logger.i("Request : URL : ${options.uri.toString()} "
            "DATA : ${options.data} "
            "HEADERS : ${options.headers.toString()}");
      }
      handler.next(options);
    }, onResponse: (
      Response response,
      ResponseInterceptorHandler handler,
    ) {
      if (kDebugMode) {
        logger.i("Response : ${response.data}");
      }
      handler.next(response);
    }, onError: (
      DioException e,
      ErrorInterceptorHandler handler,
    ) {
      debugPrint(
          'error at dio ${e.error} message ${e.message} response ${e.response}');
      if (kDebugMode) {
        logger.e("Error : ${e.error}");
      }
      handler.next(e);
    });

    dio.interceptors.add(interceptor);
  }

  checkIsLogin() async {
    // var isContain = await MyPreference.containsKey(ApiConstant.LOGIN_DATA);
    // if (isContain) {
    //   authToken = await getAccessToken();
    // } else {
    //   return "";
    // }
  }

  Future<ApiResponse?> call({
    String url = ApiConstant.apiURL,
    String endPoint = "",
    Map<String, dynamic>? params,
    ApiMethod method = ApiMethod.GET,
    FormData? fileUploadData,
    Map<String, dynamic>? mHeader,
    formUrlEncoded = false,
    String? token,
    bool useToken = true,
  }) async {
    try {
      // await Future.delayed(const Duration(milliseconds: 250));
      url = url + endPoint;
      await checkIsLogin();
      if (authToken != "") {
        headers = {
          ApiConstant.accessToken: authToken,
        };
      }

      try {
        if (mHeader != null) {
          headers.addAll(mHeader);
        }
        if (useToken) {
          headers.addAll(
            {"Authorization": "Bearer ${await UserSession.getUserToken()}"},
          );
        }
      } catch (e) {
        // Do nothing
      }

      Response response;
      switch (method) {
        case ApiMethod.GET:
          response = await dio.get(url,
              queryParameters: params, options: Options(headers: headers));
          break;
        case ApiMethod.POST:
          response = await dio.post(url,
              data: params,
              options: Options(
                headers: headers,
              ));
          break;
        case ApiMethod.MULTIPART:
          response = await dio.post(url,
              data: fileUploadData, options: Options(headers: mHeader));
          break;
        case ApiMethod.DELETE:
          response = await dio.delete(url,
              queryParameters: params, options: Options(headers: headers));
          break;
        case ApiMethod.PUT:
          response = await dio.put(url,
              data: params, options: Options(headers: headers));
          break;
        default:
          return ApiResponse.error(
              errorMessage: "You have set wrong http method",
              statusCode: ErrorCode.REQUEST_CANCELLED);
      }
      return ApiResponse.success(response.data);
      // ignore: unused_catch_clause
    } on SocketException catch (e) {
      return ApiResponse.error(
          statusCode: ErrorCode.NO_INTERNET_CONNECTION,
          errorMessage: MyStrings.noInternetConnection);
    } on FormatException {
      return ApiResponse.error(
          statusCode: ErrorCode.SERVER_DOWN,
          errorMessage: MyStrings.somethingWentWrong);
    } on DioException catch (e) {
      int statusCode;
      String errMsg;
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        statusCode = ErrorCode.CONNECTION_TIMEOUT;
        errMsg = MyStrings.somethingWentWrong;
      } else if (e.type == DioExceptionType.unknown) {
        statusCode = ErrorCode.NO_INTERNET_CONNECTION;
        errMsg = MyStrings.noInternetConnection;
      } else if (e.type == DioExceptionType.cancel) {
        statusCode = ErrorCode.REQUEST_CANCELLED;
        errMsg = MyStrings.somethingWentWrong;
      } else if (e.response?.statusCode == ErrorCode.NOT_AUTHORIZED) {
        // await MyPreference.clear();
        // MyNavigator.pushReplacedNamed(Routes.strLoginRoute);
        statusCode = ErrorCode.NOT_AUTHORIZED;
        errMsg = e.response.toString();

        // errMsg = MyStrings.somethingWentWrong;
      } else if (e.response?.statusCode == ErrorCode.BAD_REQ) {
        // await MyPreference.clear();
        // MyNavigator.pushReplacedNamed(Routes.strLoginRoute);
        statusCode = ErrorCode.BAD_REQ;
        errMsg = e.response.toString();

        // errMsg = MyStrings.somethingWentWrong;
      } else if (e.response?.statusCode == ErrorCode.SESSION_EXPIRED) {
        statusCode = ErrorCode.SESSION_EXPIRED;
        errMsg = MyStrings.somethingWentWrong;
      } else {
        statusCode = ErrorCode.SERVER_DOWN;
        errMsg = e.response.toString();

        // errMsg = MyStrings.serverDown;
      }
      return ApiResponse.error(statusCode: statusCode, errorMessage: errMsg);
    }
  }

  getAccessToken() async {
    try {
      // return await MyPreference.getAccessToken();
    } catch (e) {
      debugPrint("ERROR :: AccessToken :: $e");
    }
  }
}

// ignore: constant_identifier_names
enum ApiMethod { GET, POST, MULTIPART, DELETE, PUT }
