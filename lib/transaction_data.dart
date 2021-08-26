import 'dart:math';


class Transaction{
  final _rng = Random();
  final String transactionName;
  final String date;
  final String time;
  final String transactiontype;
  int money=0;
  Transaction(this.transactionName,this.date,this.time, this.transactiontype){
    this.money = _rng.nextInt(1000);
  }

  void randMoney(){
    this.money = _rng.nextInt(1000);
  }

}

List<Transaction> listOfTransaction = [
  Transaction("WWWWLOBASCOM", "20 Aug 2021", "6:40 PM", "debit"),
  Transaction("Cashback", "20 Aug 2021", "6:40 PM", "credit"),
  Transaction("Recharge", "20 Aug 2021", "6:40 PM", "credit"),
  Transaction("Retail Store", "20 Aug 2021", "6:40 PM", "debit")

];



