import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor/models/tutor.dart';
import 'package:lettutor/screens/tutors/details.dart';
import 'package:lettutor/widgets/common/fullscreen_dialog.dart';
import 'package:lettutor/widgets/tutors/tags_list.dart';

class TutorListTile extends StatefulWidget {
  const TutorListTile({Key? key, required this.tutorItem}) : super(key: key);
  final Tutor tutorItem;
  @override
  _TutorListTileState createState() => _TutorListTileState();
}

class _TutorListTileState extends State<TutorListTile> {
  displayDialog(BuildContext context, String title, Widget content) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) =>
            FullScreenDialog(title: title, content: content),
        fullscreenDialog: true,
      ),
    );
  }

  bool isFavorited = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        displayDialog(
          context,
          "",
          TutorDetails(),
        ),
      },
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                      "https://api.app.lettutor.com/avatar/e9e3eeaa-a588-47c4-b4d1-ecfa190f63faavatar1632109929661.jpg",
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      child: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: isFavorited ? Colors.red : Colors.blue,
                        size: 26,
                      ),
                      onTap: () {
                        setState(() {
                          isFavorited = !isFavorited;
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
            Container(
              child: Row(
                children: [
                  Text(
                    widget.tutorItem.name,
                    style: TextStyle(fontSize: 22),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 20),
              child: RatingBar.builder(
                initialRating: widget.tutorItem.rating,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 20,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
                ignoreGestures: true,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 20),
              child: TagsList(
                tagsList: widget.tutorItem.specialities.toList(),
                selectFirstItem: false,
                readOnly: true,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                widget.tutorItem.summary,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Container(
            //   alignment: Alignment.centerRight,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       Container(
            //         margin: EdgeInsets.only(left: 10),
            //         child: CustomizedButton(
            //           btnText: i18n!.bookTutorBtnText,
            //           icon: Icons.event_available,
            //         ),
            //       ),
            //       Container(
            //         margin: EdgeInsets.only(left: 10),
            //         child: CustomizedButton(
            //           btnText: i18n.messageTutorBtnText,
            //           icon: Icons.chat,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
