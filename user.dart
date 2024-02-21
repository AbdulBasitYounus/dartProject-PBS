import 'dart:io';

import 'bus.dart';

class User {
  String name = '';
  String cnic = '';
  int bookedSeatsCount = 0;

  void login() {
    print("Enter your name:");
    name = stdin.readLineSync()!;

    print("Enter your CNIC (8 digits):");
    cnic = stdin.readLineSync()!;
    while (cnic.length != 8 || !isNumeric(cnic)) {
      print("Invalid CNIC please enter a valid 8-digit CNIC:");
      cnic = stdin.readLineSync()!;
    }
  }

  void displayRoutes() {
    print("Available routes:");
    Bus.displayRoutes();

    print("Select a route by number (press 0 to exit):");
    print("***************************************");
    int routeChoice = int.tryParse(stdin.readLineSync()!) ?? 0;

    if (routeChoice == 0) {
      print("Thanks for using People Bus Service");
      print("************************************");
      return;
    }

    String seatId = Bus.bookSeat(routeChoice, cnic);
    if (seatId.isNotEmpty) {
      bookedSeatsCount++;
      print("Seat reserved successfully Your seat ID is: $seatId");
      print('**********************************************');

      if (bookedSeatsCount < 2) {
        print("Do you want to exit or book another seat? (exit/book)");
        String? nextAction = stdin.readLineSync()?.toLowerCase();

       if (nextAction == "book") {
          displayRoutes();
        }
        if (bookedSeatsCount>2) {
          print("Press 0 to exit");}
      } 
      else {
        
        print("********************************");
        print("Thank You for using Peoples Bus Service");
      }
    } else {
      displayRoutes();
    }
  }

  bool isNumeric(String s) => double.tryParse(s) != null;
}
