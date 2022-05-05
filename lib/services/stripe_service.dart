import 'package:dio/dio.dart';
import 'package:stripe_app/models/payment_intent_response.dart';
import 'package:stripe_app/models/stripe_custom_respose.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  // Singleton
  StripeService._privateConstructor();
  static final StripeService _instance = StripeService._privateConstructor();
  factory StripeService() => _instance;

  final String _paymentApiUrl = 'https://api.stripe.com/v1/payment_intents';
  static const String _secretKey =
      'sk_test_51Kw685IuqkL7BAkhYh8wjXyykbpflLEGRsrGKzI5JfhRjzlaoLdW2U9lzekATbcM0d3hJXK50ekWpR9Qqp6bR2Dq00rwGgcmC3';
  final String _apiKey =
      'pk_test_51Kw685IuqkL7BAkhLIRsccybSTc3822irJxkVu4JG60wsTM5s0Jr0GjExlCqFT65Dju1vmGwr8AGnMoj1nleElIF00727Gp3Lc';

  final headerOptions = Options(
    contentType: Headers.formUrlEncodedContentType,
    headers: {'Authorization': 'Bearer ${StripeService._secretKey},'},
  );

  void init() {
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: _apiKey,
        androidPayMode: 'test',
        merchantId: 'test',
      ),
    );
  }

  Future<StripeCustomResponse> pagarConTarjetaExistente({
    required String amount,
    required String currency,
    required CreditCard card,
  }) async {
    try {
      final paymentMethod = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(card: card),
      );
      final response = await _realizarCobro(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
      );
      return response;
    } catch (e) {
      return StripeCustomResponse(ok: false, msg: e.toString());
    }
  }

  Future<StripeCustomResponse> pagarConNuevaTarjeta({
    required String amount,
    required String currency,
  }) async {
    try {
      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest(),
      );
      final response = await _realizarCobro(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
      );
      return response;
    } catch (e) {
      return StripeCustomResponse(ok: false, msg: e.toString());
    }
  }

  Future<StripeCustomResponse> pagarApplePayGooglePay({
    required String amount,
    required String currency,
  }) async {
    try {
      final newAmount = double.parse(amount) / 100;
      final token = await StripePayment.paymentRequestWithNativePay(
        androidPayOptions: AndroidPayPaymentRequest(
            currencyCode: currency, totalPrice: amount),
        applePayOptions: ApplePayPaymentOptions(
          countryCode: 'US',
          currencyCode: currency,
          items: [
            ApplePayItem(
              label: 'Producto 1',
              amount: '$newAmount',
            ),
          ],
        ),
      );
      final paymentMethod = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(
          card: CreditCard(
            token: token.tokenId,
          ),
        ),
      );
      final response = await _realizarCobro(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
      );
      await StripePayment.completeNativePayRequest();
      return response;
    } catch (e) {
      print('Error en intento: ${e.toString()}');
      return StripeCustomResponse(
        ok: false,
        msg: e.toString(),
      );
    }
  }

  Future<PaymenyIntentResponse> _crearPaymentIntent({
    required String amount,
    required String currency,
  }) async {
    try {
      final dio = Dio();
      final data = {'amount': amount, 'currency': currency};
      final response = await dio.post(
        _paymentApiUrl,
        data: data,
        options: headerOptions,
      );
      return PaymenyIntentResponse.fromJson(response.data);
    } catch (e) {
      print('Error en intento: ${e.toString()}');
      return PaymenyIntentResponse(status: '400');
    }
  }

  Future _realizarCobro({
    required String amount,
    required String currency,
    required PaymentMethod paymentMethod,
  }) async {
    try {
      // Crear intento
      final paymentIntent = await _crearPaymentIntent(
        amount: amount,
        currency: currency,
      );
      final paymentResult = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: paymentIntent.clientSecret,
          paymentMethodId: paymentMethod.id,
        ),
      );
      if (paymentResult.status == 'succeeded') {
        return StripeCustomResponse(ok: true);
      } else {
        return StripeCustomResponse(
          ok: false,
          msg: 'Falló: ${paymentResult.status}',
        );
      }
    } catch (e) {
      print(e.toString());
      return StripeCustomResponse(
        ok: false,
        msg: e.toString(),
      );
    }
  }
}
