import 'package:craft_cuts_mobile/auth/data/repositories/user_repository_impl.dart';
import 'package:craft_cuts_mobile/auth/domain/usecases/register_user_usecase.dart';
import 'package:craft_cuts_mobile/auth/domain/usecases/signin_usecase.dart';
import 'package:craft_cuts_mobile/auth/presentation/state/auth_notifier.dart';
import 'package:craft_cuts_mobile/booking/data/repositories/barber_repository_impl.dart';
import 'package:craft_cuts_mobile/booking/domain/usecases/fetch_barbers_usecase.dart';
import 'package:craft_cuts_mobile/booking/presentation/state/barber_notifier.dart';
import 'package:craft_cuts_mobile/booking/presentation/state/booking_notifier.dart';
import 'package:craft_cuts_mobile/haircut_demo/data/repositories/haircuts_repository_impl.dart';
import 'package:craft_cuts_mobile/haircut_demo/data/repositories/model_photo_repository_impl.dart';
import 'package:craft_cuts_mobile/haircut_demo/domain/usecase/fetch_haircuts_usecase.dart';
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
  late BookingNotifier _bookingNotifier;
  late BarberNotifier _barberNotifier;

  late RegisterUserUsecase _registerUserUsecase;
  late SignInUsecase _signInUsecase;

  late GetPhotoFromGalleryUseCase _getPhotoFromGalleryUseCase;
  late GetPhotoFromCameraUseCase _getPhotoFromCameraUseCase;
  late FetchHaircutsUseCase _fetchHaircutsUseCase;

  late FetchBarbersUsecase _fetchBarbersUsecase;

  @override
  void initState() {
    final userRepository = UserRepositoryImpl();
    final modelPhotoRepository = ModelPhotoRepositoryImpl();
    final haircutsRepository = HaircutsRepositoryImpl();
    final barberRepository = BarberRepositoryImpl();

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
    _fetchHaircutsUseCase = FetchHaircutsUseCase(haircutsRepository);

    _haircutDemoNotifier = HaircutDemoNotifier(
      _getPhotoFromCameraUseCase,
      _getPhotoFromGalleryUseCase,
      _fetchHaircutsUseCase,
    );
    _haircutDemoNotifier
        .subscribeToModelPhoto(modelPhotoRepository.photoStream);
    _haircutDemoNotifier.subscribeToHaircuts(haircutsRepository.haircutStream);

    _bookingNotifier = BookingNotifier();

    _fetchBarbersUsecase = FetchBarbersUsecase(barberRepository);
    _barberNotifier = BarberNotifier(_fetchBarbersUsecase);
    _barberNotifier.subscribeToBarbers(barberRepository.barbersStream);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _authNotifier),
        ChangeNotifierProvider.value(value: _haircutDemoNotifier),
        ChangeNotifierProvider.value(value: _bookingNotifier),
        ChangeNotifierProvider.value(value: _barberNotifier),
      ],
      child: widget.child,
    );
  }
}
