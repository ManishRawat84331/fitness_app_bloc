import 'package:bloc/bloc.dart';
import 'package:fitness_app/core/service/firebase_storage_service.dart';
import 'package:fitness_app/core/service/user_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'edit_account_event.dart';
part 'edit_account_state.dart';

class EditAccountBloc extends Bloc<EditAccountEvent, EditAccountState> {
  EditAccountBloc() : super(EditAccountInitial()) {
    on<UploadImage>(_onUploadImage);
    on<ChangeUserData>(_onChangeUserData);
  }

  Future<void> _onUploadImage(UploadImage event, Emitter<EditAccountState> emit) async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        emit(EditAccountProgress());
        await FirebaseStorageService.uploadImage(filePath: image.path);
        emit(EditPhotoSuccess(image));
      }
    } catch (e) {
      emit(EditAccountError(e.toString()));
    }
  }

  Future<void> _onChangeUserData(ChangeUserData event, Emitter<EditAccountState> emit) async {
    try {
      emit(EditAccountProgress());
      await UserService.changeUserData(displayName: event.displayName, email: event.email);
      emit(EditAccountInitial()); // User data updated successfully
    } catch (e) {
      emit(EditAccountError(e.toString()));
    }
  }
}
