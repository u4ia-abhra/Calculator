import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Scientific extends StatefulWidget {
  const Scientific({super.key});

  @override
  State<Scientific> createState() => _ScientificState();
}

class _ScientificState extends State<Scientific> {
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
      } else if (value == 'Del') {
        if (displayText.isNotEmpty) {
          displayText = displayText.substring(0, displayText.length - 1);
        }
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
      if (eval % 1 == 0) {
        return eval.toInt().toString();
      } else {
        return eval
            .toStringAsFixed(8); // Customize the number of decimal places
      }
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
        title: const Text('Scientific Calculator'),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              calcbutton('AC', Colors.grey, Colors.white),
              calcbutton('Del', Colors.grey, Colors.white),
              calcbutton('%', Colors.grey, Colors.white),
              calcbutton('nCr', Colors.grey, Colors.white),
              calcbutton('nPr', Colors.grey, Colors.white),
            ],
          ),
          const SizedBox(
            height: 10,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calcbutton(
                  'sin', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  'cos', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  'tan', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  'sqrt', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton('log', Colors.orange, Colors.white),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calcbutton(
                  '7', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  '8', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  '9', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  'e', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton('ln', Colors.orange, Colors.white),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calcbutton(
                  '4', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  '5', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  '6', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  'x', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton('/', Colors.orange, Colors.white),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calcbutton(
                  '1', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  '2', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  '3', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  '+', const Color.fromARGB(255, 61, 61, 61), Colors.white),
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
                  '00', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  '0', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  '.', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton(
                  '%', const Color.fromARGB(255, 61, 61, 61), Colors.white),
              calcbutton('=', Colors.orange, Colors.white),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
