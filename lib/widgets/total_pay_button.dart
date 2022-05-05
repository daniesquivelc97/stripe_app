import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stripe_app/bloc/pagar/pagar_bloc.dart';
import 'package:stripe_app/helpers/helpers.dart';
import 'package:stripe_app/services/stripe_service.dart';
import 'package:stripe_payment/stripe_payment.dart';

class TotalPayButton extends StatelessWidget {
  const TotalPayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final pagarBloc = BlocProvider.of<PagarBloc>(context).state;

    return Container(
      width: width,
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${pagarBloc.montoPagar} ${pagarBloc.moneda}',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          BlocBuilder<PagarBloc, PagarState>(
            builder: (context, state) {
              return _BtnPay(
                state: state,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BtnPay extends StatelessWidget {
  final PagarState state;

  const _BtnPay({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return state.tarjetaActiva
        ? buildBotonTarjeta(context)
        : buildAppleAndGooglePay(context);
  }

  Widget buildBotonTarjeta(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 170,
      shape: const StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: const [
          Icon(
            FontAwesomeIcons.creditCard,
            color: Colors.white,
          ),
          Text(
            '   Pagar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          )
        ],
      ),
      onPressed: () async {
        mostrarLoading(context);
        final stripService = StripeService();
        final state = BlocProvider.of<PagarBloc>(context).state;
        final tarjeta = state.tarjeta;
        final mesAno = tarjeta!.expiracyDate.split('/');

        final response = await stripService.pagarConTarjetaExistente(
          amount: state.montoPagarString,
          currency: state.moneda,
          card: CreditCard(
            number: tarjeta.cardNumber,
            expMonth: int.parse(mesAno[0]),
            expYear: int.parse(mesAno[1]),
          ),
        );
        Navigator.pop(context);

        if (response.ok) {
          mostrarAlerta(context, 'Tarjeta Ok', 'Todo correcto');
        } else {
          mostrarAlerta(context, 'Algo salió mal', response.msg!);
        }
        Navigator.pop(context);

        if (response.ok) {
          mostrarAlerta(context, 'Tarjeta Ok', 'Todo correcto');
        } else {
          mostrarAlerta(context, 'Algo salió mal', response.msg!);
        }
      },
    );
  }

  Widget buildAppleAndGooglePay(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      shape: const StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          Icon(
            Platform.isAndroid
                ? FontAwesomeIcons.google
                : FontAwesomeIcons.apple,
            color: Colors.white,
          ),
          const Text(
            ' Pay',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          )
        ],
      ),
      onPressed: () async {
        final stripService = StripeService();
        final state = BlocProvider.of<PagarBloc>(context).state;

        final response = await stripService.pagarApplePayGooglePay(
          amount: state.montoPagarString,
          currency: state.moneda,
        );
      },
    );
  }
}
