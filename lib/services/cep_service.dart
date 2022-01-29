import 'dart:convert';

import 'package:busca_aqui/models/address.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart';

class LoggingInterception implements InterceptorContract {
  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print(data);
    return data;
  }

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print(data);
    return data;
  }
}

class CepService {
  final Client _client = InterceptedClient.build(interceptors: [
    LoggingInterception(),
  ]);

  Uri _baseUri({required route}) {
    return Uri.parse('https://viacep.com.br/ws/$route/json/');
  }

  Future <Address> findByCep({required String cep}) async {
    Response response = await _client.get(
      _baseUri(route: cep),
    );

    Map<String, dynamic> addressMap = jsonDecode(response.body);

    Address address = Address(
      cep: addressMap['cep'],
      logradouro: addressMap['logradouro'],
      complemento: addressMap['complemento'],
      bairro: addressMap['bairro'],
      localidade: addressMap['localidade'],
      uf: addressMap['uf'],
      ibge: addressMap['ibge'],
      gia: addressMap['gia'],
      ddd: addressMap['ddd'],
      siafi: addressMap['siafi'],
    );

    print(addressMap);

    return address;
  }
}
