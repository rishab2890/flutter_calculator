import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

final operatorButtonColor = Color(0xFF9B08);
final digitButtonColor = Color(0x333333);
final operationButtonColor = Color(0xA5A5A5);

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equation = "";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: Colors.black,
      child: RawMaterialButton(
          fillColor: buttonColor,
          shape: CircleBorder(
              side: BorderSide(
                  color: buttonColor, width: 1, style: BorderStyle.solid)),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
    );
  }

  @override
  final operatorButtonColor = Color(0xFF9B08);
  final digitButtonColor = Color(0x333333);
  final operationButtonColor = Color(0xA5A5A5);
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize, color: Colors.white),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize, color: Colors.white),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("AC", 1, Colors.grey[400]),
                      buildButton("⌫", 1, Colors.grey[400]),
                      buildButton("%", 1, Colors.grey[400]),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Colors.grey[900]),
                      buildButton("8", 1, Colors.grey[900]),
                      buildButton("9", 1, Colors.grey[900]),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.grey[900]),
                      buildButton("5", 1, Colors.grey[900]),
                      buildButton("6", 1, Colors.grey[900]),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Colors.grey[900]),
                      buildButton("2", 1, Colors.grey[900]),
                      buildButton("3", 1, Colors.grey[900]),
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, Colors.grey[900]),
                      buildButton("0", 1, Colors.grey[900]),
                      buildButton("00", 1, Colors.grey[900]),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("×", 1, Colors.yellow[900]),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.yellow[900]),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.yellow[900]),
                    ]),
                    TableRow(children: [
                      buildButton("/", 1, Colors.yellow[900]),
                    ]),
                    TableRow(children: [
                      buildButton("=", 1, Colors.yellow[900]),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
