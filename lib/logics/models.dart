class Model{
  String label;
  double amount;
  String type;
  String date;
  String time;
  String paymentoption;
  int id;

  Model(this.label, this.amount, this.type, this.date, this.time,
      this.paymentoption, this.id);
}

class totalsmodel{
  double total;
  totalsmodel({required this.total});
}