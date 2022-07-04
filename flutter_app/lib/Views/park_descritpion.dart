import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Equipment {
  String name;
  IconData icon;

  Equipment({required this.name, required this.icon});
}

class ParkView extends StatelessWidget {
  static List<Equipment> equipments = [
    Equipment(name: 'Point d\'eau', icon: Icons.water_drop_rounded),
    Equipment(name: 'Banc', icon: Icons.chair),
    Equipment(name: 'Parking', icon: Icons.local_parking_rounded),
    Equipment(name: 'Ensoleillé: 10-15h', icon: Icons.wb_cloudy),
    Equipment(name: 'Toilette', icon: Icons.wc_rounded),
  ];

  const ParkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(context),
      body: ListView(
        children: [
          TitledSection(
            title: 'Bluebird Coffee',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Color(0xFF35DB0B),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Nice centre, Blvd D 10 Mtr Left',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: const Color(0xFFBDBDBD),
                      ),
                    )
                  ],
                ),
                Text(
                  '2-12 ans | 09:00-19:00 | 15min',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: const Color(0xFF3E4958),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 5,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/park.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          TitledSection(
            title: 'Descriptions',
            child: Text(
              'Nice centre, Blvd D 10 Mtr Left Nice centre, Blvd D 10 Mtr LeftNice centre, Blvd D 10 Mtr LeftNice centre, Blvd D 10 Mtr LeftNice centre',
              softWrap: true,
              maxLines: 5,
              overflow: TextOverflow.clip,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: const Color(0xFFBDBDBD),
              ),
            ),
          ),
          TitledSection(
            title: 'Equipements',
            child: EquipmentsGrid(equipments: equipments),
          ),
          TitledSection(
            title: 'Commentaires',
            child: Container(),
          ),
        ],
      ),
    );
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Annuler'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {},
            child: const Text('Ajouter un commentaire'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {},
            child: const Text('Notez ce parc'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {},
            child: const Text('Modifier le parc'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {},
            child: const Text('Signaler comme fermé'),
          )
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
          onPressed: () => _showActionSheet(context),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: const Color(0xFF5E81F4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: const Text('Options'),
        ),
      ),
    ],
  );
}

class TitledSection extends StatelessWidget {
  final String title;
  final Widget child;

  const TitledSection({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!,
          ),
          const SizedBox(
            height: 10,
          ),
          child,
        ],
      ),
    );
  }
}

class EquipmentsGrid extends StatelessWidget {
  final List<Equipment> equipments;

  const EquipmentsGrid({
    Key? key,
    required this.equipments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < equipments.length;) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int j = 0; i < equipments.length && j < 2; j++, i++) ...[
                Padding(
                  padding: EdgeInsets.only(right: j == 1 ? 50.0 : 20),
                  child: createEquipment(context, equipments[i]),
                ),
              ]
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ],
    );
  }

  Widget createEquipment(BuildContext context, Equipment eq) {
    return (Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          eq.icon,
          color: const Color(0xFF5E81F4),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          eq.name,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: const Color(0xFFBDBDBD),
          ),
        )
      ],
    ));
  }
}
