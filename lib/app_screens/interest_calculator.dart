import "package:flutter/material.dart";

void main() => runApp(InterestCalculator());

class InterestCalculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InterestCalculatorState();
  }
}

class _InterestCalculatorState extends State<InterestCalculator> {
  final double _fontSize = 20.0;
  final double _minPadding = 15.0;
  String currency = "___";
  var _currencies = ['Peso', 'Dollars', 'Yen'];
  var _currentItemSelected = 'Peso';
  var _displayText = "";
  var _formKey = GlobalKey<FormState>();

  TextEditingController principalCont = TextEditingController();
  TextEditingController roiCont = TextEditingController();
  TextEditingController termCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
        appBar: AppBar(
          title: Text("Simple Interest Calculator"),
        ),
        body: Form(
            key: _formKey,
            //margin: EdgeInsets.all(10.0),
            child: Padding(
                padding: EdgeInsets.all(_minPadding),
                child: ListView(children: <Widget>[
                  Center(
                      child: Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: Image(
                              image: AssetImage('images/bank.png'),
                              height: 200.0,
                              width: 200.0))),
                  Padding(
                      padding: EdgeInsets.all(_minPadding),
                      child: TextFormField(
                        controller: principalCont,
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please input principal amount";
                          } else if (double.tryParse(value) == null) {
                            return "Please input a number";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Principal",
                            hintText: "e.g. 1000",
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.all(_minPadding),
                      child: TextFormField(
                        controller: roiCont,
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please input rate of interest";
                          } else if (double.tryParse(value) == null) {
                            return "Please input a number";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Rate of interest",
                            labelStyle: textStyle,
                            hintText: "in percent",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                    padding: EdgeInsets.all(_minPadding),
                    child: Row(children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: termCont,
                          style: textStyle,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Please input term";
                            } else if (double.tryParse(value) == null) {
                              return "Please input a number";
                            }
                          },
                          decoration: InputDecoration(
                              labelStyle: textStyle,
                              hintText: "Term",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
                      Container(width: _minPadding),
                      Expanded(
                          child: DropdownButton<String>(
                        items: _currencies.map((String currency) {
                          return DropdownMenuItem<String>(
                            value: currency,
                            child: Text(currency),
                          );
                        }).toList(),
                        value: _currentItemSelected,
                        style: textStyle,
                        onChanged: (String value) {
                          _onDropdownItemSelected(value);
                        },
                      ))
                    ]),
                  ),
                  Padding(
                      padding: EdgeInsets.all(_minPadding),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                child: RaisedButton(
                              child: Text(
                                "Calculate",
                                style: textStyle,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState.validate()) {
                                    this._displayText = _calculateTotalReturns();
                                  }
                                });
                              },
                              color: Colors.blue,
                            )),
                            Expanded(
                                child: RaisedButton(
                              child: Text("Reset", style: textStyle),
                              onPressed: () {
                                _reset();
                              },
                              color: Colors.white70,
                            ))
                          ])),
                  Center(child: Text(_displayText))
                ]))));
  }

  void _onDropdownItemSelected(String value) {
    setState(() {
      this._currentItemSelected = value;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalCont.text);
    double term = double.parse(termCont.text);
    double roi = double.parse(roiCont.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;

    String result =
        'After $term years, your investment will be worth $totalAmountPayable $_currentItemSelected';
    return result;
  }

  void _reset() {
    principalCont.text = "";
    roiCont.text = "";
    termCont.text = "";
    _currentItemSelected = _currencies[0];
    setState(() {
      this._displayText = "";
    });
  }
}
