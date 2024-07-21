class RoomPlanner {
  final Map<String, double> roomSizes = {
    "Bedroom": 12,
    "MasterBedroom": 14,
    "LivingRoom": 18,
    "Balcony": 8,
    "Kitchen": 15,
    "Bathroom": 2,
    "GuestRoom": 12,
    "Store": 2,
  };

  final Map<int, String> items = {
    1: "Bedroom1",
    2: "Bedroom2",
    3: "Bedroom3",
    4: "MasterBedroom1",
    5: "MasterBedroom2",
    6: "LivingRoom1",
    7: "LivingRoom2",
    8: "GuestRoom",
    9: "Balcony1",
    10: "Balcony2",
    11: "Kitchen1",
    12: "Kitchen2",
    13: "Store1",
    14: "Store2",
    15: "Bathroom1",
    16: "Bathroom2",
    17: "Bathroom3",
  };

  double calculateWastedArea(double area) {
    double wastedArea = 0.1 * area;
    return area - wastedArea;
  }

  List<MapEntry<String, double>> calculateRoomSizes(
      double totalArea, List<int> roomNumbers) {
    double usableArea = calculateWastedArea(totalArea);
    List<MapEntry<String, double>> fittingRooms = [];

    for (var num in roomNumbers) {
      var room = items[num];
      if (room != null) {
        var roomType = room.replaceAll(RegExp(r'\d'), '');
        var roomSize = totalArea * (roomSizes[roomType]! / 100);
        if (roomSize <= usableArea) {
          fittingRooms.add(MapEntry(room, roomSize));
          usableArea -= roomSize;
        }
      }
    }

    return fittingRooms;
  }

  double calculateRemainingArea(
      double totalArea, List<MapEntry<String, double>> fittingRooms) {
    double remainingArea = calculateWastedArea(totalArea);
    for (var entry in fittingRooms) {
      remainingArea -= entry.value;
    }
    return remainingArea;
  }
}
