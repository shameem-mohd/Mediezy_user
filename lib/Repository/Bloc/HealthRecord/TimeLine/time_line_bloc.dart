import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/TimeLineModel/time_line_model.dart';
import 'package:mediezy_user/Repository/Api/HealthRecords/health_record_api.dart';
import 'package:meta/meta.dart';

part 'time_line_event.dart';
part 'time_line_state.dart';

class TimeLineBloc extends Bloc<TimeLineEvent, TimeLineState> {
  late TimeLineModel timeLineModel;
  HealthRecordApi healthRecordsApi = HealthRecordApi();
  TimeLineBloc() : super(TimeLineInitial()) {
    on<FetchTimeLine>((event, emit) async {
      emit(TimeLineLoading());
      try {
        timeLineModel =
            await healthRecordsApi.getTimeLine(patientId: event.patientId);
        emit(TimeLineLoaded());
      } catch (error) {
        print("<<<<<<<<<<Error>>>>>>>>>>" + error.toString());
        emit(TimeLineError());
      }
    });
  }
}
