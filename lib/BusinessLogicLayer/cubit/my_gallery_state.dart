part of 'my_gallery_cubit.dart';

@immutable
abstract class MyGalleryState {}

class MyGalleryInitial extends MyGalleryState {}

class MyGalleryIsLoading extends MyGalleryState {}

class MyGalleryLoaded extends MyGalleryState {
  MyGalleryModel myGalleryModel;
  MyGalleryLoaded(this.myGalleryModel);
}

class MyGalleryFailed extends MyGalleryState {}
