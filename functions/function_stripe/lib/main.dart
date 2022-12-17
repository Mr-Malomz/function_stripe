import 'package:dart_appwrite/dart_appwrite.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> start(final req, final res) async {
  final client = Client();
  var uname = 'STRIPE SECRET KEY GOES HERE';
  var pword = '';
  var authn = 'Basic ' + base64Encode(utf8.encode('$uname:$pword'));

  var headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Authorization': authn,
  };

  var data = {
    'amount': '100',
    'currency': 'usd',
    'payment_method': 'pm_card_visa',
  };

  var url = Uri.parse('https://api.stripe.com/v1/payment_intents');
  var response = await http.post(url, headers: headers, body: data);
  if (response.statusCode != 200) {
    res.json({
      "status": response.statusCode,
      "message": "Error processing subscription"
    });
  } else {
    res.json({
      "status": response.statusCode,
      "message": "Subscription processed successfully!"
    });
  }
}
