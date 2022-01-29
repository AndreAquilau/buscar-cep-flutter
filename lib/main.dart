import 'package:busca_aqui/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BuscaAquiApp());
}

class BuscaAquiApp extends StatelessWidget {
  const BuscaAquiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: DashBoardScreen(),
    );
  }
}
