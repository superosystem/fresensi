import 'package:get/get.dart';

import '../modules/account/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/account/forgot_password/views/forgot_password_view.dart';
import '../modules/account/login/bindings/login_binding.dart';
import '../modules/account/login/views/login_view.dart';
import '../modules/account/new_password/bindings/new_password_binding.dart';
import '../modules/account/new_password/views/new_password_view.dart';
import '../modules/account/profile/bindings/profile_binding.dart';
import '../modules/account/profile/views/profile_view.dart';
import '../modules/account/update_password/bindings/update_password_binding.dart';
import '../modules/account/update_password/views/update_password_view.dart';
import '../modules/account/update_profile/bindings/update_profile_binding.dart';
import '../modules/account/update_profile/views/update_profile_view.dart';
import '../modules/employee/add_employee/bindings/add_employee_binding.dart';
import '../modules/employee/add_employee/views/add_employee_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => const NewPasswordView(),
      binding: NewPasswordBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      binding: UpdateProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.UPDATE_PASSWORD,
      page: () => const UpdatePasswordView(),
      binding: UpdatePasswordBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADD_EMPLOYEE,
      page: () => const AddEmployeeView(),
      binding: AddEmployeeBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
