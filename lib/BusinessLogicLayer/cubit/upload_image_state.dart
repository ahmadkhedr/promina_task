part of 'upload_image_cubit.dart';

@immutable
abstract class UploadImageState {}

class UploadImageInitial extends UploadImageState {}

class UploadImageLoading extends UploadImageState {}

class UploadImageLoadded extends UploadImageState {
  UploadImageLoadded(this.reponse);
  var reponse;
}

class UploadImageError extends UploadImageState {}
