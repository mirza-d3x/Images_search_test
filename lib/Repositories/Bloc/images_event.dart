part of 'images_bloc.dart';

@immutable
abstract class ImagesEvent {}

class GetImagesEvent extends ImagesEvent {
  final String query;

  GetImagesEvent(this.query);
}
