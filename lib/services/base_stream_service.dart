import 'dart:async';

abstract class MyStreamBase<T> {
  T empty;
  Map? map;

  final StreamController<T> _streamController = StreamController();

  late final Stream<T> _broadCasMe;
  Stream<T> get broadCastStream => _broadCasMe;

  StreamController<T> get streamController => _streamController;

  MyStreamBase({required this.empty}) {
    _broadCasMe = streamController.stream.asBroadcastStream();
  }

  dynamic handleSuccessWithReturn(T data) {
    _streamController.sink.add(data);
    return data;
  }

  dynamic handleErrorWithReturn(dynamic error) {
    _streamController.sink.addError(error);
    throw error;
  }

  void clean() {
    _streamController.sink.add(empty);
  }

  void dispose() {
    _streamController.close();
  }
}
