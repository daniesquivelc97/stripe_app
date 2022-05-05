import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:stripe_app/bloc/pagar/pagar_bloc.dart';
import 'package:stripe_app/models/tarjeta_credito.dart';
import 'package:stripe_app/widgets/total_pay_button.dart';

class TarjetaPage extends StatelessWidget {
  const TarjetaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tarjeta = BlocProvider.of<PagarBloc>(context).state.tarjeta;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pagar'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              final pagarBloc = BlocProvider.of<PagarBloc>(context);
              pagarBloc.add(OnDesecativarTarjeta());
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff284879),
        ),
        body: Stack(
          children: [
            Container(),
            Hero(
              tag: tarjeta!.cardNumber,
              child: CreditCardWidget(
                cardNumber: tarjeta.cardNumberHidden,
                expiryDate: tarjeta.expiracyDate,
                cardHolderName: tarjeta.cardHolderName,
                cvvCode: tarjeta.cvv,
                isHolderNameVisible: true,
                showBackView: false,
                onCreditCardWidgetChange: (_) {},
              ),
            ),
            const Positioned(
              bottom: 0,
              child: TotalPayButton(),
            ),
          ],
        ));
  }
}
