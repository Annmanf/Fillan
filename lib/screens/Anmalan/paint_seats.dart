import 'package:fil_lan/helpers/paint_chair.dart';
import 'package:fil_lan/service/auth_services.dart';
import 'package:fil_lan/service/seat_service.dart';
import 'package:fil_lan/theme/fil_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeatsRow extends StatelessWidget {
  final int numSeats;
  final List<dynamic> freeSeats;
  final int tableSeats;
  final String selSeats;
  const SeatsRow({
    Key? key,
    required this.tableSeats,
    required this.numSeats,
    required this.freeSeats,
    required this.selSeats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final seatService = Provider.of<SeatService>(context);
    final authService = Provider.of<AuthService>(context);

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(numSeats, (i) {
          List<String> selected = [];
          if (selSeats == ('$tableSeats${i + 1}')) {
            const PaintChair(
              color: FilLanTheme.orange,
            );
          }
          if (freeSeats.contains(i + 1)) {
            return InkWell(
              onTap: () async {
                print('table on click: $tableSeats${i + 1}');

                print('selseats on click $selSeats');

                ///Fetch all selected seats from firebase
                List<String> allSelected = await seatService.getSelectedSeats();
                print('allSelected from firebase $allSelected');

                if (allSelected.contains('$tableSeats${i + 1}')) {
                  SnackBar(content: Text('Choose another seat'));
                } else {
                  await authService.getSelectedSeats();
                  print(
                      'selseats: $selSeats table: $tableSeats${i + 1} authselected: ${authService.selectedSeats}');

                  String prev = authService.selectedSeats!;

                  ///Update freeSeats to remove the newly selected seat
                  List<dynamic> tmpfree = [];
                  tmpfree.addAll(freeSeats);
                  prev.substring(1);
                  print('previous seat: ${int.parse(prev.substring(1))}');
                  tmpfree.add(int.parse(prev.substring(1)));
                  tmpfree.remove(i + 1);

                  print('cureent seat: ${i + 1}');

                  ///Add the newly selected seat to firebase and user
                  selected.add('$tableSeats${i + 1}');
                  seatService.addSelectedSeats(tableSeats, tmpfree, selected);
                  await authService.addSelectedSeats('$tableSeats${i + 1}');

                  print('auth selected: ${authService.selectedSeats}');
                }
              },
              child: PaintChair(
                color: authService.selectedSeats == ('$tableSeats${i + 1}')
                    ? FilLanTheme.orange
                    : Colors.white,
              ),
            );
          } else {
            return PaintChair(
              color: authService.selectedSeats == ('$tableSeats${i + 1}')
                  ? FilLanTheme.orange
                  : Color(0xff4D525A),
            );
          }
        }),
      ),
    );
  }
}
