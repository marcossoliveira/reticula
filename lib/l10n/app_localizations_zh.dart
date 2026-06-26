// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get chooseTool => '选择一个工具';

  @override
  String get comingSoon => '即将推出';

  @override
  String get open => '打开';

  @override
  String get language => '语言';

  @override
  String get openSource => '开源';

  @override
  String get viewSource => 'GitHub 源代码';

  @override
  String madeBy(String author) {
    return '由 $author 制作';
  }

  @override
  String get suiteSubtitle => '开源照片工具';

  @override
  String get toolPrintLayoutTitle => '打印排版';

  @override
  String get toolPrintLayoutDesc => '在真实尺寸的纸张上排布照片，实现精确打印。';

  @override
  String get toolSocialCollageTitle => '社交媒体拼图';

  @override
  String get toolSocialCollageDesc => '按社交网络尺寸制作拼图。';

  @override
  String get toolCardsTitle => '卡片与请柬';

  @override
  String get toolCardsDesc => '设计可打印的卡片和请柬。';

  @override
  String get toolCalendarTitle => '照片日历';

  @override
  String get toolCalendarDesc => '用你的照片制作可打印的日历。';

  @override
  String get toolPhotobookTitle => '相册书';

  @override
  String get toolPhotobookDesc => '排版可打印或下单的相册。';

  @override
  String get toolLabelsTitle => '标签与贴纸';

  @override
  String get toolLabelsDesc => '用图片或文字填充标签纸。';

  @override
  String get allTools => '所有工具';

  @override
  String get paper => '纸张';

  @override
  String get grid => '网格';

  @override
  String get orientationPortrait => '纵向';

  @override
  String get orientationLandscape => '横向';

  @override
  String get export => '导出';

  @override
  String get exportAs => '导出为…';

  @override
  String get formatPdf => 'PDF 文档';

  @override
  String get formatPng => 'PNG 图片 · 300 DPI';

  @override
  String get formatJpeg => 'JPEG 图片 · 300 DPI';

  @override
  String importPhoto(int number) {
    return '导入照片 $number';
  }

  @override
  String get clickToChoose => '点击选择';

  @override
  String get swapPhoto => '更换照片';

  @override
  String get resetFraming => '重置取景';

  @override
  String get printHint => '请以 100% 比例打印，关闭“适应页面”，如果打印机支持请使用无边距打印。';

  @override
  String savedTo(String format, String path) {
    return '$format 已保存到 $path';
  }

  @override
  String exportFailed(String format, String error) {
    return '无法导出 $format：$error';
  }

  @override
  String importFailed(String error) {
    return '无法导入图片：$error';
  }
}
