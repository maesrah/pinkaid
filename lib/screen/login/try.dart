import 'package:flutter/material.dart';
import 'package:pinkaid/generated/l10n.dart';

class TryPage extends StatefulWidget {
  const TryPage({super.key});

  @override
  State<TryPage> createState() => _TryPageState();
}

class _TryPageState extends State<TryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(S.of(context).welcome),
          MaterialButton(
            onPressed: () {
              S.load(const Locale("ms", "MY"));
            },
            child: const Text("Change language"),
          ),
        ],
      ),
    );
  }
}
