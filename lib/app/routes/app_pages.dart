import 'package:fresensi/app/modules/account/new_password/bindings/new_password_binding.dart';
import 'package:fresensi/app/modules/account/new_password/views/new_password_view.dart';
import 'package:get/get.dart';

import '../modules/account/login/bindings/login_binding.dart';
import '../modules/account/login/views/login_view.dart';
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
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => const NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EMPLOYEE,
      page: () => const AddEmployeeView(),
      binding: AddEmployeeBinding(),
    ),
  ];
}
