// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get chooseTool => 'Elige una herramienta';

  @override
  String get comingSoon => 'Próximamente';

  @override
  String get open => 'Abrir';

  @override
  String get language => 'Idioma';

  @override
  String get openSource => 'Código abierto';

  @override
  String get viewSource => 'Código en GitHub';

  @override
  String madeBy(String author) {
    return 'Hecho por $author';
  }

  @override
  String get suiteSubtitle => 'Herramientas de fotos de código abierto';

  @override
  String get toolPrintLayoutTitle => 'Diseño de Impresión';

  @override
  String get toolPrintLayoutDesc =>
      'Organiza fotos en hojas reales para imprimir con precisión.';

  @override
  String get toolSocialCollageTitle => 'Collage para Redes Sociales';

  @override
  String get toolSocialCollageDesc =>
      'Crea collages con el tamaño de las redes sociales.';

  @override
  String get toolCardsTitle => 'Tarjetas e Invitaciones';

  @override
  String get toolCardsDesc => 'Diseña tarjetas e invitaciones para imprimir.';

  @override
  String get toolCalendarTitle => 'Calendario de Fotos';

  @override
  String get toolCalendarDesc =>
      'Convierte tus fotos en calendarios para imprimir.';

  @override
  String get toolPhotobookTitle => 'Álbum de Fotos';

  @override
  String get toolPhotobookDesc => 'Crea un álbum para imprimir o encargar.';

  @override
  String get toolLabelsTitle => 'Etiquetas y Pegatinas';

  @override
  String get toolLabelsDesc =>
      'Rellena hojas de etiquetas con imágenes o texto.';

  @override
  String get allTools => 'Todas las herramientas';

  @override
  String get paper => 'Papel';

  @override
  String get grid => 'Cuadrícula';

  @override
  String get orientationPortrait => 'Vertical';

  @override
  String get orientationLandscape => 'Horizontal';

  @override
  String get export => 'Exportar';

  @override
  String get exportAs => 'Exportar como…';

  @override
  String get formatPdf => 'Documento PDF';

  @override
  String get formatPng => 'Imagen PNG · 300 DPI';

  @override
  String get formatJpeg => 'Imagen JPEG · 300 DPI';

  @override
  String importPhoto(int number) {
    return 'Importar Foto $number';
  }

  @override
  String get clickToChoose => 'Haz clic para elegir';

  @override
  String get swapPhoto => 'Cambiar foto';

  @override
  String get resetFraming => 'Restablecer encuadre';

  @override
  String get printHint =>
      'Imprime al 100% de escala, sin “ajustar a la página” y sin márgenes si tu impresora lo permite.';

  @override
  String savedTo(String format, String path) {
    return '$format guardado en $path';
  }

  @override
  String exportFailed(String format, String error) {
    return 'No se pudo exportar $format: $error';
  }

  @override
  String importFailed(String error) {
    return 'No se pudo importar la imagen: $error';
  }
}
