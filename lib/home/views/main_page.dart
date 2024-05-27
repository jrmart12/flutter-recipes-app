import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recipes_app/router/app_router.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        HomeRoute(),
        CategoriesRoute(),
        FavoritesRoute(),
        SearchRoute(),
        ProfileRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (value) {
              tabsRouter.setActiveIndex(value);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
            backgroundColor: Color.fromRGBO(
                89, 126, 247, 1.000), // Change the background color
            selectedItemColor:
                Colors.white, // Change the color of the selected item
            unselectedItemColor: Color.fromARGB(
                255, 202, 202, 202), // Change the color of the unselected items
            type: BottomNavigationBarType
                .fixed, // Use fixed type for consistent item spacing
            showUnselectedLabels: true,
          ),
        );
      },
    );
  }
}
