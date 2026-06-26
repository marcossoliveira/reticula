// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get chooseTool => 'Escolha uma ferramenta';

  @override
  String get comingSoon => 'Em breve';

  @override
  String get open => 'Abrir';

  @override
  String get language => 'Idioma';

  @override
  String get openSource => 'Código aberto';

  @override
  String get viewSource => 'Código no GitHub';

  @override
  String madeBy(String author) {
    return 'Feito por $author';
  }

  @override
  String get suiteSubtitle => 'Ferramentas de foto open source';

  @override
  String get toolPrintLayoutTitle => 'Layout de Impressão';

  @override
  String get toolPrintLayoutDesc =>
      'Organize fotos em folhas reais para impressão precisa.';

  @override
  String get toolSocialCollageTitle => 'Colagem para Redes Sociais';

  @override
  String get toolSocialCollageDesc =>
      'Monte colagens no tamanho das redes sociais.';

  @override
  String get toolCardsTitle => 'Cartões e Convites';

  @override
  String get toolCardsDesc => 'Crie cartões e convites para imprimir.';

  @override
  String get toolCalendarTitle => 'Calendário de Fotos';

  @override
  String get toolCalendarDesc =>
      'Transforme suas fotos em calendários para imprimir.';

  @override
  String get toolPhotobookTitle => 'Álbum de Fotos';

  @override
  String get toolPhotobookDesc => 'Monte um álbum para imprimir ou encomendar.';

  @override
  String get toolLabelsTitle => 'Etiquetas e Adesivos';

  @override
  String get toolLabelsDesc =>
      'Preencha folhas de etiquetas com imagens ou texto.';

  @override
  String get allTools => 'Todas as ferramentas';

  @override
  String get paper => 'Papel';

  @override
  String get grid => 'Grade';

  @override
  String get orientationPortrait => 'Retrato';

  @override
  String get orientationLandscape => 'Paisagem';

  @override
  String get export => 'Exportar';

  @override
  String get exportAs => 'Exportar como…';

  @override
  String get formatPdf => 'Documento PDF';

  @override
  String get formatPng => 'Imagem PNG · 300 DPI';

  @override
  String get formatJpeg => 'Imagem JPEG · 300 DPI';

  @override
  String importPhoto(int number) {
    return 'Importar Foto $number';
  }

  @override
  String get clickToChoose => 'Clique para escolher';

  @override
  String get swapPhoto => 'Trocar foto';

  @override
  String get resetFraming => 'Redefinir enquadramento';

  @override
  String get printHint =>
      'Imprima em escala 100%, sem “ajustar à página” e com impressão sem borda se a impressora suportar.';

  @override
  String savedTo(String format, String path) {
    return '$format salvo em $path';
  }

  @override
  String exportFailed(String format, String error) {
    return 'Não foi possível exportar $format: $error';
  }

  @override
  String importFailed(String error) {
    return 'Não foi possível importar a imagem: $error';
  }
}
