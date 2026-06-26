// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get chooseTool => 'ツールを選択';

  @override
  String get comingSoon => '近日公開';

  @override
  String get open => '開く';

  @override
  String get language => '言語';

  @override
  String get openSource => 'オープンソース';

  @override
  String get viewSource => 'GitHub のソース';

  @override
  String madeBy(String author) {
    return '作者: $author';
  }

  @override
  String get suiteSubtitle => 'オープンソースの写真ツール';

  @override
  String get toolPrintLayoutTitle => '印刷レイアウト';

  @override
  String get toolPrintLayoutDesc => '実寸の用紙に写真を並べて正確に印刷します。';

  @override
  String get toolSocialCollageTitle => 'SNS用コラージュ';

  @override
  String get toolSocialCollageDesc => 'SNSのサイズに合わせてコラージュを作成します。';

  @override
  String get toolCardsTitle => 'カード・招待状';

  @override
  String get toolCardsDesc => '印刷用のカードや招待状をデザインします。';

  @override
  String get toolCalendarTitle => 'フォトカレンダー';

  @override
  String get toolCalendarDesc => '写真から印刷用のカレンダーを作成します。';

  @override
  String get toolPhotobookTitle => 'フォトブック';

  @override
  String get toolPhotobookDesc => '印刷や注文用のアルバムを作成します。';

  @override
  String get toolLabelsTitle => 'ラベル・ステッカー';

  @override
  String get toolLabelsDesc => 'ラベル用紙を画像やテキストで埋めます。';

  @override
  String get allTools => 'すべてのツール';

  @override
  String get paper => '用紙';

  @override
  String get grid => 'グリッド';

  @override
  String get orientationPortrait => '縦';

  @override
  String get orientationLandscape => '横';

  @override
  String get export => '書き出し';

  @override
  String get exportAs => '形式を選んで書き出し…';

  @override
  String get formatPdf => 'PDF ドキュメント';

  @override
  String get formatPng => 'PNG 画像 · 300 DPI';

  @override
  String get formatJpeg => 'JPEG 画像 · 300 DPI';

  @override
  String importPhoto(int number) {
    return '写真 $number を読み込む';
  }

  @override
  String get clickToChoose => 'クリックして選択';

  @override
  String get swapPhoto => '写真を変更';

  @override
  String get resetFraming => 'フレーミングをリセット';

  @override
  String get printHint =>
      '100% の倍率で印刷し、「ページに合わせる」をオフにして、プリンターが対応していれば余白なしで印刷してください。';

  @override
  String savedTo(String format, String path) {
    return '$format を $path に保存しました';
  }

  @override
  String exportFailed(String format, String error) {
    return '$format を書き出せませんでした: $error';
  }

  @override
  String importFailed(String error) {
    return '画像を読み込めませんでした: $error';
  }
}
