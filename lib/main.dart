import 'package:calculator/scientific.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Basic Calculator',
      home: const Basic(),
      routes: {
        '/scientific': (context) => Scientific(),
      },
    );
  }
}

class Basic extends StatefulWidget {
  const Basic({super.key});

  @override
  State<Basic> createState() => _BasicState();
}

class _BasicState extends State<Basic> {
  dynamic displayText = '0';
  bool isResultDisplayed = false; // Flag to track if result is displayed

  // Design of calculator button
  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    return ElevatedButton(
      onPressed: () {
        onButtonPressed(btntxt);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: btncolor,
          padding: const EdgeInsets.all(10),
          shape: const CircleBorder()),
      child: Text(
        btntxt,
        style: TextStyle(
          fontSize: 35,
          color: txtcolor,
        ),
      ),
    );
  }

  // Calculator display logic
  void onButtonPressed(String value) {
    setState(() {
      if (value == 'AC') {
        displayText = '0';
        isResultDisplayed = false; // Reset the flag
      } else if (value == 'Del') {
        if (displayText.isNotEmpty && !isResultDisplayed) {
          displayText = displayText.substring(0, displayText.length - 1);
        }
      } else if (value == '=') {
        try {
          displayText = _evaluateExpression(displayText);
          isResultDisplayed = true; // Mark that the result is displayed
        } catch (e) {
          displayText = 'Error';
        }
      } else {
        // Check if the result was displayed and the new input is a number
        if (isResultDisplayed && RegExp(r'^\d$').hasMatch(value)) {
          displayText = value; // Reset display to the new number
          isResultDisplayed = false; // Reset the flag
        } else {
          displayText == '0' ? displayText = value : displayText += value;
          isResultDisplayed = false; // Reset the flag if other input
        }
      }
    });
  }

  // Calculator logic
  String _evaluateExpression(String expression) {
    try {
      // Replace 'x' and '÷' with '*' and '/'
      expression = expression.replaceAll('x', '*').replaceAll('÷', '/').replaceAll('%', '/100');

      // Remove trailing operand if the expression ends with one
      final operandPattern = RegExp(r'[+\-*/^]$');
      if (operandPattern.hasMatch(expression)) {
        expression = expression.substring(0, expression.length - 1);
      }

      // Parse and evaluate the expression
      Parser parser = Parser();
      Expression exp = parser.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      // Return integer if the result is a whole number
      if (eval % 1 == 0) {
        return eval.toInt().toString();
      } else {
        // Limit to 8 significant digits
        String evalStr = eval.toString();
        if (evalStr.contains('e') || evalStr.length > 8) {
          // Handle scientific notation or long results
          return eval.toStringAsPrecision(8);
        }
        return evalStr; // Return as-is for short results
      }
    } catch (e) {
      return 'Error';
    }
  }

  // Calculator UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Basic Calculator'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.orange,
        actions: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/scientific');
              },
              icon: Icon(Icons.science),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Calculator display
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 100,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          displayText,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          // Calculator buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              calcbutton('AC', Colors.grey, Colors.white),
              calcbutton('Del', Colors.grey, Colors.white),
              calcbutton('%', Colors.grey, Colors.white),
              calcbutton('/', Colors.grey, Colors.white),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              calcbutton(
                  '7', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  '8', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  '9', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton('x', Colors.orange, Colors.white),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              calcbutton(
                  '4', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  '5', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  '6', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton('-', Colors.orange, Colors.white),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calcbutton(
                  '3', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  '2', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  '1', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton('+', Colors.orange, Colors.white),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              calcbutton(
                  '00', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  '0', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  '.', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton('=', Colors.orange, Colors.white),
            ],
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}