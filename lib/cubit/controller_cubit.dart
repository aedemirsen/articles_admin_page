import 'package:articles_admin_page/model/record.dart';
import 'package:articles_admin_page/service/service.dart';
import 'package:bloc/bloc.dart';

class ControllerCubit extends Cubit<ControllerState> {
  ControllerCubit(this.service) : super(ControllerInitial());

  bool isLoading = false;

  String info = 'Kaydın eklenmesi bekleniyor...';
  //Service
  final Service service;

  Future<void> addRecord(Record record) async {
    changeLoadingState(true);
    final data = await service.postRecord(record);
    if (data) {
      info = 'Kayıt Başarıyla Eklendi!';
      emit(PostSuccessful());
    } else {
      info = 'Kayıt Eklenmesi Başarısız!';
      emit(PostFail());
    }
    changeLoadingState(false);
  }

  void changeLoadingState(bool b) {
    isLoading = b;
    emit(LoadingStateChanged(isLoading));
  }
}

abstract class ControllerState {}

class ControllerInitial extends ControllerState {}

class LoadingStateChanged extends ControllerState {
  final bool isLoading;

  LoadingStateChanged(this.isLoading);
}

class PostSuccessful extends ControllerState {}

class PostFail extends ControllerState {}
