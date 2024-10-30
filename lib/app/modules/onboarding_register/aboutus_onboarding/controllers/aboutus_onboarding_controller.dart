// ignore_for_file: unnecessary_overrides

import 'package:ethiosolar_app/app/core/utils/utils.dart';
import 'package:ethiosolar_app/app/data/models/aboutUs/onboardingResponse_model.dart';
import 'package:ethiosolar_app/app/data/models/aboutUs/onboarding_model.dart';
import 'package:ethiosolar_app/app/data/services/api_client.dart';
import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:ethiosolar_app/app/data/services/api_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AboutusOnboardingController extends GetxController {
  //above the in appwebview package resources
  late final player = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final controllerVideo;
  PdfViewerController pdfController = PdfViewerController();

  RxInt currentIndex = 0.obs;
  final RxList<AboutUsOnboarding> onBoadingList =
      List<AboutUsOnboarding>.empty(growable: true).obs;

  RxBool isOnBoardingLLoading = false.obs;
  // ignore: non_constant_identifier_names

  String textValue =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing eliLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, wwwwwwwwwwwjwjwhjhhkjkjhkjhkhkjhkjhit";
  void closePlayer() {
    player.stop();
  }

  @override
  void onReady() async {
    await getOnBoardings();
    List<Media> playlist = onBoadingList
        .map((course) =>
            Media(Utils.concatenateGoogleDriveUrl(course.videoUrl ?? '')))
        .toList();
    debugPrint("playlist$playlist");
    debugPrint("playlistiindex${currentIndex.value}");
    debugPrint("uri ${playlist[currentIndex.value].uri}");

    // Create a Playlist from the list of Media objects
    // Playlist mediaPlaylist = Playlist(playlist);
    final playable = Playlist(
      playlist,
      // Declare the starting position.
      index: currentIndex.value,
    );
    // Open the playlist with the player
    player.open(playable);

    super.onReady();
  }

  void nextVideo() {
    if (currentIndex.value < onBoadingList.length - 1) {
      // Increment the current video index
      currentIndex.value++;

      // Open the next video
      player.open(Media(Utils.concatenateGoogleDriveUrl(
          onBoadingList[currentIndex.value].videoUrl ?? '')));
    }
  }

  void prevVideo() {
    if (currentIndex.value <= onBoadingList.length - 1) {
      // Increment the current video index
      currentIndex.value--;

      // Open the next video
      player.open(Media(Utils.concatenateGoogleDriveUrl(
          onBoadingList[currentIndex.value].videoUrl ?? '')));
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    player.dispose();

    super.onClose();
  }

  Future<void> getOnBoardings() async {
    try {
      isOnBoardingLLoading(true);

      ApiResponse? response = await ApiClient.instance.call(
        method: ApiMethod.GET,
        // params: trainingRequest,
        endPoint: ApiConstant.kgetAboutUsOnboarding,
      );
      if (response is BaseResponse) {
        AboutUsOnBoardingResponse onboaringResponseModel =
            AboutUsOnBoardingResponse(
          onboardingList: AboutUsOnboarding.fromJsonList(response.results),
        );
        onBoadingList.addAll(onboaringResponseModel.onboardingList ?? []);
      }
    } finally {
      isOnBoardingLLoading(false);
    }
  }
}
