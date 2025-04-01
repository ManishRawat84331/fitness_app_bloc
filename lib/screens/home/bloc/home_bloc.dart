import 'package:bloc/bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<ReloadImageEvent>(_onReloadImageState);
  }

  void _onReloadImageState(HomeEvent event, Emitter<HomeState> emit) {
    emit(ReloadImageState());
  }
}
