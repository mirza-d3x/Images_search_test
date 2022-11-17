import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'images_event.dart';
part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  ImagesBloc() : super(ImagesInitial()) {
    on<ImagesEvent>((event, emit) {
      emit(ImagesLoading());
      try{

        emit(ImagesLoaded());
      }catch(e){
        emit(ImagesError());
      }
    });
  }
}
