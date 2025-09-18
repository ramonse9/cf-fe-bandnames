import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    this._socket = IO.io(
      'http://10.0.2.2:3000',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setExtraHeaders({'foo': 'bar'}) // Ejemplo de cabecera adicional
          .build(),
    );

    this._socket.onConnectError((data) {
      print("ERROR: $data");
    });

    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    this._socket.on('nuevo-mensaje', (payload) {
      print('-nuevo-mensaje-');
      print('nuevo-mensaje: $payload');
      print('nombre: ' + payload['nombre']);
      print('mensaje: ' + payload['mensaje']);
      print(payload.containsKey('mensaje2') ? payload['mensaje2'] : 'no hay');
      print('nuevo-mensaje fin');
    });
  }
}
