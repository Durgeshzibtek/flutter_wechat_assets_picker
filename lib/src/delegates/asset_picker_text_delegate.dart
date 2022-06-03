// Copyright 2019 The FlutterCandies author. All rights reserved.
// Use of this source code is governed by an Apache license that can be found
// in the LICENSE file.

import 'dart:io' show Platform;

import 'package:flutter/rendering.dart';
import 'package:photo_manager/photo_manager.dart' show AssetType;

/// All text delegates.
const List<AssetPickerTextDelegate> assetPickerTextDelegates =
    <AssetPickerTextDelegate>[
  AssetPickerTextDelegate(),
  EnglishAssetPickerTextDelegate(),
];

/// Obtain the text delegate from the given locale.
AssetPickerTextDelegate assetPickerTextDelegateFromLocale(Locale? locale) {
  if (locale == null) {
    return const AssetPickerTextDelegate();
  }
  final String languageCode = locale.languageCode.toLowerCase();
  for (final AssetPickerTextDelegate delegate in assetPickerTextDelegates) {
    if (delegate.languageCode == languageCode) {
      return delegate;
    }
  }
  return const AssetPickerTextDelegate();
}

/// Text delegate that controls text in widgets.
/// 控制部件中的文字实现
class AssetPickerTextDelegate {
  const AssetPickerTextDelegate();

  String get languageCode => 'en';

  /// Confirm string for the confirm button.
  /// 确认按钮的字段
  String get confirm => 'Next';

  /// Cancel string for back button.
  /// 返回按钮的字段
  String get cancel => 'Cancel';

  /// Edit string for edit button.
  /// 编辑按钮的字段
  String get edit => 'Edit';

  /// GIF indicator string.
  /// GIF指示的字段
  String get gifIndicator => 'GIF';

  /// Load failed string for item.
  /// 资源加载失败时的字段
  String get loadFailed => 'load Failed';

  /// Original string for original selection.
  /// 选择是否原图的字段
  String get original => 'Original';

  /// Preview string for preview button.
  /// 预览按钮的字段
  String get preview => 'Preview';

  /// Select string for select button.
  /// 选择按钮的字段
  String get select => 'Select';

  /// Empty list string for empty asset list.
  /// 资源列表为空时的占位字段
  String get emptyList => 'EmptyList';

  /// Un-supported asset type string for assets that
  /// belongs to [AssetType.other].
  /// 未支持的资源类型的字段
  String get unSupportedAssetType => '尚未支持的资源类型';

  /// "Unable to access all assets in album".
  String get unableToAccessAll => '无法访问所有资源';

  String get viewingLimitedAssetsTip => '应用只能访问部分资源和相册';

  String get changeAccessibleLimitedAssets => '点击设置可访问的资源';

  String get accessAllTip => 'App can only access some assets on the device. '
      'Go to system settings and allow app to access all assets on the device.';

  String get goToSystemSettings => '前往系统设置';

  /// "Continue accessing some assets".
  String get accessLimitedAssets => 'Continue with limited access';

  String get accessiblePathName => '可访问的资源';

  /// This is used in video asset item in the picker, in order
  /// to display the duration of the video or audio type of asset.
  /// 该字段用在选择器视频或音频部件上，用于显示视频或音频资源的时长。
  String durationIndicatorBuilder(Duration duration) {
    const String separator = ':';
    final String minute = duration.inMinutes.toString().padLeft(2, '0');
    final String second =
        ((duration - Duration(minutes: duration.inMinutes)).inSeconds)
            .toString()
            .padLeft(2, '0');
    return '$minute$separator$second';
  }

  /// Semantics fields.
  ///
  /// Fields below are only for semantics usage. For customizable these fields,
  /// head over to [EnglishAssetPickerTextDelegate] for fields understanding.
  String get sTypeAudioLabel => '音频';

  String get sTypeImageLabel => '图片';

  String get sTypeVideoLabel => '视频';

  String get sTypeOtherLabel => '其他资源';

  String semanticTypeLabel(AssetType type) {
    switch (type) {
      case AssetType.audio:
        return sTypeAudioLabel;
      case AssetType.image:
        return sTypeImageLabel;
      case AssetType.video:
        return sTypeVideoLabel;
      case AssetType.other:
        return sTypeOtherLabel;
    }
  }

  String get sActionPlayHint => '播放';

  String get sActionPreviewHint => '预览';

  String get sActionSelectHint => '选中';

  String get sActionSwitchPathLabel => '切换路径';

  String get sActionUseCameraHint => '使用相机';

  String get sNameDurationLabel => '时长';

  String get sUnitAssetCountLabel => '数量';

  /// Fallback delegate for semantics determined by platform.
  ///
  /// The purpose of this field is to provide a fallback delegate references
  /// when a language does not supported by Talkback or VoiceOver. Set this to
  /// another text delegate makes screen readers read accordingly.
  ///
  /// See also:
  ///  * Talkback: https://support.google.com/accessibility/android/answer/11101402)
  ///  * VoiceOver: https://support.apple.com/en-us/HT206175
  AssetPickerTextDelegate get semanticsTextDelegate => this;
}

/// [AssetPickerTextDelegate] implements with English.
/// English Localization
class EnglishAssetPickerTextDelegate extends AssetPickerTextDelegate {
  const EnglishAssetPickerTextDelegate();

  @override
  String get languageCode => 'en';

  @override
  String get confirm => 'Next';

  @override
  String get cancel => 'Cancel';

  @override
  String get edit => 'Edit';

  @override
  String get gifIndicator => 'GIF';

  @override
  String get loadFailed => 'Load failed';

  @override
  String get original => 'Origin';

  @override
  String get preview => 'Preview';

  @override
  String get select => 'Select';

  @override
  String get emptyList => 'Empty list';

  @override
  String get unSupportedAssetType => 'Unsupported HEIC asset type.';

  @override
  String get unableToAccessAll => 'Unable to access all assets on the device';

  @override
  String get viewingLimitedAssetsTip =>
      'Only view assets and albums accessible to app.';

  @override
  String get changeAccessibleLimitedAssets =>
      'Click to update accessible assets';

  @override
  String get accessAllTip => 'App can only access some assets on the device. '
      'Go to system settings and allow app to access all assets on the device.';

  @override
  String get goToSystemSettings => 'Go to system settings';

  @override
  String get accessLimitedAssets => 'Continue with limited access';

  @override
  String get accessiblePathName => 'Accessible assets';

  @override
  String get sTypeAudioLabel => 'Audio';

  @override
  String get sTypeImageLabel => 'Image';

  @override
  String get sTypeVideoLabel => 'Video';

  @override
  String get sTypeOtherLabel => 'Other asset';

  @override
  String get sActionPlayHint => 'play';

  @override
  String get sActionPreviewHint => 'preview';

  @override
  String get sActionSelectHint => 'select';

  @override
  String get sActionSwitchPathLabel => 'switch path';

  @override
  String get sActionUseCameraHint => 'use camera';

  @override
  String get sNameDurationLabel => 'duration';

  @override
  String get sUnitAssetCountLabel => 'count';
}

