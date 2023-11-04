import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSelectionScreen extends StatefulWidget {
  @override
  _ThemeSelectionScreenState createState() => _ThemeSelectionScreenState();
}

Color x = Colors.purple;

class _ThemeSelectionScreenState extends State<ThemeSelectionScreen> {
  String? selectedTheme;
  final List<String> themeOptions = [
    'blue',
    'red',
    'Dark Theme',
    'light',
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: x,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: selectedTheme,
              onChanged: (newValue) {
                setState(() {
                  selectedTheme = newValue;
                  if (newValue == "blue") {
                    x = Colors.blue;
                  } else if (newValue == "red") {
                    x = Colors.redAccent;
                  } else if (newValue == "Dark Theme") {
                    x = Colors.black12;
                  } else {
                    x = Colors.white;
                  }
                });
              },
              items: themeOptions.map((String theme) {
                return DropdownMenuItem<String>(
                  value: theme,
                  child: Text(theme),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveTheme();
              },
              child: Text(
                'Save Theme',
                style: TextStyle(
                    color: Colors.white), // Change the button text color
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white54, // Change the button background color
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadSavedTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedTheme = prefs.getString('selectedTheme') ?? themeOptions[0];
    setState(() {
      selectedTheme = savedTheme;
    });
  }

  _saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedTheme', selectedTheme!);
  }
}
