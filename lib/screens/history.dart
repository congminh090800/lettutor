import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/constants/http.dart';
import 'package:lettutor/provider/auth_provider.dart';
import 'package:lettutor/real_models/schedule.dart';
import 'package:lettutor/widgets/common/customized_button.dart';
import 'package:lettutor/widgets/history/history_list_tile.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool loading = true;
  int page = 1;
  int perPage = 2;
  int count = 0;
  List<Schedule> scheduleList = [];
  Future<void> getSchedules(bool resetList) async {
    try {
      setState(() {
        if (resetList == true) {
          scheduleList.clear();
          page = 1;
        }
        loading = true;
      });
      var dio = Http().client;
      var accessToken = Provider.of<AuthProvider>(context, listen: false)
          .auth
          .tokens!
          .access!
          .token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      var query = {
        'page': page,
        'perPage': perPage,
        'dateTimeLte': DateTime.now().millisecondsSinceEpoch,
        'orderBy': 'meeting',
        'sortBy': 'desc'
      };
      var res = await dio.get("booking/list/student", queryParameters: query);
      Iterable i = res.data["data"]["rows"];
      List<Schedule> data =
          List<Schedule>.from(i.map((schedule) => Schedule.fromJson(schedule)));
      setState(() {
        scheduleList.addAll(data);
        count = res.data["data"]["count"];
        loading = false;
      });
    } catch (e) {
      inspect(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getSchedules(true);
  }

  @override
  Widget build(BuildContext context) {
    var i18n = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                i18n!.historyPageTitle,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/images/history_view_icon.svg',
                            width: 120,
                            height: 120,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: VerticalDivider(
                        thickness: 5,
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              i18n.historyPageDescription1,
                              style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                color: Color(0xff787878),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              i18n.historyPageDescription2,
                              style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                color: Color(0xff787878),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /* LIST BEGIN HERE */
            Container(
              child: scheduleList.length > 0
                  ? ListView(
                      padding: EdgeInsets.only(top: 0),
                      shrinkWrap: true,
                      primary: false,
                      children: scheduleList
                          .map(
                            (e) => HistoryListTile(
                              schedule: e,
                            ),
                          )
                          .toList(),
                    )
                  : loading == true
                      ? Container()
                      : Container(
                          child: Text(
                            "No data",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 20),
                        ),
            ),
            page * perPage < count && loading == false
                ? Container(
                    child: CustomizedButton(
                      btnText: "Load more",
                      onTap: () async {
                        setState(() {
                          page = page + 1;
                        });
                        await getSchedules(false);
                      },
                      hasBorder: false,
                      textSize: 20,
                    ),
                    margin: EdgeInsets.only(
                      top: 16,
                      bottom: 4,
                    ),
                  )
                : Container(),
            loading == true
                ? Container(
                    child: CircularProgressIndicator(),
                    padding: EdgeInsets.only(top: 20),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
