import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest",
    home: SIForm(),
  ));
}

class SIForm extends StatefulWidget {
 

  @override
  State<StatefulWidget> createState() {
    
    return _SIFormState();
  }
}
class _SIFormState extends State<SIForm>{
  final _formKey = GlobalKey<FormState>();
  final _currencies = ['Rupees', 'Dollars', 'Pounds'];
  final _minimumPadding = 5.0;
  var _currentItemSelected = 'Rupees';
  var displayResult = '';

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  TextStyle? textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
      
      
      backgroundColor: Colors.lightBlue[100],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Simple interest calculator "),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_minimumPadding * 2),
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principalController,
                  // ignore: missing_return
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter principal amount';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Principal',
                      hintText: "Enter Principal e.g 12000",
                      labelStyle: textStyle,
                      errorStyle: const TextStyle(color: Colors.yellow, fontSize: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: roiController,
                  // ignore: missing_return
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter Rate of interest';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Rate of interest',
                      hintText: 'In parcent',
                      labelStyle: textStyle,
                      errorStyle: const TextStyle(color: Colors.yellow, fontSize: 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: termController,
                        // ignore: missing_return
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter Term';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Term',
                            hintText: 'Time in years',
                            labelStyle: textStyle,
                            errorStyle:
                                const TextStyle(color: Colors.yellow, fontSize: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                      Container(
                        width: _minimumPadding * 5,
                      ),
                      Expanded(
                          child: DropdownButton<String>(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _currentItemSelected,
                        onChanged: (String? newSelectedValue) {
                          _onDropDownItemSelected(newSelectedValue!);
                        },
                      ))
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          color: Colors.green,
                          textColor: Colors.white,
                          child: const Text('Calculate'),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState!.validate()) {
                                displayResult = _calculateTotalReturns();
                              }
                            }); // do calculate
                          },
                        ),
                      ),
                      Container(
                        width: _minimumPadding * 2,
                      ),
                      Expanded(
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          color: Colors.red,
                          textColor: Colors.white,
                          child: const Text('Reset'),
                          onPressed: () {
                            setState(() {
                              _doReset();
                            });
                          },
                        ),
                      )
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding * 2, bottom: _minimumPadding),
                child: Text(
                  displayResult,
                  style: textStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = const AssetImage('images/bank.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
      color: Colors.white,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 5),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      _currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result =
        'After $term years, your investment will be worth $totalAmountPayable $_currentItemSelected';
    return result;
  }

  void _doReset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}