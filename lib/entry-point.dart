// import 'package:flutter/material.dart';
// import 'package:rive/rive.dart';
// import 'package:smart_fridge/custom_drawer/rive_icon_controller.dart';
// import 'package:smart_fridge/src/app_theme.dart';

// class EntryPoint extends StatefulWidget {
//   const EntryPoint({super.key});

//   @override
//   State<EntryPoint> createState() => _EntryPointState();
// }

// class _EntryPointState extends State<EntryPoint> {
//   late SMIBool searchTrigger;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.background,
//       bottomNavigationBar: SafeArea(
//         child: Container(
//           padding: EdgeInsets.all(12),
//           margin: EdgeInsets.symmetric(horizontal: 50),
//           decoration: BoxDecoration(
//             color: AppTheme.grey,
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//           ),
//           child: Row(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   searchTrigger.change(true);
//                 },
//                 child: SizedBox(
//                   height: 36,
//                   width: 36,
//                   child: RiveAnimation.asset(
//                     "assets/images/icons/rive/icons.riv",
//                     artboard: "HOME",
//                     onInit: (artboard) {
//                       StateMachineController controller =
//                           RiveIconController.getRiveController(artboard,
//                               stateMachineName: "HOME");
//                       searchTrigger = controller.findSMI("active") as SMIBool;
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
