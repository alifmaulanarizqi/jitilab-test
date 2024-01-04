import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

T? cast<T>(value) => value is T ? value : null;

extension FileExt on File {
  String toBase64Image() {
    var bytes = readAsBytesSync();
    return "data:image/png;base64,${base64Encode(bytes)}";
  }
}

extension StringFile on String {
  String getFileExtension() {
    int dotIndex = lastIndexOf('.');
    return (dotIndex != -1 && dotIndex < length - 1)
        ? substring(dotIndex + 1)
        : '';
  }

  String getFileNameWithoutExtension() {
    int lastSlashIndex = lastIndexOf('/');
    int lastDotIndex = lastIndexOf('.');

    if (lastDotIndex > lastSlashIndex) {
      String fileName = substring(lastSlashIndex + 1, lastDotIndex);
      return fileName;
    } else {
      return substring(lastSlashIndex + 1);
    }
  }
}

extension StringNullExt on String? {
  String getFirst3InsideParenthes() {
    RegExp regex = RegExp(r'\((.*?)\)');
    String result = regex.firstMatch(this ?? '')?.group(1) ?? '';
    if (result.length >= 3) {
      return result.substring(0, 3);
    } else {
      return result;
    }
  }

  bool isValidEmail() {
    if (this == null || (this ?? '').isEmpty) return false;

    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(this!);
  }

  bool isValidUrl() {
    return Uri.parse(this!).isAbsolute;
  }
}

extension StringExt on String {
  String? nullIfEmpty() {
    if (isEmpty) return null;

    return this;
  }

  String convertToSentenceCase() {
    if (isEmpty) return this;

    final List<String> words = toLowerCase().split(' ');
    final StringBuffer sentenceCase = StringBuffer();

    for (int i = 0; i < words.length; i++) {
      final String word = words[i];
      if (word.isNotEmpty) {
        final String capitalizedWord =
            word[0].toUpperCase() + word.substring(1);
        sentenceCase.write(capitalizedWord);

        if (i < words.length - 1) {
          sentenceCase.write(' ');
        }
      }
    }

    return sentenceCase.toString();
  }

  String toSentenceCase() {
    var formattedString = Intl.message(
      this,
      desc: 'Converts a string to sentence case.',
      examples: const {'input': 'Strength point'},
    );

    return formattedString;
  }

  String removeCharactersBeforePeriod(String character) {
    final periodIndex = indexOf(character);
    if (periodIndex >= 0) {
      return substring(periodIndex + 1).trim();
    }
    return this;
  }

  String removeCharactersAfterPeriod(String character) {
    final periodIndex = indexOf(character);
    if (periodIndex >= 0) {
      return substring(0, periodIndex);
    }
    return this;
  }

  String removeContentInParentheses() {
    // Find the index of the opening and closing parentheses
    int openingParenIndex = indexOf('(');
    int closingParenIndex = indexOf(')');

    // Check if both parentheses exist and the opening comes before the closing
    if (openingParenIndex != -1 &&
        closingParenIndex != -1 &&
        openingParenIndex < closingParenIndex) {
      // Extract the substring before the opening parenthesis
      String beforeParen = substring(0, openingParenIndex);

      // Extract the substring after the closing parenthesis
      String afterParen = substring(closingParenIndex + 1);

      // Concatenate the two substrings
      return beforeParen + afterParen;
    } else {
      // No parentheses found or they are not properly balanced
      return this;
    }
  }

  String limitString(int maxLength) {
    if (length <= maxLength) {
      return this;
    }

    String truncatedString = substring(0, maxLength);
    return '$truncatedString...';
  }
}

extension IntExt on int {
  int? nullIfZero() {
    if (this == 0) return null;

    return this;
  }
}
