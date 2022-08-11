// Copyright 2019 The FlutterCandies author. All rights reserved.
// Use of this source code is governed by an Apache license that can be found
// in the LICENSE file.

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../internal/singleton.dart';
import '../../widget/scale_text.dart';

class AssetEntityGridItemBuilder extends StatefulWidget {
  const AssetEntityGridItemBuilder({
    super.key,
    required this.image,
    required this.failedItemBuilder,
  });

  final AssetEntityImageProvider image;
  final WidgetBuilder failedItemBuilder;

  @override
  AssetEntityGridItemWidgetState createState() => AssetEntityGridItemWidgetState();
}

class AssetEntityGridItemWidgetState extends State<AssetEntityGridItemBuilder> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _firstTimeShowPopupDialog(context);
    });
  }

  Widget? child;

  Widget get newChild {
    return ExtendedImage(
      image: widget.image,
      fit: BoxFit.cover,
      loadStateChanged: (ExtendedImageState state) {
        Widget loader = const SizedBox.shrink();
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            loader = const ColoredBox(color: Color(0x10ffffff));
            break;
          case LoadState.completed:
            loader = RepaintBoundary(child: state.completedWidget);
            break;
          case LoadState.failed:
            loader = widget.failedItemBuilder(context);
            break;
        }
        return loader;
      },
    );
  }

  /// Item widgets when the thumbnail data load failed.
  /// 资源缩略数据加载失败时使用的部件
  Widget failedItemBuilder(BuildContext context) {
    return Center(
      child: ScaleText(
        Singleton.textDelegate.loadFailed,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18.0),
        semanticsLabel: Singleton.textDelegate.semanticsTextDelegate.loadFailed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    child ??= newChild;
    return child!;
  }

  _firstTimeShowPopupDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
              insetPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              backgroundColor: Colors.transparent,
              content: Builder(
                builder: (BuildContext context) {
                  return Container(
                    padding: const EdgeInsets.only(top: 25, left: 35, right: 35),
                    height: 242,
                    width: 330,
                    child: Column(
                      children: [
                        const Text(
                          "Upload Your Photos",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "NimbusBold",
                            color: Color(0xffF0F2F2),
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 6,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Tap the Post button to upload and share.',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "NimbusLight",
                            color: Color(0xffF0F2F2),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: 158,
                          height: 33,
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).maybePop(),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0Xff0cb373),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(03)),
                            ),
                            child: const Text(
                              'Okay!',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16, color: Color(0xff000000), fontFamily: "NimbusBold", fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )),
        );
      },
    );
  }
}
