// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';

// class ViewImages extends StatelessWidget {
//   final List<String?> photos;
//   final int index;
//   const ViewImages({super.key, required this.photos, required this.index});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
//       body: PhotoViewGallery.builder(
//         itemCount: photos.length,
//         builder: (context, index) => PhotoViewGalleryPageOptions.customChild(
//             child: CachedNetworkImage(
//               imageUrl: photos[index]!,
//               placeholder: (context, url) => Container(
//                 decoration: const BoxDecoration(color: Colors.grey),
//               ),
//             ),
//             minScale: PhotoViewComputedScale.covered,
//             heroAttributes: PhotoViewHeroAttributes(tag: photos[index]!)),
//         pageController: PageController(initialPage: index),
//         enableRotation: true,
//       ),
//     );
//   }
// }
