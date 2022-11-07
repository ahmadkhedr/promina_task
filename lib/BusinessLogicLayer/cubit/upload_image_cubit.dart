import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:pro_mina_task/DataLayer/Repositories/UploadImageRepository.dart';

part 'upload_image_state.dart';

class UploadImageCubit extends Cubit<UploadImageState> {
  UploadImageCubit() : super(UploadImageInitial());
  final uploadImageRepository = UploadImageRepository();

  uploadImage(File image) async {
    emit(UploadImageInitial());
    emit(UploadImageLoading());
    var reponse = await uploadImageRepository.uploadImageRequest(image);

    reponse == 200
        ? emit(UploadImageLoadded(reponse))
        : emit(UploadImageError());
  }
}
