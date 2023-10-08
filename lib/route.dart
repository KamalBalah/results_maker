import 'package:get/get.dart';
import 'package:results_maker/views/home/home_binding.dart';
import 'package:results_maker/views/home/home_view.dart';

class AppPages {
  static const String initial = HomeView.route;
  static const transition = Transition.cupertinoDialog;
  static const duration = Duration(milliseconds: 500);
  static final List<GetPage> allRoutes = [
    GetPage(
      name: HomeView.route,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
