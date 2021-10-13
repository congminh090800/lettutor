import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor/widgets/common/submit_button.dart';
import 'package:lettutor/widgets/tutors/tags_list.dart';
import 'package:lettutor/widgets/tutors/tutors_list.dart';

class SearchTutorPage extends StatefulWidget {
  const SearchTutorPage({Key? key}) : super(key: key);

  @override
  _SearchTutorPageState createState() => _SearchTutorPageState();
}

class _SearchTutorPageState extends State<SearchTutorPage> {
  @override
  Widget build(BuildContext context) {
    var i18n = AppLocalizations.of(context);
    var tagsList = [
      i18n!.allType,
      i18n.engForKidsType,
      i18n.engForBusinessType,
      i18n.conversationalType,
      i18n.startersType,
      i18n.moversType,
      i18n.flytersType,
      i18n.ketType,
      i18n.petType,
      i18n.ieltsType,
      i18n.toeflType,
      i18n.toeicType
    ];
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                i18n.tutorPageTitle,
                style: TextStyle(
                  fontSize: 29,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: TagsList(tagsList: tagsList),
              padding: EdgeInsets.only(bottom: 30),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: i18n.searchTutorPlaceholder,
                  suffixIcon: GestureDetector(
                    child: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Text(i18n.searchNationality + ": "),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                    ),
                    child: CountryCodePicker(
                      onChanged: (CountryCode countryCode) {
                        print(
                          "New Country selected: " + countryCode.toString(),
                        );
                      },
                      initialSelection: 'VN',
                      showOnlyCountryWhenClosed: true,
                      showCountryOnly: true,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(left: 20),
                    child: SubmitButton(btnText: i18n.searchTutorSubmit),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(bottom: 20),
              child: Container(
                child: Column(
                  children: [
                    TutorsList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
