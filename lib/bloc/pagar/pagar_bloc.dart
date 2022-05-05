import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stripe_app/models/tarjeta_credito.dart';

part 'pagar_event.dart';
part 'pagar_state.dart';

class PagarBloc extends Bloc<PagarEvent, PagarState> {
  PagarBloc() : super(const PagarState()) {
    on<PagarEvent>(
      (event, emit) {
        if (event is OnSeleccionarTarjeta) {
          emit(state.copyWith(tarjetaActiva: true, tarjeta: event.tarjeta));
        } else if (event is OnDesecativarTarjeta) {
          emit(state.copyWith(tarjetaActiva: false));
        }
      },
    );
  }
}
