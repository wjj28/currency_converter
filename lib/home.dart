import 'package:flutter/material.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final realController = TextEditingController();
  final dollarController = TextEditingController();
  final yuanController = TextEditingController();
  final eurosController = TextEditingController();

  late double dollar;
  late double euro;
  late double rmb;

  void _clearAll(
      TextEditingController currency, c2, c3, c4, double d2, d3, d4) {
    double standard = 100;
    //   currency.text = standard.toString();
    //   c2.text = (standard * standard / d2).toStringAsFixed(2);
    //   c3.text = (standard* standard  / d3).toStringAsFixed(2);
    //   c4.text = (standard * standard / d4).toStringAsFixed(2);
 // TODO: make clear the fields change to standard 100$ and update the other fields

  }

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll(realController, dollarController, eurosController,
          yuanController, dollar, euro, rmb);
      return;
    }
    double real = double.parse(text);
    dollarController.text = (real / dollar).toStringAsFixed(2);
    eurosController.text = (real / euro).toStringAsFixed(2);
    yuanController.text = (real / rmb).toStringAsFixed(2);
  }

  void _dollarChanged(String text) {
    if (text.isEmpty) {
      _clearAll(dollarController,  eurosController,yuanController,realController, this.dollar, euro, rmb);
      double dollar = double.parse(text);
      realController.text = (dollar * this.dollar).toStringAsFixed(2);
      eurosController.text = (dollar * this.dollar / euro).toStringAsFixed(2);
      yuanController.text = (dollar * this.dollar / rmb).toStringAsFixed(2);
    }
    double dollar = double.parse(text);
    realController.text = (dollar * this.dollar).toStringAsFixed(2);
    eurosController.text = (dollar * this.dollar / euro).toStringAsFixed(2);
    yuanController.text = (dollar * this.dollar / rmb).toStringAsFixed(2);
  }

  void _eurosChanged(String text) {
    if (text.isEmpty) {
      // _clearAll(eurosController, yuanController,realController, dollarController,  this.euro,rmb,dollar);
      double euro = double.parse(text);
      realController.text = (euro * this.euro).toStringAsFixed(2);
      dollarController.text = (euro * this.euro / dollar).toStringAsFixed(2);
      yuanController.text = (euro * this.euro / rmb).toStringAsFixed(2);
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dollarController.text = (euro * this.euro / dollar).toStringAsFixed(2);
    yuanController.text = (euro * this.euro / rmb).toStringAsFixed(2);
  }

  void _yuanChanged(String text) {
    if (text.isEmpty) {
      // _clearAll(yuanController, realController,dollarController,eurosController, this.rmb, dollar,euro);
      double rmb = double.parse(text);
      realController.text = (rmb * this.rmb).toStringAsFixed(2);
      dollarController.text = (rmb * this.rmb / dollar).toStringAsFixed(2);
      eurosController.text = (rmb * this.rmb / euro).toStringAsFixed(2);
    }

    double rmb = double.parse(text);
    realController.text = (rmb * this.rmb).toStringAsFixed(2);
    dollarController.text = (rmb * this.rmb / dollar).toStringAsFixed(2);
    eurosController.text = (rmb * this.rmb / euro).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Currency'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: Text(
                  'Loading',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 30.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return const Center(
                    child: Text(
                  'Error loading data..',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 30.0,
                  ),
                  textAlign: TextAlign.center,
                ));
              } else {
                dollar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];
                rmb = snapshot.data!["results"]["currencies"]["CNY"]["buy"];

                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Icon(
                          Icons.monetization_on,
                          size: 100,
                          color: Colors.amber,
                        ),
                        // Reais
                        buildTextField(
                          "Reais",
                          "R\$",
                          realController,
                          _realChanged,
                        ),
                        const Divider(),

                        // Dollars
                        buildTextField(
                          "Dollar",
                          "US\$",
                          dollarController,
                          _dollarChanged,
                        ),

                        const Divider(),
                        buildTextField(
                          "Renminbi",
                          "¥",
                          yuanController,
                          _yuanChanged,
                        ),

                        const Divider(),
                        // Eur
                        buildTextField(
                          "Euros",
                          "€",
                          eurosController,
                          _eurosChanged,
                        ),
                      ],
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Widget buildTextField(String label, String prefixText,
    TextEditingController controller, Function(String) functionChanged) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.amber),
      border: const OutlineInputBorder(),
      prefixText: prefixText,
    ),
    style: const TextStyle(color: Colors.amber, fontSize: 16),
    onChanged: functionChanged,
    keyboardType: TextInputType.number,
  );
}
