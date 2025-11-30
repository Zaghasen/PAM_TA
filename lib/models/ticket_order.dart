class TicketOrder {
  final String id;
  final String mountainName;
  final String mountainImage;
  final String entryPoint;
  final String exitPoint;
  final DateTime startDate;
  final DateTime endDate;
  final int ticketCount;
  final List<PersonData> personalData;
  final int? leaderIndex;
  final double totalPrice;
  final String currency;
  final String managedBy;
  final DateTime orderDate;

  TicketOrder({
    required this.id,
    required this.mountainName,
    required this.mountainImage,
    required this.entryPoint,
    required this.exitPoint,
    required this.startDate,
    required this.endDate,
    required this.ticketCount,
    required this.personalData,
    this.leaderIndex,
    required this.totalPrice,
    required this.currency,
    required this.managedBy,
    required this.orderDate,
  });

  // Generate barcode string
  String getBarcodeData() {
    return 'TICKET-$id-${mountainName.toUpperCase()}';
  }
}

class PersonData {
  final String name;
  final String ktp;
  final String address;
  final DateTime? birthDate;
  final String nationality;
  final bool isLeader;

  PersonData({
    required this.name,
    required this.ktp,
    required this.address,
    this.birthDate,
    required this.nationality,
    this.isLeader = false,
  });
}
