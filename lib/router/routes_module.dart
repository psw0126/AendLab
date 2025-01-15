
import 'package:aendlab/view/barcode.dart';
import 'package:aendlab/view/box_update.dart';
import 'package:aendlab/view/buy.dart';
import 'package:aendlab/view/cash_buy.dart';
import 'package:aendlab/view/cash_return.dart';
import 'package:aendlab/view/check.dart';
import 'package:aendlab/view/check/barcode_check.dart';
import 'package:aendlab/view/check/cash_buy_check.dart';
import 'package:aendlab/view/check/cash_return_check.dart';
import 'package:aendlab/view/check/credit_check.dart';
import 'package:aendlab/view/check/credit_return_check.dart';
import 'package:aendlab/view/check/event_check.dart';
import 'package:aendlab/view/check/inventory_check.dart';
import 'package:aendlab/view/check/order_check.dart';
import 'package:aendlab/view/check/storage_in_check.dart';
import 'package:aendlab/view/check/storage_out_check.dart';
import 'package:aendlab/view/check/store_buy_check.dart';
import 'package:aendlab/view/check/store_point_check.dart';
import 'package:aendlab/view/common_update.dart';
import 'package:aendlab/view/confirm/checkconfirm.dart';
import 'package:aendlab/view/credit_return.dart';
import 'package:aendlab/view/enter/barcode_enter.dart';
import 'package:aendlab/view/enter/cash_buy_enter.dart';
import 'package:aendlab/view/enter/cash_return_enter.dart';
import 'package:aendlab/view/enter/credit_enter.dart';
import 'package:aendlab/view/enter/credit_return_enter.dart';
import 'package:aendlab/view/enter/event_enter.dart';
import 'package:aendlab/view/enter/inventory_enter.dart';
import 'package:aendlab/view/enter/order_enter.dart';
import 'package:aendlab/view/enter/sales_insert_enter.dart';
import 'package:aendlab/view/enter/sales_insert_return.dart';
import 'package:aendlab/view/enter/storage_in_enter.dart';
import 'package:aendlab/view/enter/storage_out_enter.dart';
import 'package:aendlab/view/enter/store_buy_enter.dart';
import 'package:aendlab/view/enter/store_point_enter.dart';
import 'package:aendlab/view/etc.dart';
import 'package:aendlab/view/event.dart';
import 'package:aendlab/view/input/cash_buy_input.dart';
import 'package:aendlab/view/input/cash_return_input.dart';
import 'package:aendlab/view/input/credit_input.dart';
import 'package:aendlab/view/input/credit_return_input.dart';
import 'package:aendlab/view/input/order_input.dart';
import 'package:aendlab/view/input/store_buy_input.dart';
import 'package:aendlab/view/input/store_point_input.dart';
import 'package:aendlab/view/inventory.dart';
import 'package:aendlab/view/product_update.dart';
import 'package:aendlab/view/sales_insert.dart';
import 'package:aendlab/view/sales_retrun.dart';
import 'package:aendlab/view/splash.dart';
import 'package:aendlab/view/storage_in.dart';
import 'package:aendlab/view/storage_out.dart';
import 'package:aendlab/view/store_buy.dart';
import 'package:aendlab/view/store_point.dart';
import 'package:aendlab/view/transaction/cash_return_trans.dart';
import 'package:aendlab/view/transaction/cash_trans.dart';
import 'package:aendlab/view/transaction/credit_return_trans.dart';
import 'package:aendlab/view/transaction/credit_trans.dart';
import 'package:aendlab/view/transaction/order_trans.dart';
import 'package:aendlab/view/transaction/store_return_trans.dart';
import 'package:aendlab/view/transaction/store_trans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/credit.dart';
import '../view/home.dart';
import '../view/login.dart';
import '../view/order.dart';
import '../view/transaction/inven_trans.dart';
import '../view/web_browser.dart';



class RoutesModule extends Module {
  @override
  List<ModularRoute> routes = [
    ModuleRoute('/', module: BasicRouteModule(), transition: TransitionType.noTransition),
  ];

}



class BasicRouteModule extends Module {
  @override
  final List<ModularRoute>  routes = [
    // ChildRoute(RouteMap.WEB_BROWSER.page, child: (_, args) => WebBrowserCommunityPage(args: args.data)),
    ChildRoute(RouteMap.SPLASH.page, child: (_, args) => SplashPage()),
    ChildRoute(RouteMap.LOGIN.page, child: (_, args) => LoginPage()), //로그인
    ChildRoute(RouteMap.HOME.page, child: (_, args) => HomePage()), //메인
    ChildRoute(RouteMap.BUY.page, child: (_, args) => BuyPage()), //매입 메뉴
    ChildRoute(RouteMap.CREDIT.page, child: (_, args) => CreditPage(CreditType: 'A')), //외상매입 메뉴
    ChildRoute(RouteMap.CREDIT_INPUT.page, child: (_, args) => CreditInputPage()),
    ChildRoute(RouteMap.CREDITENTER.page, child: (_, args) => CreditEnterPage()), //외상매입 입력 메뉴
    ChildRoute(RouteMap.CREDITECHECK.page, child: (_, args) => CreditCheckPage()), //외상매입 조회 메뉴
    ChildRoute(RouteMap.CREDIT_RETURN.page, child: (_, args) => CreditReturnPage(CreditReturnType: 'B')), //외상반품 메뉴
    ChildRoute(RouteMap.CREDIT_RETRUN_INPUT.page, child: (_, args) => CreditRetrunInputPage()),
    ChildRoute(RouteMap.CREDIT_RETURN_ENTER.page, child: (_, args) => CreditReturnEnterPage()), //외상반품 입력
    ChildRoute(RouteMap.CREDIT_RETURN_CHECK.page, child: (_, args) => CreditReturnCheckPage()), //외상반품 조회
    ChildRoute(RouteMap.CASH_BUY.page, child: (_, args) => CashBuyPage(CashBuyType: 'C')),//현금매입 메뉴
    ChildRoute(RouteMap.CASH_BUY_ENTER.page, child: (_, args) => CashBuyEnterPage()), //현금매입 입력
    ChildRoute(RouteMap.CASH_BUY_CHECK.page, child: (_, args) => CashBuyCheckPage()), //현금매입 조회
    ChildRoute(RouteMap.CASH_BUY_INPUT.page, child: (_, args) => CashBuyInputPage()),
    ChildRoute(RouteMap.CASH_RETURN.page, child: (_, args) => CashReturnPage(CashReturnType: 'D')),//현금반품 메뉴
    ChildRoute(RouteMap.CASH_RETURN_INPUT.page, child: (_, args) => CashReturnInputPage()),
    ChildRoute(RouteMap.CASH_RETURN_ENTER.page, child: (_, args) => CashReturnEnterPage()), //현금반품 입력
    ChildRoute(RouteMap.CASH_RETURN_CHECK.page, child: (_, args) => CashReturnCheckPage()), //현금반품 조회
    ChildRoute(RouteMap.STORE_BUY.page, child: (_, args) => StoreBuyPage(StoreBuyType: 'E')), //점간매입 메뉴
    ChildRoute(RouteMap.STORE_BUY_ENTER.page, child: (_, args) => StoreBuyEnterPage()), //점간매입 입력
    ChildRoute(RouteMap.STORE_BUY_CHECK.page, child: (_, args) => StoreBuyCheckPage()), //점간매입 조회
    ChildRoute(RouteMap.STORE_BUY_INPUT.page, child: (_, args) => StoreBuyInputPage()),
    ChildRoute(RouteMap.STORE_POINT.page, child: (_, args) => StorePointPage(StorePointType: 'F')), //점간이동 메뉴
    ChildRoute(RouteMap.STORE_POINT_ENTER.page, child: (_, args) => StorePointEnterPage()), //점간이동 입력
    ChildRoute(RouteMap.STORE_POINT_CHECK.page, child: (_, args) => StorePointCheckPage()), //점간이동 조회
    ChildRoute(RouteMap.STORE_POINT_INPUT.page, child: (_, args) => StorePointInputPage()),
    ChildRoute(RouteMap.INVENTORY.page, child: (_, args) => InventoryPage(InventoryType: 'I')), //재고 메뉴
    ChildRoute(RouteMap.INVENTORYCHECK.page, child: (_, args) => InventoryCheckPage()), //재고 조회
    ChildRoute(RouteMap.INVENTORYENTER.page, child: (_, args) => InventoryEnterPage()), //재고 입력
    ChildRoute(RouteMap.INVEN_TRANSACTION.page, child: (_, args) => InvenTransPage()),
    ChildRoute(RouteMap.ORDER.page, child: (_, args) => OrderPage(OrderType: 'O',)), //발주 메뉴
    ChildRoute(RouteMap.ORDERENTER.page, child: (_, args) => OrderEnterPage()), //발주 입력 메뉴
    ChildRoute(RouteMap.ORDERCHECK.page, child: (_, args) => OrderCheckPage()), //발주 조회 메뉴
    ChildRoute(RouteMap.ORDERINPUT.page, child: (_, args) => OrderInputPage()),
    ChildRoute(RouteMap.CHECK.page, child:  (_, args) => CheckPage()), //조회 메뉴
    ChildRoute(RouteMap.CHECK_CONFIRM.page, child: (_, args) => CheckConfirmPage()), //조회 버튼
    ChildRoute(RouteMap.PRODUCT_UPDATE.page, child: (_, args) => ProductUpdatePage()), //상품 수정 메뉴
    ChildRoute(RouteMap.COMMON_UPDATE.page, child: (_, args) => CommonUpdatePage(CommonUpdateType: 'P',)), //일반상품 수정 메뉴
    ChildRoute(RouteMap.BOX_UPDATE.page, child: (_, args) => BoxUpdatePage(BoxUpdateType: 'Q',)), //박스상품 수정 메뉴
    ChildRoute(RouteMap.ETC.page, child: (_, args) => EtcPage()), //기타 메뉴
    ChildRoute(RouteMap.EVENT.page, child: (_, args) => EventPage(EventType: 'K',)), //행사 메뉴
    ChildRoute(RouteMap.EVENT_ENTER.page, child: (_, args) => EventEnterPage()), //행사 입력
    ChildRoute(RouteMap.EVENT_CHECK.page, child: (_, args) => EventCheckPage()), //행사 조회
    ChildRoute(RouteMap.BARCODE.page, child: (_, args) => BarcodePage(BarcodeType: 'J',)), //바코드 메뉴
    ChildRoute(RouteMap.BARCODE_ENTER.page, child: (_, args) => BarcodeEnterPage()), //바코드 입력
    ChildRoute(RouteMap.BARCODE_CHECK.page, child: (_, args) => BarcodeCheckPage()), //바코드 조회
    ChildRoute(RouteMap.STORAGE_IN.page, child: (_, args) => StorageInPage(StorageInType: 'G',)), //창고입고 메뉴
    ChildRoute(RouteMap.STORAGE_IN_ENTER.page, child: (_, args) => StorageInEnterPage()), //창고입고 입력
    ChildRoute(RouteMap.STORAGE_IN_CHECK.page, child: (_, args) => StorageInCheckPage()), //창고입고 조회
    ChildRoute(RouteMap.STORAGE_OUT.page, child: (_, args) => StorageOutPage(StorageOutType: 'H',)), //창고출고 메뉴
    ChildRoute(RouteMap.STORAGE_OUT_ENTER.page, child: (_, args) => StorageOutEnterPage()), //창고출고 입력
    ChildRoute(RouteMap.STORAGE_OUT_CHECK.page, child: (_, args) => StorageOutCheckPage()), //창고출고 조회
    ChildRoute(RouteMap.SALES_INSERT.page, child: (_, args) => SalesInsertPage()), //매출등록
    ChildRoute(RouteMap.SALES_INSERT_ENTER.page, child: (_, args) => SalesInsertEnterPage(SalesInsertType: 'L',)),
    ChildRoute(RouteMap.SALES_INSERT_RETURN.page, child: (_, args) => SalesInsertReturnPage(SalesReturnType: 'M',)),
    ChildRoute(RouteMap.SALES_RETURN.page, child: (_, args) => SalesReturnPage()), //매출반품
    ChildRoute(RouteMap.CREDIT_TRANSACTION.page, child: (_, args) => CreditTransPage()),
    ChildRoute(RouteMap.CREDIT_RETRUN_TRANSACTION.page, child: (_, args) => CreditReturnTransPage()),
    ChildRoute(RouteMap.CASH_TRANSACTION.page, child: (_, args) => CashTransPage()),
    ChildRoute(RouteMap.CASH_RETRUN_TRANSACTION.page, child: (_, args) => CashReturnTransPage()),
    ChildRoute(RouteMap.STORE_TRANSACTION.page, child: (_, args) => StoreTransPage()),
    ChildRoute(RouteMap.STORE_RETRUN_TRANSACTION.page, child: (_, args) => StoreReturnTransPage()),
    ChildRoute(RouteMap.ORDER_TRANSACTION.page, child: (_, args) => OrderTransPage()),
  ];
}

enum RouteMap {
  WEB_BROWSER,
  SPLASH,
  LOGIN,
  HOME,
  BUY,
  CREDIT,
  CREDIT_INPUT,
  CREDIT_TRANSACTION,
  CREDIT_RETRUN_TRANSACTION,
  CREDIT_RETURN,
  CREDIT_RETRUN_INPUT,
  CREDIT_RETURN_ENTER,
  CREDIT_RETURN_CHECK,
  CREDITENTER,
  CREDITECHECK,
  CASH_BUY,
  CASH_BUY_ENTER,
  CASH_BUY_CHECK,
  CASH_BUY_INPUT,
  CASH_RETURN,
  CASH_RETURN_INPUT,
  CASH_RETURN_ENTER,
  CASH_RETURN_CHECK,
  CASH_TRANSACTION,
  CASH_RETRUN_TRANSACTION,
  STORE_BUY,
  STORE_BUY_ENTER,
  STORE_BUY_CHECK,
  STORE_BUY_INPUT,
  STORE_POINT,
  STORE_POINT_ENTER,
  STORE_POINT_CHECK,
  STORE_POINT_INPUT,
  STORE_TRANSACTION,
  STORE_RETRUN_TRANSACTION,
  INVENTORY,
  INVENTORYCHECK,
  INVENTORYENTER,
  INVEN_TRANSACTION,
  ORDER_TRANSACTION,
  ORDER,
  ORDERENTER,
  ORDERCHECK,
  ORDERINPUT,
  CHECK,
  CHECK_CONFIRM,
  PRODUCT_UPDATE,
  COMMON_UPDATE,
  BOX_UPDATE,
  ETC,
  EVENT,
  EVENT_ENTER,
  EVENT_CHECK,
  BARCODE,
  BARCODE_ENTER,
  BARCODE_CHECK,
  STORAGE_IN,
  STORAGE_IN_ENTER,
  STORAGE_IN_CHECK,
  STORAGE_OUT,
  STORAGE_OUT_CHECK,
  STORAGE_OUT_ENTER,
  SALES_INSERT,
  SALES_INSERT_ENTER,
  SALES_INSERT_RETURN,
  SALES_RETURN,
}
extension RouteMapExtension on RouteMap {
  String get page {
    switch (this) {
      case RouteMap.WEB_BROWSER:
        return '/webbrowser';
      case RouteMap.SPLASH:
        return '/';
      case RouteMap.LOGIN:
        return '/login';
      case RouteMap.HOME:
        return '/home';
      case RouteMap.BUY:
        return '/buy';
      case RouteMap.CREDIT:
        return '/credit';
      case RouteMap.CREDIT_INPUT:
        return '/credit/input';
      case RouteMap.CREDIT_TRANSACTION:
        return '/credit/transaction';
      case RouteMap.CREDIT_RETRUN_TRANSACTION:
        return '/credit/return/transaction';
      case RouteMap.CREDIT_RETURN:
        return '/credit/return';
      case RouteMap.CREDIT_RETRUN_INPUT:
        return '/credit/return/input';
      case RouteMap.CREDIT_RETURN_ENTER:
        return '/credit/return/enter';
      case RouteMap.CREDIT_RETURN_CHECK:
        return '/credit/return/check';
      case RouteMap.CREDITENTER:
        return '/credit/enter';
      case RouteMap.CREDITECHECK:
        return '/credit/check';
      case RouteMap.CASH_BUY:
        return '/cashbuy';
      case RouteMap.CASH_TRANSACTION:
        return '/cash/transaction';
      case RouteMap.CASH_RETRUN_TRANSACTION:
        return '/cash/return/transaction';
      case RouteMap.CASH_BUY_ENTER:
        return '/cashbuy/enter';
      case RouteMap.CASH_BUY_CHECK:
        return '/cashbuy/check';
      case RouteMap.CASH_BUY_INPUT:
        return '/cashbuy/input';
      case RouteMap.CASH_RETURN:
        return '/cashreturn';
      case RouteMap.CASH_RETURN_INPUT:
        return '/cashreturn/input';
      case RouteMap.CASH_RETURN_ENTER:
        return '/cashreturn/enter';
      case RouteMap.CASH_RETURN_CHECK:
        return '/cashreturn/check';
      case RouteMap.STORE_TRANSACTION:
        return '/store/transaction';
      case RouteMap.STORE_RETRUN_TRANSACTION:
        return '/store/return/transaction';
      case RouteMap.STORE_BUY:
        return '/storebuy';
      case RouteMap.STORE_BUY_ENTER:
        return '/storebuy/enter';
      case RouteMap.STORE_BUY_CHECK:
        return '/storebuy/check';
      case RouteMap.STORE_BUY_INPUT:
        return '/storebuy/input';
      case RouteMap.STORE_POINT:
        return '/storepoint';
      case RouteMap.STORE_POINT_ENTER:
        return '/storepoint/enter';
      case RouteMap.STORE_POINT_CHECK:
        return '/storepoint/check';
      case RouteMap.STORE_POINT_INPUT:
        return '/storepoint/input';
      case RouteMap.INVENTORY:
        return '/inventory';
      case RouteMap.INVENTORYENTER:
        return '/inventory/enter';
      case RouteMap.INVENTORYCHECK:
        return '/inventory/check';
      case RouteMap.INVEN_TRANSACTION:
        return '/inventory/transaction';
      case RouteMap.ORDER_TRANSACTION:
        return '/order/transaction';
      case RouteMap.ORDER:
        return '/order';
      case RouteMap.ORDERENTER:
        return '/order/enter';
      case RouteMap.ORDERCHECK:
        return '/order/check';
      case RouteMap.ORDERINPUT:
        return '/order/input';
      case RouteMap.CHECK:
        return '/check';
      case RouteMap.CHECK_CONFIRM:
        return '/check/confirm';
      case RouteMap.PRODUCT_UPDATE:
        return '/update';
      case RouteMap.COMMON_UPDATE:
        return '/update/common';
      case RouteMap.BOX_UPDATE:
        return '/update/box';
      case RouteMap.ETC:
        return '/etc';
      case RouteMap.EVENT:
        return '/event';
      case RouteMap.EVENT_ENTER:
        return '/event/enter';
      case RouteMap.EVENT_CHECK:
        return '/event/check';
      case RouteMap.BARCODE:
        return '/barcode';
      case RouteMap.BARCODE_ENTER:
        return '/barcode/enter';
      case RouteMap.BARCODE_CHECK:
        return '/barcode/check';
      case RouteMap.STORAGE_IN:
        return '/storagein';
      case RouteMap.STORAGE_IN_ENTER:
        return '/storagein/enter';
      case RouteMap.STORAGE_IN_CHECK:
        return '/storagein/check';
      case RouteMap.STORAGE_OUT:
        return '/storageout';
      case RouteMap.STORAGE_OUT_ENTER:
        return '/storageout/enter';
      case RouteMap.STORAGE_OUT_CHECK:
        return '/storageout/check';
      case RouteMap.SALES_INSERT:
        return '/salesinsert';
      case RouteMap.SALES_INSERT_ENTER:
        return '/salesinsert/enter';
      case RouteMap.SALES_INSERT_RETURN:
        return '/salesinsert/return';
      case RouteMap.SALES_RETURN:
        return '/salesreturn';
    }
  }
}
