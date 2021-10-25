import 'package:craft_cuts_mobile/auth/data/repositories/user_repository_impl.dart';
import 'package:craft_cuts_mobile/auth/domain/repositories/user_repository.dart';
import 'package:craft_cuts_mobile/auth/domain/usecases/register_user_usecase.dart';
import 'package:craft_cuts_mobile/auth/domain/usecases/signin_usecase.dart';
import 'package:craft_cuts_mobile/auth/presentation/state/auth_notifier.dart';
import 'package:craft_cuts_mobile/haircut_demo/data/repositories/model_photo_repository_impl.dart';
import 'package:craft_cuts_mobile/haircut_demo/domain/repositories/model_photo_repository.dart';
import 'package:craft_cuts_mobile/haircut_demo/domain/usecase/get_photo_from_camera_usecase.dart';
import 'package:craft_cuts_mobile/haircut_demo/domain/usecase/get_photo_from_gallery_usecase.dart';
import 'package:craft_cuts_mobile/haircut_demo/presentation/state/haircut_demo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InjectionContainer extends StatefulWidget {
  final Widget child;

  const InjectionContainer({Key? key, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InjectionContainerState();
}

class _InjectionContainerState extends State<InjectionContainer> {
  late AuthNotifier _authNotifier;
  late HaircutDemoNotifier _haircutDemoNotifier;

  late RegisterUserUsecase _registerUserUsecase;
  late SignInUsecase _signInUsecase;

  late GetPhotoFromGalleryUseCase _getPhotoFromGalleryUseCase;
  late GetPhotoFromCameraUseCase _getPhotoFromCameraUseCase;

  @override
  void initState() {
    UserRepository userRepository = UserRepositoryImpl();
    ModelPhotoRepository modelPhotoRepository = ModelPhotoRepositoryImpl();

    _registerUserUsecase = RegisterUserUsecase(userRepository);
    _signInUsecase = SignInUsecase(userRepository);
    _authNotifier = AuthNotifier(
      _registerUserUsecase,
      _signInUsecase,
    );
    _authNotifier.subscribeToAuthUpdates(userRepository.currentUser);

    _getPhotoFromCameraUseCase =
        GetPhotoFromCameraUseCase(modelPhotoRepository);
    _getPhotoFromGalleryUseCase =
        GetPhotoFromGalleryUseCase(modelPhotoRepository);
    _haircutDemoNotifier = HaircutDemoNotifier(
      _getPhotoFromCameraUseCase,
      _getPhotoFromGalleryUseCase,
    );
    _haircutDemoNotifier
        .subscribeToModelPhoto(modelPhotoRepository.photoStream);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _authNotifier),
        ChangeNotifierProvider.value(value: _haircutDemoNotifier),
      ],
      child: widget.child,
    );
  }
}
