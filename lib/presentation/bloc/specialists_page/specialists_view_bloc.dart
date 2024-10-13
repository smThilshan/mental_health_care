import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'specialists_view_event.dart';
part 'specialists_view_state.dart';

class SpecialistsViewBloc extends Bloc<SpecialistsViewEvent, SpecialistsViewState> {
  SpecialistsViewBloc() : super(SpecialistsViewInitial()) {
    on<SpecialistsViewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
