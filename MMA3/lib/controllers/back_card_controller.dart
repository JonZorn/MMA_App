import 'package:dio/dio.dart';
import 'package:flutter_app/utils/network_client.dart';
import 'package:get/get.dart';

class BackCardController extends GetxController {
  RxBool loading = false.obs;
  RxBool isloading = false.obs;

  smartMixmoveOn(
      {int? cardId,
      String? practiceType,
      Function? onSuccess,
      Function? onFailure,
      var error,
      var images,
      var content,
      var video,
      var id,
      var title,
      var smartmixcategoryname}) async {
    try {
      isloading.value = true;
      final response = await NetworkClient.post(
        '/calculate-day-interval',
        {"card_id": cardId, "category": practiceType, "quality": 5},
      );
      print(response);
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          images = response.data['data']['image'];
          title = response.data['data']['title'];
          id = response.data['data']['id'];
          video = response.data['data']['video'];
          content = response.data['data']['content'];
          smartmixcategoryname =
              response.data['data']['category_data']['category_name'];

          if (onSuccess != null) {
            onSuccess(title, id, video, content, images, smartmixcategoryname);
          }
        } else {
          onFailure!(error);

          // SnackbarHandler.errorToast(
          //     'Card Move on', 'Further No Cards available');
        }
      }
    } on DioError catch (e) {
      NetworkClient.errorHandler(e);
    } finally {
      isloading.value = false;
    }
  }

  categorymoveOn({
    int? cardId,
    String? practiceType,
    Function? onSuccess,
    Function? onFailure,
    var error,
    var images,
    var content,
    var video,
    var id,
    var title,
  }) async {
    try {
      isloading.value = true;
      final response = await NetworkClient.post(
        '/category-day-interval',
        {"card_id": cardId, "category": practiceType, "quality": 5},
      );

      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          id = response.data['data']['id'];
          images = response.data['data']['image'];
          title = response.data['data']['title'];
          video = response.data['data']['video'];
          content = response.data['data']['content'];
          if (onSuccess != null) {
            onSuccess(title, id, video, content, images);
          }
        } else {
          onFailure!(error);
          // SnackbarHandler.errorToast(
          //     'Card Move on', 'Further No Cards available');
        }
      }
    } on DioError catch (e) {
      NetworkClient.errorHandler(e);
    } finally {
      isloading.value = false;
    }
  }

  smartmixwork(
      {int? cardId,
      int? practiceTypes,
      Function? onSuccess,
      Function? onFailure,
      var error,
      var images,
      var content,
      var video,
      var id,
      var title,
      var smartmixcategoryname}) async {
    try {
      loading.value = true;
      final response = await NetworkClient.post(
        '/calculate-day-interval',
        {"card_id": cardId, "category": practiceTypes, "quality": 2},
      );
      print(response);
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          images = response.data['data']['image'];
          title = response.data['data']['title'];
          id = response.data['data']['id'];
          video = response.data['data']['video'];
          content = response.data['data']['content'];
          smartmixcategoryname =
              response.data['data']['category_data']['category_name'];
          if (onSuccess != null) {
            onSuccess(title, id, video, content, images, smartmixcategoryname);
          }
        } else {
          onFailure!(error);
          // SnackbarHandler.errorToast(
          //     'Card Need Work', 'Further No Cards available');
        }
      }
    } on DioError catch (e) {
      NetworkClient.errorHandler(e);
    } finally {
      loading.value = false;
    }
  }

  categorywork({
    int? cardId,
    int? practiceTypes,
    Function? onSuccess,
    Function? onFailure,
    var error,
    var images,
    var content,
    var video,
    var id,
    var title,
  }) async {
    try {
      loading.value = true;
      final response = await NetworkClient.post(
        '/category-day-interval',
        {"card_id": cardId, "category": practiceTypes, "quality": 2},
      );
      print(response);
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          images = response.data['data']['image'];
          title = response.data['data']['title'];
          id = response.data['data']['id'];
          video = response.data['data']['video'];
          content = response.data['data']['content'];
          if (onSuccess != null) {
            onSuccess(title, id, video, content, images);
          }
        } else {
          onFailure!(error);
          // SnackbarHandler.errorToast(
          //     'Card Need Work', 'Further No Cards available');
        }
      }
    } on DioError catch (e) {
      NetworkClient.errorHandler(e);
    } finally {
      loading.value = false;
    }
  }

  restProgress({required Function onSuccess, type}) async {
    try {
      loading.value = true;
      final response =
          await NetworkClient.post('/progress/reset?type=$type!', {});
      if (response.statusCode == 200) {
        if (onSuccess != null) {
          onSuccess();
          print(response.realUri);
        }
      }
    } on DioError catch (e) {
      NetworkClient.errorHandler(e);
    } finally {
      loading.value = false;
    }
  }
}
