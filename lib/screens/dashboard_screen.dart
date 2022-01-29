import 'package:busca_aqui/models/address.dart';
import 'package:busca_aqui/services/cep_service.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  bool buscar = false;

  final TextEditingController _controllerCep = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeeeeee),
      appBar: AppBar(
        backgroundColor: const Color(0xFFfdd835),
        title: const Text(
          'Consultar CEP',
          style: TextStyle(
            color: Color(0xFF1A237E),
          ),
        ),
        leading: const Icon(
          Icons.map_sharp,
          color: Color(0xFF1A237E),
          size: 40,
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _controllerCep,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  gapPadding: 5,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xffe0e0e0),
                fixedSize: const Size(double.maxFinite, 50),
                primary: const Color(0xFF1A237E),
              ),
              onPressed: () {
                String cep = _controllerCep.text;

                if (cep.trim() == '') return;

                setState(() {
                  buscar = true;
                });
              },
              child: const Text(
                'Buscar',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: FutureBuilder<Address>(
              future: CepService().findByCep(cep: _controllerCep.text),
              builder: (context, snapshot) {


                if (!buscar) {
                  return const Center(
                    child: Text('Digite um CEP'),
                  );
                }
                if(snapshot.data == null){
                  return const Center(
                    child: Text('CEP Inválido'),
                  );
                }

                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: Column(
                        children: const [
                          Text('Buscando...'),
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                    break;
                  case ConnectionState.done:
                    return Center(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'CEP: ${snapshot.data!.cep}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Logradouro: ${snapshot.data!.logradouro}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Complemento: ${snapshot.data!.complemento}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Bairro: ${snapshot.data!.bairro}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Localidade: ${snapshot.data!.localidade}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'UF: ${snapshot.data!.uf}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    break;
                  default:
                    return const Center(
                      child: Text('Erro'),
                    );
                    break;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
