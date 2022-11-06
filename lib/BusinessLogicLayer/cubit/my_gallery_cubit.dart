import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../DataLayer/Models/OnLineModels/MyGalleryModel.dart';
import '../../DataLayer/Repositories/MyGalleryRepository.dart';

part 'my_gallery_state.dart';

class MyGalleryCubit extends Cubit<MyGalleryState> {
  MyGalleryCubit() : super(MyGalleryInitial());
  final myGalleryRepository = MyGalleryRepository();

  MyGalleryModel? myGalleryModel;

  getUserGallery() async {
    emit(MyGalleryInitial());
    emit(MyGalleryIsLoading());

    myGalleryModel = await myGalleryRepository.getUserGallery();

    emit(MyGalleryLoaded(myGalleryModel!));
  }
}
