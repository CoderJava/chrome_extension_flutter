import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controllerText = TextEditingController();
  final valueNotifierQr = ValueNotifier('');
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: formKey,
              child: TextFormField(
                controller: controllerText,
                decoration: const InputDecoration(
                  isDense: true,
                  hintText: 'Enter a text or URL',
                ),
                maxLines: 1,
                minLines: 1,
                onFieldSubmitted: (value) {
                  doCreateQrCode();
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 36,
              child: ElevatedButton(
                onPressed: () {
                  doCreateQrCode();
                },
                child: const Text('Create QR'),
              ),
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder(
              valueListenable: valueNotifierQr,
              builder: (BuildContext context, String value, _) {
                return QrImage(
                  data: value,
                  version: QrVersions.auto,
                    size: 180,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void doCreateQrCode() {
    if (formKey.currentState!.validate()) {
      final qrData = controllerText.text.trim();
      valueNotifierQr.value = qrData;
    }
  }
}
