import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';


class RatingView extends StatefulWidget {
  const RatingView({Key? key}) : super(key: key);

  @override
  State<RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  double _rating = 0;
  final TextEditingController _commentController = TextEditingController();
  final List<Color> _ratingColors = const [
    Color(0xFFC9CCD3),
    Color(0xFFF65A02),
    Color(0xFFF69402),
    Color(0xFFF6C002),
    Color(0xFF7ECE6A),
    Color(0xFF30AD11),
  ];
  final List<String> _assessments = const [
    'Aucun Commentaire',
    'Mauvais',
    'Médiocre',
    'Bien',
    'Très bon',
    'Excellent',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(context),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              _assessments[_rating.toInt()],
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: _ratingColors[_rating.toInt()],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RatingBar.builder(
              unratedColor: const Color(0xFFC9CCD3),
              initialRating: 0,
              minRating: 0,
              direction: Axis.horizontal,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 5.0),
              itemBuilder: (context, _) => Icon(
                Icons.star_rounded,
                color: _ratingColors[_rating.toInt()],
                size: 15,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
          ),
          if (_rating > 0) ...[
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                const EdgeInsets.only(bottom: 15.0, left: 20.0, top: 20.0),
                child: Text(
                  'Ajouter un commentaire (facultatif)',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: const Color(0xFFC9CCD3),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                ),
                controller: _commentController,
              ),
            ),
          ]
        ],
      ),
    );
  }

  PreferredSizeWidget createAppBar(BuildContext context) => AppBar(
    leadingWidth: 100,
    leading: GestureDetector(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          Text(
            'Retour',
            style: Theme.of(context).textTheme.titleMedium!,
          )
        ],
      ),
      onTap: () {
        Navigator.pop(context);
      },
    ),
    actions: [
      Container(
        margin: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: const Color(0xFF5E81F4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: const Text('Ajouter'),
        ),
      ),
    ],
  );
}
