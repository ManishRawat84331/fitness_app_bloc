// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'onboarding_event.dart';
// part 'onboarding_state.dart';

// class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
//   OnboardingBloc() : super(OnboardingInitial());

//   int pageIndex = 0;

//   final pageController = PageController(initialPage: 0);

//   @override
//   Stream<OnboardingEvent> mapEventToState(OnboardingEvent event) async* {
//     if (event is PageChangedEvent) {
//       if (pageIndex == 2) {
//         yield NextScreenState();
//         return;
//       }
//       pageIndex += 1;
//       pageController.animateToPage(
//         pageIndex,
//         duration: Duration(milliseconds: 500),
//         curve: Curves.ease,
//       );

//       yield PageChangedState(counter: pageIndex);
//     } else if (event is PageSwipedEvent) {
//       pageIndex = event.index;
//       yield PageChangedState(counter: pageIndex);
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitial()) {
    on<PageChangedEvent>(_onPageChanged);
    on<PageSwipedEvent>(_onPageSwiped);
  }

  int pageIndex = 0;
  final PageController pageController = PageController(initialPage: 0);

  void _onPageChanged(PageChangedEvent event, Emitter<OnboardingState> emit) {
    if (pageIndex == 2) {
      emit(NextScreenState());
      return;
    }
    pageIndex += 1;
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );

    emit(PageChangedState(counter: pageIndex));
  }

  void _onPageSwiped(PageSwipedEvent event, Emitter<OnboardingState> emit) {
    pageIndex = event.index;
    emit(PageChangedState(counter: pageIndex));
  }

  @override
  Future<void> close() {
    pageController.dispose(); // Dispose of pageController
    return super.close();
  }
}
