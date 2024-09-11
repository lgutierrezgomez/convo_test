import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final Function(double latitude, double longitude) onSubmit;

  const InputWidget({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // Latitude Input Field
          TextFormField(
            key: const Key('latitudeField'),
            controller: _latitudeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Latitude',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid latitude';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),

          // Longitude Input Field
          TextFormField(
            key: const Key('longitudeField'),
            controller: _longitudeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Longitude',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid longitude';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          const SizedBox(height: 24.0),

          // Button to trigger API call
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final double latitude = double.parse(_latitudeController.text);
                final double longitude = double.parse(_longitudeController.text);

                widget.onSubmit(latitude, longitude);
              }
            },
            child: const Text('Get Weather Report'),
          ),
        ],
      ),
    );
  }
}
