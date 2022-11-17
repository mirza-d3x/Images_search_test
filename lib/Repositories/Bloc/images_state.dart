part of 'images_bloc.dart';

@immutable
abstract class ImagesState {}

class ImagesInitial extends ImagesState {}

class ImagesLoading extends ImagesState {}

class ImagesLoaded extends ImagesState {}

class ImagesError extends ImagesState {}
