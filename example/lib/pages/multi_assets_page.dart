// Copyright 2019 The FlutterCandies author. All rights reserved.
// Use of this source code is governed by an Apache license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../constants/page_mixin.dart';
import '../constants/picker_method.dart';

class MultiAssetsPage extends StatefulWidget {
  const MultiAssetsPage({super.key});

  @override
  State<MultiAssetsPage> createState() => _MultiAssetsPageState();
}

class _MultiAssetsPageState extends State<MultiAssetsPage>
    with AutomaticKeepAliveClientMixin, ExamplePageMixin {
  @override
  int get maxAssetsCount => 9;



  Function? onPress;

  /// Check each method's source code for more details.
  @override
  List<PickMethod> get pickMethods {
    return <PickMethod>[
      PickMethod.common(maxAssetsCount, onPress),
      PickMethod.image(maxAssetsCount),
      PickMethod.video(maxAssetsCount),
      PickMethod.audio(maxAssetsCount),
      PickMethod.camera(
        maxAssetsCount: maxAssetsCount,
        handleResult: (BuildContext context, AssetEntity result) =>
            Navigator.of(context).pop(<AssetEntity>[...assets, result]),
      ),
      PickMethod.cameraAndStay(maxAssetsCount: maxAssetsCount),
      PickMethod.changeLanguages(maxAssetsCount),
      PickMethod.threeItemsGrid(maxAssetsCount),
      PickMethod.prependItem(maxAssetsCount),
      PickMethod(
        icon: '🎭',
        name: 'WeChat Moment',
        description: 'Pick assets like the WeChat Moment pattern.',
        method: (BuildContext context, List<AssetEntity> assets) {
          return AssetPicker.pickAssets(
            context,
            pickerConfig: AssetPickerConfig(
              maxAssets: maxAssetsCount,
              specialPickerType: SpecialPickerType.wechatMoment,
              onPress: onPress,
            ),
          );
        },
      ),
      PickMethod.noPreview(maxAssetsCount),
      PickMethod.customizableTheme(maxAssetsCount),
      PickMethod.customFilterOptions(maxAssetsCount),
      PickMethod.preventGIFPicked(maxAssetsCount),
      PickMethod.keepScrollOffset(
        delegate: () => keepScrollDelegate!,
        onPermission: (PermissionState state) {
          keepScrollDelegate ??= DefaultAssetPickerBuilderDelegate(
            provider: keepScrollProvider,
            initialPermission: state,
            keepScrollOffset: true,
          );
        },
        onLongPress: () {
          keepScrollProvider.dispose();
          keepScrollProvider = DefaultAssetPickerProvider();
          keepScrollDelegate?.dispose();
          keepScrollDelegate = null;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Resources have been released')),
          );
        },
      ),
      PickMethod(
        icon: '🎚',
        name: 'Custom image preview thumb size',
        description: 'You can reduce the thumb size to get faster load speed.',
        method: (BuildContext context, List<AssetEntity> assets) {
          return AssetPicker.pickAssets(
            context,
            pickerConfig: AssetPickerConfig(
              maxAssets: maxAssetsCount,
              selectedAssets: assets,
              requestType: RequestType.image,
              gridThumbnailSize: const ThumbnailSize.square(80),
              previewThumbnailSize: const ThumbnailSize.square(150),
            ),
          );
        },
      ),
    ];
  }

  @override
  bool get wantKeepAlive => true;
}
