class CreditCard {
  String cardNumber = "";
  String expiryDate = "";
  String cardHolderName = "";
  String cvvCode = "";
  bool isCvvFocused = false;
  CreditCard(
      {this.cardNumber,
      this.expiryDate,
      this.cardHolderName,
      this.cvvCode,
      this.isCvvFocused});
}
