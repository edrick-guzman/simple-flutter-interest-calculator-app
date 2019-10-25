import "package:flutter/material.dart";

void main() => runApp(FavoriteCity());

class FavoriteCity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavoriteCityState();
  }
}

class _FavoriteCityState extends State<FavoriteCity> {
  String cityName = "";
  String currency = "___";
  var _currencies = ['Peso', 'Dollars', 'Yen'];
  var _currentItemSelected = 'Peso';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stateful App example")),
      body: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              TextField(
                onSubmitted: (String userInput) {
                  setState(() {
                    cityName = userInput;
                  });
                },
              ),
              DropdownButton<String>(
                onChanged: (String newValueSelected) {
                  setState(() {
                    currency = newValueSelected;
                  });
                },
                items: _currencies.map(
                  (String currencyItem) {
                    return DropdownMenuItem<String>(
                      value: currencyItem,
                      child: Text(currencyItem),
                    );
                  },
                ).toList(),
                value: _currentItemSelected,
              ),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Your favorite city is ${cityName}",
                    style: TextStyle(fontSize: 20.0),
                  )),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Your favorite currency is ${currency}",
                    style: TextStyle(fontSize: 20.0),
                  ))
            ],
          )),
    );
  }
}
