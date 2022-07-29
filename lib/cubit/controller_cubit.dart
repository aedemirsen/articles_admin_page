import 'package:articles_admin_page/model/record.dart';
import 'package:articles_admin_page/service/service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ControllerCubit extends Cubit<ControllerState> {
  ControllerCubit(this.service) : super(ControllerInitial());

  bool isLoading = false;
  bool passwordValid = false;
  bool isPasswordLoading = false;

  TextEditingController passwordController = TextEditingController();

  String info = 'Kaydın eklenmesi bekleniyor...';
  String passwordInfo = '';
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

  Future<void> getPassword() async {
    changePasswordLoadingState(true);
    final data = await service.getPassword();
    if (data.isNotEmpty && data == passwordController.text) {
      passwordValid = true;
      emit(PasswordValid());
    } else {
      passwordValid = false;
      passwordInfo = 'Başarısız...';
      emit(PasswordFail());
    }
    changePasswordLoadingState(false);
  }

  void changeLoadingState(bool b) {
    isLoading = b;
    emit(LoadingStateChanged(isLoading));
  }

  void changePasswordLoadingState(bool b) {
    isPasswordLoading = b;
    emit(LoadingStateChanged(isLoading));
  }
}

abstract class ControllerState {}

class ControllerInitial extends ControllerState {}

class LoadingStateChanged extends ControllerState {
  final bool isLoading;

  LoadingStateChanged(this.isLoading);
}

class PasswordValid extends ControllerState {}

class PasswordFail extends ControllerState {}

class PostSuccessful extends ControllerState {}

class PostFail extends ControllerState {}
