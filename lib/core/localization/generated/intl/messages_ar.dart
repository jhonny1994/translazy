// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ar';

  static String m0(code, message) =>
      "خطأ في واجهة البرمجة: ${code} - ${message}";

  static String m1(seconds) =>
      "عدد كبير من الطلبات. يرجى الانتظار ${seconds} ثانية";

  static String m2(maxLength) =>
      "يتجاوز النص الحد الأقصى البالغ ${maxLength} حرف";

  static String m3(seconds) =>
      "انتهت مهلة الطلب بعد ${seconds} ثانية. يرجى المحاولة مرة أخرى";

  static String m4(message) => "خطأ غير متوقع: ${message}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "apiError": m0,
        "appName": MessageLookupByLibrary.simpleMessage("Translazy"),
        "clear": MessageLookupByLibrary.simpleMessage("مسح"),
        "clearHistory": MessageLookupByLibrary.simpleMessage("مسح السجل"),
        "clearSourceText": MessageLookupByLibrary.simpleMessage("مسح النص"),
        "copyTranslation": MessageLookupByLibrary.simpleMessage("نسخ الترجمة"),
        "emptyTextError":
            MessageLookupByLibrary.simpleMessage("الرجاء إدخال نص للترجمة"),
        "enterTextToTranslate":
            MessageLookupByLibrary.simpleMessage("أدخل النص المراد ترجمته..."),
        "history": MessageLookupByLibrary.simpleMessage("السجل"),
        "maxListeningDurationReached": MessageLookupByLibrary.simpleMessage(
            "تم الوصول للحد الأقصى لمدة الاستماع. يرجى المحاولة مرة أخرى"),
        "microphonePermissionDenied": MessageLookupByLibrary.simpleMessage(
            "يلزم السماح باستخدام الميكروفون للتعرف على الصوت"),
        "networkError": MessageLookupByLibrary.simpleMessage(
            "خطأ في الاتصال. يرجى التحقق من اتصالك بالإنترنت"),
        "noTranslationsYet":
            MessageLookupByLibrary.simpleMessage("لا توجد ترجمات بعد"),
        "rateLimitError": m1,
        "selectLanguage": MessageLookupByLibrary.simpleMessage("اختر اللغة"),
        "startListening": MessageLookupByLibrary.simpleMessage("بدء الاستماع"),
        "stopListening": MessageLookupByLibrary.simpleMessage("إيقاف الاستماع"),
        "sttNotAvailable": MessageLookupByLibrary.simpleMessage(
            "خاصية التعرف على الصوت غير متوفرة. يرجى التحقق من إعدادات الميكروفون."),
        "switchLanguages": MessageLookupByLibrary.simpleMessage("تبديل اللغات"),
        "textCopiedToClipboard":
            MessageLookupByLibrary.simpleMessage("تم نسخ النص إلى الحافظة!"),
        "textTooLongError": m2,
        "timeoutError": m3,
        "translate": MessageLookupByLibrary.simpleMessage("ترجم"),
        "translation": MessageLookupByLibrary.simpleMessage("الترجمة"),
        "translationWillAppearHere":
            MessageLookupByLibrary.simpleMessage("ستظهر الترجمة هنا..."),
        "unexpectedError": m4
      };
}
