import 'dart:convert';

void main() {
  const jsonData = '''
{
  "animals": [
    { "animal": "dog,cat,dog,cow,monkey" },
    { "animal": "cow,cat,cat,lion" },
    { "animal": null },
    { "animal": "" }
  ]
}
''';

  final decoded = jsonDecode(jsonData);
  List animalsList = decoded['animals'];

  for (var item in animalsList) {
    print(formatAnimals(item['animal']));
  }
}

String formatAnimals(dynamic value) {
  // Skip null or empty values
  if (value == null || value.toString().trim().isEmpty) {
    return "";
  }

  String animalString = value.toString();

  // Split the string into a list
  List<String> animals = animalString.split(",").map((e) => e.trim()).toList();

  // Count occurrences
  Map<String, int> countMap = {};

  for (var a in animals) {
    if (a.isEmpty) continue;
    countMap[a] = (countMap[a] ?? 0) + 1;
  }

  // formatted output
  List<String> formatted = [];

  countMap.forEach((key, count) {
    if (count > 1) {
      formatted.add("$key($count)");
    } else {
      formatted.add(key);
    }
  });

  return formatted.join(", ");
}
