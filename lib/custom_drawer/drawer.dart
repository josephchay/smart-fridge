import 'package:flutter/material.dart';
import 'package:smart_fridge/custom_drawer/drawer_info_card.dart';
import 'package:smart_fridge/custom_drawer/drawer_plate.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';
import 'package:smart_fridge/src/models/drawer_icon.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    super.key,
  });

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  AppDrawerIcon selectedTab = drawerTopTabIcons.first;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.nearlyOrange.withOpacity(0.9),
              AppTheme.nearlyTiger,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: AppDrawerInfoCard(
                  brand: 'SMART FRIDGE',
                  slogan: "Your new kitchen experience.",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  top: 32,
                  bottom: 16,
                ),
                child: Text(
                  'BROWSE',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white60,
                      ),
                ),
              ),
              ...drawerTopTabIcons.map((tab) => AppDrawerPlate(
                    isLightMode: isLightMode,
                    tab: tab,
                    // iconOnInit: (artboard) {
                    //   rive.StateMachineController controller =
                    //       RiveIconController.getRiveController(artboard,
                    //           stateMachineName: tab.stateMachineName);
                    //   tab.input = controller.findSMI("active") as rive.SMIBool;
                    // },
                    press: () {
                      // tab.input!.change(true);
                      // Future.delayed(const Duration(milliseconds: 800), () {
                      //   tab.input!.change(false);
                      // });
                      setState(() {
                        selectedTab = tab;
                      });
                    },
                    isActive: selectedTab == tab,
                  )),
              Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  top: 32,
                  bottom: 16,
                ),
                child: Text(
                  "PERSONALIZATION",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white60,
                      ),
                ),
              ),
              ...drawerBottomTabIcons.map(
                (tab) => AppDrawerPlate(
                  isLightMode: isLightMode,
                  tab: tab,
                  // iconOnInit: (artboard) {
                  //   rive.StateMachineController controller =
                  //       RiveIconController.getRiveController(
                  //     artboard,
                  //     stateMachineName: tab.stateMachineName,
                  //   );
                  //   tab.input = controller.findSMI("active") as rive.SMIBool;
                  // },
                  press: () {
                    // tab.input!.change(true);
                    // Future.delayed(const Duration(milliseconds: 800), () {
                    //   tab.input!.change(false);
                    // });

                    setState(() {
                      selectedTab = tab;
                    });
                  },
                  isActive: selectedTab == tab,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
