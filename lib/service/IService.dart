import 'package:articles_admin_page/model/record.dart';
import 'package:dio/dio.dart';

abstract class IService {
  final Dio dio;

  final String endpoint = '/articles';

  IService(this.dio);

  Future<List<Record>> getRecords({String params = ''});

  Future<bool> deleteRecord(String id);

  Future<bool> postRecord(Record record);
}
