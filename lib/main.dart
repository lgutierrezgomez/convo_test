import 'package:convo_test/presentation/pages/report_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'domain/usecases/get_report_usecase.dart';
import 'data/repositories/report_repository_impl.dart';
import 'data/datasources/local/report_local_datasource.dart';
import 'data/datasources/remote/report_remote_datasource.dart';
import 'presentation/bloc/report_bloc.dart';

Future<void> main() async {

  final dio = Dio();
  final sharedPreferences = await SharedPreferences.getInstance();

  final remoteDataSource = RemoteReportDataSourceImpl(dio);
  final localDataSource = LocalReportDataSourceImpl(sharedPreferences);
  final repository = ReportRepositoryImpl(remoteDataSource, localDataSource);
  final getReportUseCase = GetReportUseCase(repository);

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(getReportUseCase: getReportUseCase));
}

class MyApp extends StatelessWidget {
  final GetReportUseCase getReportUseCase;
  const MyApp({super.key, required this.getReportUseCase});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => ReportBloc(getReportUseCase),
        child: ReportPage(),
      ),
    );
  }
}