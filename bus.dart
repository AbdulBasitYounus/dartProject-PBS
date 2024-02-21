import 'dart:io';

class Bus {
  static List<Route> routes = [
    Route("R1 DARKYARD TO MODEL COLONY", 8),
    Route("R9 TOWER    TO HADEED ", 11),
    Route("R4 NUMAISH  TO SEAVIEW", 2),
  ];

  static void displayRoutes() {
    for (int i = 0; i < routes.length; i++) {
      print("${i + 1}. ${routes[i].routeName} - Available Seats: ${routes[i].vacantSeats}");
    }
  }

  static String bookSeat(int routeChoice, String cnic) {
    print("Select number of seats (1-${routes[routeChoice - 1].vacantSeats}):");
    int selectedBus = int.tryParse(stdin.readLineSync()!) ?? 0;

    if (selectedBus < 1 || selectedBus > routes[routeChoice - 1].vacantSeats) {
      print("Invalid selection.");
      return "";
    }

    String seatId = "${routes[routeChoice - 1].routeName[0]}${selectedBus}${routes[routeChoice - 1].vacantSeats + 1}";

    if (routes[routeChoice - 1].bookSeat(selectedBus, cnic)) {
      return seatId;
    } else {
      print("Sorry you alredy use your limit");
      return '';
    }
  }
}

class Route {
  String routeName;
  int vacantSeats;

  Route(this.routeName, this.vacantSeats);

  Set<String> bookedCNICs = Set();

  bool bookSeat(int busNumber, String cnic) {
    if (!bookedCNICs.contains(cnic) && vacantSeats > 0 && bookedCNICs.where((id) => id.startsWith(cnic)).length < 2) {
      bookedCNICs.add(cnic);
      vacantSeats--;
      return true;
    }
    return false;
  }
}
