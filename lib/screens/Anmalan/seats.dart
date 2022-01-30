import 'package:fil_lan/helpers/paint_chair.dart';
import 'package:fil_lan/logic/table_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatsRow extends StatelessWidget {
  final int numSeats;
  final List<dynamic> freeSeats;
  final int tableSeats;
  final bool end;

  SeatsRow(
      {Key? key,
      required this.tableSeats,
      required this.numSeats,
      required this.freeSeats,
      required this.end})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tableBloc = BlocProvider.of<TableBloc>(context);

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(numSeats, (i) {
          if (freeSeats.contains(i + 1)) {
            return InkWell(
                onTap: () =>
                    tableBloc.add(OnSelectedSeatsEvent('$tableSeats${i + 1}')),
                child: BlocBuilder<TableBloc, TableState>(
                    builder: (_, state) => PaintChair(
                        end: end,
                        color:
                            state.selectedSeats.contains('$tableSeats${i + 1}')
                                ? Colors.amber
                                : Colors.white)));
          }

          return PaintChair(end: end);
        }),
      ),
    );
  }
}
