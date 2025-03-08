import 'package:builders_group/src/app/features/dashboard/dashboard_view.dart';
import 'package:builders_group/src/app/features/landing/landing_screen.dart';
import 'package:builders_group/src/app/features/notifications/visitor_notification_view.dart';
import 'package:builders_group/src/app/routes/app_route_name.dart';
import 'package:builders_group/src/l10n/app_localizations.dart';
import 'package:builders_group/src/settings/setting_controller.dart';
import 'package:builders_group/src/shared/services/shared_preferences_service.dart';
import 'package:builders_group/src/shared/widgets/language_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppScaffold extends StatefulWidget {
  final int? index;
  const AppScaffold({super.key, this.index});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold>
    with TickerProviderStateMixin {
  final SearchController controller = SearchController();

  final List<Widget> pages = [
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  int _selectedIndex = 0;

  late final AnimationController _slideAnimationController =
      AnimationController(
        duration: const Duration(milliseconds: 120),
        vsync: this,
      );
  late Animation<Offset> _pagePosition;

  final SharedPreferencesService preferencesService =
      SharedPreferencesService();

  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _initPageAnimation();
    if (widget.index != null) {
      _selectedIndex = widget.index!;
    }
    _selectMenu(_selectedIndex, init: true);
  }

  void _initPageAnimation() {
    _pagePosition = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(_slideAnimationController);
  }

  @override
  void dispose() {
    _slideAnimationController.dispose();
    super.dispose();
  }

  void _selectMenu(int index, {bool init = false}) async {
    bool value = (await preferencesService.getString('JWT_TOKEN')).isNotEmpty;
    setState(() {
      isLoggedIn = value;
    });

    if (index != _selectedIndex || init) {
      Widget page = isLoggedIn ? Dashboard() : LandingScreen();
      if (isLoggedIn) {
        switch (index) {
          case 0:
            page = Dashboard();
            break;
          case 1:
            page = const LandingScreen();
            break;
          case 2:
            page = VisitorNotification();
            break;
          case 3:
            page = Center(child: Text('Welcome'));
            break;
        }
      }
      _animatePage(page, index);
    }
  }

  _animatePage(Widget page, int index) {
    _slideAnimationController.reverse().then((_) {
      setState(() {
        _selectedIndex = index;
        pages[index] = page;
        _slideAnimationController.forward();
      });
    });
  }

  bool _onPagePop() {
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return false;
    }
    return true;
  }

  showBottomSheet() {
    // CommonFunctions.modalBottomSheet(
    //   context,
    //   LocationSearch(
    //     onLocationSelected: (location) {
    //       CommonFunctions.closeBottomSheet(context);
    //     },
    //   ),
    //   'Select a Location',
    // );
  }

  // _redirectToSettings() {
  //   Navigator.of(context).pushNamed(AppRouteName.settings);
  // }

  @override
  Widget build(BuildContext context) {
    return _buildScaffold();
  }

  Widget _buildScaffold() {
    Size size = MediaQuery.of(context).size;
    SettingsController settingsController = Provider.of<SettingsController>(
      context,
    );
    return Scaffold(
      appBar: _selectedIndex != 2 ?_buildAppbar(settingsController) : null,
      body: _buildBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: isLoggedIn ? _buildBottomNavigation() : null,
      floatingActionButton: !isLoggedIn ? _buildFloatingButton(size) : null,
    );
  }

  _buildBody() {
    return PopScope(
      canPop: _selectedIndex == 0,
      onPopInvokedWithResult: (didPop, result) => _onPagePop(),
      child: SlideTransition(
        position: _pagePosition,
        child: IndexedStack(index: _selectedIndex, children: pages),
      ),
    );
  }

  _buildAppbar(settingsController) {
    return AppBar(
      title: Text(AppLocalizations.of(context).translate('title')),
      primary: true,
      titleSpacing: 16,
      actionsPadding: EdgeInsets.only(right: 16),
      actions: [
        IconButton(
          onPressed: () {
            settingsController.updateThemeData(!settingsController.isDarkTheme);
          },
          icon: Icon(
            settingsController.isDarkTheme ? Icons.light_mode : Icons.dark_mode,
          ),
        ),
        LanguageSelector(dropdown: false),
        SizedBox(width: 8),
        if (isLoggedIn)
          CircleAvatar(child: Icon(Icons.account_circle_outlined)),
      ],
    );
  }

  _buildBottomNavigation() {
    return NavigationBar(
      // onDestinationSelected: (index) {
      //   if (index == 2) {
      //     NotificationService.showCallNotification();
      //     Navigator.pushNamed(context, AppRouteName.visitorNotification);
      //   }
      //   if (index == 3) {
      //     Navigator.pushNamedAndRemoveUntil(
      //       context,
      //       AppRouteName.home,
      //       (route) => false,
      //     );
      //   }
      // },
      onDestinationSelected: _selectMenu,
      selectedIndex: _selectedIndex,
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.dashboard_outlined),
          label: AppLocalizations.of(context).translate("dashboard"),
        ),
        NavigationDestination(
          icon: Icon(Icons.search_outlined),
          label: AppLocalizations.of(context).translate("search"),
        ),
        NavigationDestination(
          icon: Icon(Icons.notifications_none_outlined),
          label: AppLocalizations.of(context).translate("notifications"),
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          label: AppLocalizations.of(context).translate("settings"),
        ),
      ],
    );
  }

  _buildFloatingButton(size) {
    return SizedBox(
      width: size.width - 32,
      child: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRouteName.login);
        },
        elevation: 4,
        icon: Icon(Icons.login),
        label: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Text(
            AppLocalizations.of(context).translate('login'),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
