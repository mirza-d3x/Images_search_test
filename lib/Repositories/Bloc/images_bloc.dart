import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pixbayimages/Model/Images/get_images_model.dart';
import 'package:pixbayimages/Repositories/Api/ImageApi/images_api.dart';

part 'images_event.dart';

part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  ImagesApi imagesApi;
  late GetImagesModel getImagesModel;

  ImagesBloc(this.imagesApi) : super(ImagesInitial()) {
    on<GetImagesEvent>((event, emit) async {
      emit(ImagesLoading());
      try {
        getImagesModel = await imagesApi.getImages(query: event.query);
        emit(ImagesLoaded());
      } catch (e) {
        print('>>>>>>>>>>>>>>>>>>>>>>>>>>>$e');
        emit(ImagesError());
      }
    });
  }
}
