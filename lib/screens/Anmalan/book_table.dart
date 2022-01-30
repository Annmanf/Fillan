import 'package:fil_lan/logic/table_bloc.dart';
import 'package:fil_lan/screens/Anmalan/seats.dart';
import 'package:fil_lan/service/seat_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../models/tables.dart';

class BookTable extends StatefulWidget {
  String? titleMovie;
  String? imageMovie;
  var seats;
  BookTable({
    Key? key,
    this.titleMovie,
    this.imageMovie,
    this.seats,
  }) : super(key: key);

  @override
  State<BookTable> createState() => _BookTableState();
}

class _BookTableState extends State<BookTable> {
  @override
  Widget build(BuildContext context) {
    SeatFire seatService = Provider.of<SeatFire>(context, listen: false);

    final size = MediaQuery.of(context).size;
    final tableBloc = BlocProvider.of<TableBloc>(context);
    List<Tables> see = widget.seats;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              //seatService.getSeatsFromFirebas();
              /**await seatService.getSeatsFromFirebas((e) {}).then((value) {
                setState(() {
                  seats = seatService.getTables();
                });
                print(seats.length);
              }); */
            },
            child: Text('Show Seats'),
          ),
          Container(
              height: 700,
              width: size.width,
              child: Column(
                children: List.generate(
                    see.length,
                    (i) => SeatsRow(
                          numSeats: see[i].seats,
                          freeSeats: see[i].freeSeats,
                          tableSeats: see[i].tableSeats,
                          end: see[i].end,
                        )),
              )),
          TextButton(
            onPressed: () {
              //String ss = BlocProvider.of<TableBloc>(context).getSelectedSeat();

              Navigator.pop(context);
            },
            child: Text("Välj"),
          )
        ],
      ),
    );
  }
}
/*
class _ItemsDescription extends StatelessWidget {
  const _ItemsDescription({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Icon(Icons.circle, color: Colors.white, size: 10),
              SizedBox(width: 10.0),
            ],
          ),
          Row(
            children: [
              Icon(Icons.circle, color: Color(0xff4A5660), size: 10),
              SizedBox(width: 10.0),
            ],
          ),
          Row(
            children: [
              Icon(Icons.circle, color: Colors.amber, size: 10),
              SizedBox(width: 10.0),
            ],
          ),
        ],
      ),
    );
  }
}

class _ItemTime extends StatelessWidget {
  final String time;

  const _ItemTime({Key? key, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cinemaBloc = BlocProvider.of<TableBloc>(context);

    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: InkWell(
        onTap: () => cinemaBloc.add(OnSelectedTimeEvent(time)),
        child: BlocBuilder<TableBloc, TableState>(
          builder: (context, state) => Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            decoration: BoxDecoration(
                color: state.time == time ? Colors.amber : Color(0xff4D525A),
                borderRadius: BorderRadius.circular(8.0)),
            child: Text(
              time,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
/*
class _ItemDate extends StatelessWidget {
  final Date date;

  const _ItemDate({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cinemaBloc = BlocProvider.of<CinemaBloc>(context);

    return InkWell(
      onTap: () => cinemaBloc.add(OnSelectedDateEvent(date.number)),
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: BlocBuilder<CinemaBloc, CinemaState>(
          builder: (context, state) => Container(
            height: 100,
            width: 75,
            decoration: BoxDecoration(
                color: state.date == date.number
                    ? Colors.amber
                    : Color(0xff4A5660),
                borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle,
                    color: Color(0xff21242C).withOpacity(.8), size: 12),
                SizedBox(height: 10.0),
                TextFrave(text: date.day, color: Colors.white, fontSize: 17),
                SizedBox(height: 5.0),
                TextFrave(text: date.number, color: Colors.white, fontSize: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
*/