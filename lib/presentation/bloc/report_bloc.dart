import 'package:flutter_bloc/flutter_bloc.dart';
import 'report_event.dart';
import 'report_state.dart';
import '../../domain/usecases/get_report_usecase.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final GetReportUseCase getReportUseCase;

  ReportBloc(this.getReportUseCase) : super(ReportInitial()) {
    on<GetReportEvent>((event, emit) async {
      emit(ReportLoading());
      final result = await getReportUseCase.execute(event.latitude, event.longitude);

      result.fold(
            (failure) => emit(ReportError(failure.message)),
            (report) => emit(ReportLoaded(report)),
      );
    });
  }
}