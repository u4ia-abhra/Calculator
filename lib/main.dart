import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  
  dynamic displayText = '0';

  //design of calculator button
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

//calculator display logic
  void onButtonPressed(String value) {
    setState(() {
      if (value == 'AC') {
        displayText = '0';
      } else if (value == '=') {
        try {
          displayText = _evaluateExpression(displayText);
        } catch (e) {
          displayText = 'Error';
        }
      } else {
        displayText == '0' ? displayText = value : displayText += value;
      }
    });
  }

//calculator logic
String _evaluateExpression(String expression) {
  try {
    expression = expression.replaceAll('x', '*').replaceAll('÷', '/');
    Parser parser = Parser();
    Expression exp = parser.parse(expression);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    return eval.toString();
  } catch (e) {
    return 'Error';
  }
}

//calculator UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.orange,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //calculator display
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    displayText,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              calcbutton('AC', Colors.grey, Colors.white),
              calcbutton('+/-', Colors.grey, Colors.white),
              calcbutton('%', Colors.grey, Colors.white),
              calcbutton('/', Colors.grey, Colors.white),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
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
              // calcbutton('4',Colors.grey,Colors.white),
              // calcbutton('5',Colors.grey,Colors.white),
              // calcbutton('6',Colors.grey,Colors.white),
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
              // calcbutton('3',Colors.grey,Colors.white),
              // calcbutton('2',Colors.grey,Colors.white),
              // calcbutton('1',Colors.grey,Colors.white),
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
              // calcbutton('00',Colors.grey,Colors.white),
              // calcbutton('0',Colors.grey,Colors.white),
              // calcbutton('.',Colors.grey,Colors.white),
              calcbutton('=', Colors.orange, Colors.white),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}