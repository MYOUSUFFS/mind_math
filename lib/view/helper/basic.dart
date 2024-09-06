import 'package:flutter/material.dart';

class Basic {
  static String? Function(String?)? empty = (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  };
}

class BasicText {
  static TextStyle h1 = const TextStyle(
      fontFamily: 'prime', fontSize: 40, fontWeight: FontWeight.bold);
  // GoogleFonts.ibmPlexMono(fontSize: 40, fontWeight: FontWeight.bold);
  static TextStyle h2 = const TextStyle(
      fontFamily: 'prime', fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle h3 = const TextStyle(
      fontFamily: 'prime', fontSize: 18, fontWeight: FontWeight.bold);
  static TextStyle h4 = const TextStyle(
      fontFamily: 'prime', fontSize: 14, fontWeight: FontWeight.bold);
}

class BasicColors {
  static Color hexToColor(String color) =>
      Color(int.parse('0xFF${color.replaceFirst('#', '')}'));
  static const Map<String, dynamic> basicColors = {
    "None": null,
    "Red": "#FF0000",
    "Crimson": "#DC143C",
    "Scarlet": "#FF2400",
    "Maroon": "#800000",
    "Blue": "#0000FF",
    "Navy": "#000080",
    "Sky Blue": "#87CEEB",
    "Royal Blue": "#4169E1",
    "Green": "#008000",
    "Emerald": "#50C878",
    "Olive": "#808000",
    "Mint": "#98FF98",
    "Yellow": "#FFFF00",
    "Gold": "#FFD700",
    "Lemon": "#FFF44F",
    "Mustard": "#FFDB58",
    "Purple": "#800080",
    "Lavender": "#E6E6FA",
    "Violet": "#8A2BE2",
    "Mauve": "#E0B0FF",
    "Orange": "#FFA500",
    "Coral": "#FF7F50",
    "Amber": "#FFBF00",
    "Peach": "#FFDAB9",
    "Pink": "#FFC0CB",
    "Rose": "#FF007F",
    "Blush": "#FFB6C1",
    "Magenta": "#FF00FF",
    "Brown": "#A52A2A",
    "Chocolate": "#D2691E",
    "Tan": "#D2B48C",
    "Umber": "#635147",
    "Gray": "#808080",
    "Charcoal": "#36454F",
    "Silver": "#C0C0C0",
    "Slate": "#708090",
    "White": "#ffffff",
  };
}

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final Widget subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: BasicText.h3,
      ),
      subtitle: subtitle,
    );
  }
}
