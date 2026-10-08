import 'package:flutter_test/flutter_test.dart';
import 'package:reservas_sala/domain/crear_reserva.dart';
import 'package:reservas_sala/domain/reserva.dart';

import 'support/reservas_en_memoria.dart';

DateTime hora(int h, [int m = 0]) => DateTime(2026, 10, 14, h, m);

const mensajeSolapamiento = 'La sala ya está reservada en ese horario.';

void main() {
  late ReservasEnMemoria repositorio;
  late CrearReserva crearReserva;

  setUp(() {
    repositorio = ReservasEnMemoria();
    crearReserva = CrearReserva(repositorio);
  });

  Future<ResultadoReserva> intentarReservaSolapada({
    required DateTime inicio,
    required DateTime fin,
  }) async {
    await repositorio.guardar(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u1',
      inicio: hora(10),
      fin: hora(11),
    ));

    return crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u2',
      inicio: inicio,
      fin: fin,
    ));
  }

  test('rechaza cuando la nueva reserva empieza antes y termina dentro', () async {
    final resultado = await intentarReservaSolapada(
      inicio: hora(9),
      fin: hora(10, 30),
    );

    expect(resultado.aceptada, isFalse);
    expect(resultado.mensaje, mensajeSolapamiento);
    expect(repositorio.reservas, hasLength(1));
  });

  test('rechaza cuando la nueva reserva empieza dentro y termina después', () async {
    final resultado = await intentarReservaSolapada(
      inicio: hora(10, 30),
      fin: hora(12),
    );

    expect(resultado.aceptada, isFalse);
    expect(resultado.mensaje, mensajeSolapamiento);
    expect(repositorio.reservas, hasLength(1));
  });

  test('rechaza cuando la nueva reserva está contenida en la existente', () async {
    final resultado = await intentarReservaSolapada(
      inicio: hora(10, 15),
      fin: hora(10, 45),
    );

    expect(resultado.aceptada, isFalse);
    expect(resultado.mensaje, mensajeSolapamiento);
    expect(repositorio.reservas, hasLength(1));
  });

  test('rechaza cuando la nueva reserva contiene a la existente', () async {
    final resultado = await intentarReservaSolapada(
      inicio: hora(9),
      fin: hora(12),
    );

    expect(resultado.aceptada, isFalse);
    expect(resultado.mensaje, mensajeSolapamiento);
    expect(repositorio.reservas, hasLength(1));
  });

  test('permite una reserva que empieza exactamente al terminar otra', () async {
    await repositorio.guardar(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u1',
      inicio: hora(9),
      fin: hora(10),
    ));

    final resultado = await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u2',
      inicio: hora(10),
      fin: hora(11),
    ));

    expect(resultado.aceptada, isTrue);
    expect(repositorio.reservas, hasLength(2));
  });
}
