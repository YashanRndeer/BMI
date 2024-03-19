import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        hintColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('BMI Calculator'),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'BMI',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              BMICalculatorScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  double result = 0;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: weightController,
            maxLength: 8,
            decoration: InputDecoration(
              labelText: 'Weight (kg)',
              icon: Icon(Icons.fitness_center),
              errorText: errorMessage,
            ),
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: heightController,
            maxLength: 8,
            decoration: InputDecoration(
              labelText: 'Height (cm)',
              icon: Icon(Icons.height),
              errorText: errorMessage,
            ),
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              String weight = weightController.text;
              String height = heightController.text;

              if (weight.isEmpty || height.isEmpty) {
                setState(() {
                  errorMessage = 'All fields are required.';
                });
                return;
              } else {
                setState(() {
                  errorMessage = null;
                });
              }

              double W = double.tryParse(weight) ?? 0;
              double H = double.tryParse(height) ?? 0;

              if (H != 0) {
                setState(() {
                  result = (W / ((H * H) / 10000));
                });
                // Navigate to ResultPage and pass the result
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(result: result),
                  ),
                );
              } else {
                setState(() {
                  result = 0;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Calculate',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ResultScreen extends StatelessWidget {
  final double result;
  late String resultName;

  ResultScreen({Key? key, required this.result}) : super(key: key) {
    // Assigning resultName based on BMI result
    if (result < 16) {
      resultName = 'Severe undernourishment';
    } else if (result >= 16 && result < 16.9) {
      resultName = 'Severe undernourishment';
    } else if (result >= 17 && result < 18.4) {
      resultName = 'Slight undernourishment';
    } else if (result >= 18.5 && result < 24.9) {
      resultName = 'Normal nutrition state';
    } else if (result >= 25 && result < 29.9) {
      resultName = 'Overweight';
    } else if (result >= 30 && result < 39.9) {
      resultName = 'Obesity';
    } else {
      resultName = 'Morbid obesity';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Result: ${result.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Your Status: $resultName',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
