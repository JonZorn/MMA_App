// // ignore_for_file: cancel_subscriptions

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_app/constants/day_theme.dart';
// import 'package:flutter_app/controllers/auth_controller.dart';
// import 'package:flutter_app/utils/scaler_config.dart';
// import 'package:flutter_app/widgets/click.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'dart:async';

// import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/get_instance.dart';

// class SubscriptionScreen extends StatefulHookWidget {
//   static const String id = 'subscription';

//   @override
//   _InAppState createState() => new _InAppState();
// }

// class _InAppState extends State<SubscriptionScreen> {
//   final AuthController authController = Get.find(tag: 'auth_controller');

//   final ScalerConfig scaler = Get.find(tag: 'scaler');
//   StreamSubscription purchaseUpdatedSubscription;
//   StreamSubscription purchaseErrorSubscription;
//   StreamSubscription _conectionSubscription;
//   final List<String> _productLists = [
//     'com.mmaapp.tempmonthly',
//     'com.mmaapp.tempyearly',
//   ];

//   String _platformVersion = 'Unknown';
//   List<IAPItem> _items = [];
//   List<PurchasedItem> _purchases = [];
//   String selected = "";
//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }

//   @override
//   void dispose() {
//     if (_conectionSubscription != null) {
//       _conectionSubscription.cancel();
//       _conectionSubscription = null;
//       FlutterInappPurchase.instance.finalize();
//     }
//     super.dispose();
//   }

//   Future<void> initPlatformState() async {
//     String platformVersion;

//     var result = await FlutterInappPurchase.instance.initialize();
//     print('result: $result');
//     _getProduct();

//     if (!mounted) return;

//     setState(() {
//       _platformVersion = platformVersion;
//     });

//     try {
//       String msg = await FlutterInappPurchase.instance.consumeAll();
//       print('consumeAllItems: $msg');
//     } catch (err) {
//       print('consumeAllItems error: $err');
//     }

//     _conectionSubscription =
//         FlutterInappPurchase.connectionUpdated.listen((connected) {
//       print('connected: $connected');
//     });

//     purchaseUpdatedSubscription =
//         FlutterInappPurchase.purchaseUpdated.listen((productItem) {
//       print('purchase-updated: $productItem');
//       print("---------");
//       print(productItem.productId);
//       print(productItem.transactionReceipt);
//       print(productItem.purchaseToken);
//       authController.confirmSubscription(
//           productItem.productId,
//           Platform.isAndroid
//               ? productItem.purchaseToken
//               : productItem.transactionReceipt, () {
//         popupDialog(context, text: "Payment Successful", onTap: () {
//           Navigator.of(context).pop();
//         });
//       });
//     });

//     purchaseErrorSubscription =
//         FlutterInappPurchase.purchaseError.listen((purchaseError) {
//       print('purchase-error: $purchaseError');
//     });
//   }

//   Future _getProduct() async {
//     List<IAPItem> items =
//         await FlutterInappPurchase.instance.getSubscriptions(_productLists);
//     for (var item in items) {
//       print('${item.toString()}');
//       this._items.add(item);
//     }

//     setState(() {
//       this._items = items;
//       this._purchases = [];
//     });
//   }

//   Future _getPurchases() async {
//     List<PurchasedItem> items =
//         await FlutterInappPurchase.instance.getAvailablePurchases();
//     for (var item in items) {
//       print('${item.toString()}');
//       this._purchases.add(item);
//     }

//     setState(() {
//       this._items = [];
//       this._purchases = items;
//     });
//   }

//   restorePurchase() async {
//     try {
//       var purchaseHistory =
//           await FlutterInappPurchase.instance.getPurchaseHistory();
//       var lastPurchase = purchaseHistory[0];
//       if (lastPurchase != null) {
//         print(lastPurchase);
//         authController.confirmSubscription(
//             lastPurchase.productId,
//             Platform.isAndroid
//                 ? lastPurchase.purchaseToken
//                 : lastPurchase.transactionReceipt, () {
//           popupDialog(context, text: "Payment Successful", onTap: () {
//             Navigator.of(context).pop();
//           });
//         });
//       }
//     } catch (e) {
//     } finally {}
//   }

//   List<Widget> _renderInApps() {
//     List<Widget> widgets = this
//         ._items
//         .map(
//           (item) => Column(
//             children: [
//               SizedBox(
//                 height: scaler.scalerV(53.0),
//                 child: Card(
//                   elevation: 15,
//                   shadowColor: Color(0xFFFFD5D5),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Padding(
//                         padding:
//                             EdgeInsets.fromLTRB(scaler.scalerH(15.0), 0, 0, 0),
//                         child: Text(item.description,
//                             style: textStyle(
//                                 fontSize: scaler.scalerT(14.0),
//                                 color: DayTheme.textColor)),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(
//                             scaler.scalerH(27.0), 0, scaler.scalerH(60.0), 0),
//                         child: Text(item.localizedPrice,
//                             style: textStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: scaler.scalerT(16.0),
//                                 color: DayTheme.primaryColor)),
//                       ),
//                       Radio(
//                           activeColor: DayTheme.primaryColor,
//                           value: item.productId,
//                           groupValue: selected,
//                           onChanged: (_value) {
//                             setState(() {
//                               selected = _value;
//                             });
//                             print(_value);
//                           }),
//                       SizedBox(
//                         height: scaler.scalerV(30.0),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: scaler.scalerV(20.0),
//               ),
//             ],
//           ),
//         )
//         .toList();
//     return widgets;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: header(context, text: "Subscription"),
//       body: Container(
//         margin: EdgeInsets.symmetric(horizontal: scaler.scalerH(25.0)),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: scaler.scalerV(30.0),
//               ),
//               Column(
//                 children: this._renderInApps(),
//               ),
//               SizedBox(
//                 height: scaler.scalerV(40.0),
//               ),
//               Text(
//                 "With a monthly or yearly subscription, you can have uninterrupted premium access to all app features so that you can practice MMA. Remember, you can cancel your subscription any time and use of our free complimentary premium access when someone you refer sign up.",
//                 style: textStyle(
//                     height: scaler.scalerV(1.5),
//                     fontSize: scaler.scalerT(17.0),
//                     color: DayTheme.textColor),
//               ),
//               SizedBox(
//                 height: scaler.scalerV(50.0),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: scaler.scalerH(20.0)),
//                 child: Click(
//                     text: 'PROCEED',
//                     disabled: selected == '',
//                     onPressed: () {
//                       // fullScreenLoader(context);
//                       FlutterInappPurchase.instance
//                           .requestSubscription(selected);
//                     }),
//               ),
//               SizedBox(
//                 height: scaler.scalerV(25.0),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: scaler.scalerH(20.0)),
//                 child: Click(
//                   text: 'RESTORE SUBSCRIPTION',
//                   // disabled: group.value == null,
//                   onPressed: restorePurchase,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
