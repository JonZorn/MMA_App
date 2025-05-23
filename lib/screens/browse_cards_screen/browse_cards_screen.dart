import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/models/category_browse.dart';
import 'package:flutter_app/screens/card_front_screen/card_fronts_screen.dart';
import 'package:flutter_app/utils/network_client.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BrowseCardScreen extends HookWidget {
  static const String id = 'cards';

  @override
  Widget build(BuildContext context) {
    dynamic arg = ModalRoute.of(context)!.settings.arguments;

    final browseList = useState<List<dynamic>>([]);

    final categoriesLoading = useState<bool>(true);

    useEffect(() {
      (() async {
        try {
          final response = await NetworkClient.get(
              arg['Smart Mix'] == 'Smart Mix'
                  ? '/global/browse'
                  : '/category/browse?category=${arg['id']}');
          List<dynamic> browseLists = response.data['data'];
          browseList.value = browseLists.map((browse) {
            return CategoryBrowse.fromJson(browse);
          }).toList();
        } on DioError catch (e) {
          NetworkClient.errorHandler(e);
        } finally {
          categoriesLoading.value = false;
        }
      })();
      return () {};
    }, []);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: header(
          context,
          text: arg['Smart Mix'] == 'Smart Mix'
              ? arg['Smart Mix']
              : arg['categoryname'],
        ),
        body: categoriesLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : (browseList.value.length != 0)
                ? Container(
                    margin: EdgeInsets.only(
                        left: scaler.scalerH(25.0),
                        right: scaler.scalerH(25.0),
                        top: scaler.scalerV(20.0),
                        bottom: scaler.scalerV(20.0)),
                    child: ListView.builder(
                        itemCount: browseList.value.length,
                        itemBuilder: (context, int index) {
                          return Padding(
                            padding:
                                EdgeInsets.only(bottom: scaler.scalerV(18)),
                            child: Click(
                                radius: BorderRadius.circular(
                                  scaler.scalerV(10.0),
                                ),
                                color: Color.fromRGBO(112, 112, 112, 1),
                                text:
                                    browseList.value[index].title.toUpperCase(),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                    CardFronts.id,
                                    arguments: {
                                      'id': browseList.value[index].id,
                                      'title': browseList.value[index].title,
                                      'image': browseList.value[index].image,
                                      'content':
                                          browseList.value[index].content,
                                      'video': browseList.value[index].video,
                                      'Smart Mix': arg['Smart Mix'],
                                      'categoryname': arg['categoryname'],
                                      'type': arg['type'],
                                      'typeTitle': arg['typeTitle'],
                                      'smartmixcategoryname': browseList
                                          .value[index]
                                          .categoryData
                                          .categoryName
                                    },
                                  );
                                }),
                          );
                        }),
                  )
                : Center(
                    child: Text(
                      "No Cards Found",
                      style: textStyle(
                          color: DayTheme.textColor,
                          fontSize: scaler.scalerT(15.0)),
                    ),
                  ));
  }
}
