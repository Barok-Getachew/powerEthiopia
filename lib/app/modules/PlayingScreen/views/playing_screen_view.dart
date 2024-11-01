import 'package:ethiosolar_app/app/core/exports/app_exports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controllers/playing_screen_controller.dart';

class PlayingScreenView extends StatefulWidget {
  const PlayingScreenView({
    super.key,
  });

  @override
  State<PlayingScreenView> createState() => _PlayingScreenViewState();
}

class _PlayingScreenViewState extends State<PlayingScreenView>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  final url = "https://youtu.be/YMx8Bbev6T4?si=rgCMT2737xlS9UG4";
  final controller = Get.put(PlayingScreenController());

  late YoutubePlayerController youtubePlayerController;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  void _initializePlayer() {
    final videoId = YoutubePlayer.convertUrlToId(url);
    if (videoId != null) {
      youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      )..addListener(listener);
      _videoMetaData = const YoutubeMetaData();
      ;
      if (kDebugMode) {
        print('Initialized with video ID: $videoId');
      }
    } else {
      if (kDebugMode) {
        print('Error: Invalid video URL or unable to extract video ID');
      }
    }
  }

  void listener() {
    if (_isPlayerReady &&
        mounted &&
        !youtubePlayerController.value.isFullScreen) {
      setState(() {
        _playerState = youtubePlayerController.value.playerState;
        _videoMetaData = youtubePlayerController.metadata;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    _initializePlayer();
  }

  @override
  void dispose() {
    tabController.dispose();
    youtubePlayerController.dispose();

    super.dispose();
  }

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    final param = Get.parameters['isOnlyPdf'] ?? false;
    debugPrint('indexisonlyPdf$param');
    bool isOnlyPdf = param == 'true';
    debugPrint('indexisonlyPdf$isOnlyPdf');

    return YoutubePlayerBuilder(
      builder: (ctx, player) => Obx(
        () => controller.isTrainingCategoryTrainingsLoading.isTrue
            ? const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Scaffold(
                appBar: PreferredSize(
                  preferredSize:
                      Size(MediaQuery.sizeOf(context).width, 130.adaptSize),
                  child: AppBar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    leading: Padding(
                      padding: EdgeInsets.only(
                          left: 20.adaptSize, top: 15.adaptSize),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    title: Column(
                      children: [
                        SizedBox(
                          height: 20.adaptSize,
                        ),
                      ],
                    ),
                    centerTitle: false,
                    flexibleSpace: Column(
                      children: [
                        SizedBox(
                          height: 70.adaptSize,
                        ),
                        Column(children: [
                          SizedBox(
                            height: 20.adaptSize,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 10),
                              decoration: ShapeDecoration(
                                color: Colors.grey.shade300,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(120),
                                ),
                              ),
                              child: TabBar(
                                controller: tabController,
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                labelColor: Colors.grey.shade50,
                                labelStyle: TextStyle(fontSize: 12),
                                isScrollable: true,
                                tabAlignment: TabAlignment.start,
                                indicatorWeight: 0.5,
                                unselectedLabelColor: //themeChange.getThem()
                                    // ? Colors.grey.shade50
                                    Colors.grey.shade900,
                                dividerColor: Colors.transparent,
                                indicatorSize: TabBarIndicatorSize.tab,
                                tabs: [
                                  Tab(
                                    text: 'Objectives',
                                  ),
                                  Tab(
                                    text: 'Outline',
                                  ),
                                  Tab(
                                    text: 'Course',
                                  ),
                                  Tab(
                                    text: 'Videos',
                                  ),
                                ],
                              ),
                            ),
                          )
                        ]),
                      ],
                    ),
                  ),
                ),
                body: SafeArea(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              '${controller.courseList.isNotEmpty ? controller.courseList[0].title : ''}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.grey.shade800),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'If a Container widget is taking up the full width of the screen even when you have specified a width.',
                              overflow: TextOverflow.visible,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: Colors.grey.shade500,
                                    letterSpacing: -0.17,
                                    fontSize: 10,
                                  ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Description',
                              overflow: TextOverflow.visible,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Colors.grey.shade800,
                                    letterSpacing: -0.17,
                                  ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'If a Container widget is taking up the full width of the screen even when you have specified a width, this could be due to several reasons related to its layout context. Here are a few solutions you can try to control the width',
                              overflow: TextOverflow.visible,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: Colors.grey.shade800,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.3)),
                              width: 130.adaptSize,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Center(
                                child: Text(
                                  "Objectives",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50.0),
                              child: ListView.builder(
                                itemCount: 5,
                                itemBuilder: (context, index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.bubble_chart),
                                      Text("Safety Practice")
                                    ],
                                  ),
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                      Expanded(
                          child: SfPdfViewer.network(
                        "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf",
                        key: _pdfViewerKey,
                      )), // Add actual content here
                      Expanded(
                          child: SfPdfViewer.network(
                        "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf",
                        key: _pdfViewerKey,
                      )),

                      Column(
                        children: [
                          player,
                          // SizedBox(height: 20),
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.symmetric(horizontal: 20.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text(
                          //         "Title",
                          //         style: Theme.of(context)
                          //             .textTheme
                          //             .titleMedium!
                          //             .copyWith(
                          //               letterSpacing: -0.17,
                          //             ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(height: 20),
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.symmetric(horizontal: 20.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text(
                          //         "Duration",
                          //         style: Theme.of(context)
                          //             .textTheme
                          //             .titleMedium!
                          //             .copyWith(
                          //               letterSpacing: -0.17,
                          //             ),
                          //       ),
                          //       Text(
                          //         youtubePlayerController.metadata.duration
                          //             .toString(),
                          //         style: Theme.of(context)
                          //             .textTheme
                          //             .titleMedium!
                          //             .copyWith(
                          //               letterSpacing: -0.17,
                          //             ),
                          //       ),
                          //     ],
                          //   ),
                          // )
                        ],
                      ) // Add actual content here
                    ],
                  ),
                ),
              ),
      ),
      player: YoutubePlayer(
        controller: youtubePlayerController,
        showVideoProgressIndicator: true,
        bottomActions: const [
          CurrentPosition(),
          ProgressBar(isExpanded: true),
          PlaybackSpeedButton(),
          FullScreenButton(),
        ],
      ),
    );
  }
}
