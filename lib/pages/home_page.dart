import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:stripe_app/bloc/pagar/pagar_bloc.dart';
import 'package:stripe_app/data/tarjetas.dart';
import 'package:stripe_app/helpers/helpers.dart';
import 'package:stripe_app/pages/tarjeta_page.dart';
import 'package:stripe_app/services/stripe_service.dart';
import 'package:stripe_app/widgets/total_pay_button.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final stripeService = StripeService();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pagarBloc = BlocProvider.of<PagarBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagar'),
        centerTitle: true,
        backgroundColor: const Color(0xff284879),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              mostrarLoading(context);
              final amount = pagarBloc.state.montoPagarString;
              final currency = pagarBloc.state.moneda;

              final response = await stripeService.pagarConNuevaTarjeta(
                amount: amount,
                currency: currency,
              );

              Navigator.pop(context);

              if (response.ok) {
                mostrarAlerta(context, 'Tarjeta Ok', 'Todo correcto');
              } else {
                mostrarAlerta(context, 'Algo salió mal', response.msg!);
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            width: size.width,
            height: size.height,
            top: 200,
            child: PageView.builder(
                controller: PageController(viewportFraction: 0.9),
                physics: const BouncingScrollPhysics(),
                itemCount: tarjetas.length,
                itemBuilder: (_, i) {
                  final tarjeta = tarjetas[i];
                  return GestureDetector(
                    onTap: () {
                      pagarBloc.add(OnSeleccionarTarjeta(tarjeta));
                      Navigator.push(
                        context,
                        navegarFadeIn(
                          context,
                          const TarjetaPage(),
                        ),
                      );
                    },
                    child: Hero(
                      tag: tarjeta.cardNumber,
                      child: CreditCardWidget(
                        cardNumber: tarjeta.cardNumberHidden,
                        expiryDate: tarjeta.expiracyDate,
                        cardHolderName: tarjeta.cardHolderName,
                        isHolderNameVisible: true,
                        cvvCode: tarjeta.cvv,
                        showBackView: false,
                        onCreditCardWidgetChange: (_) {},
                      ),
                    ),
                  );
                }),
          ),
          const Positioned(
            bottom: 0,
            child: TotalPayButton(),
          ),
        ],
      ),
    );
  }
}
