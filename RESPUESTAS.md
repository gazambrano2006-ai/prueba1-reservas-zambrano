## Escenarios que elegí y por qué

Probé los cuatro tipos porque una reserva puede cruzarse con otra por cualquiera de sus extremos, quedar dentro o contenerla completa (`test/crear_reserva_solapamiento_test.dart:39`, `test/crear_reserva_solapamiento_test.dart:50`, `test/crear_reserva_solapamiento_test.dart:61`, `test/crear_reserva_solapamiento_test.dart:72`). También probé el inicio justo al final de otra: ese límite debe permitirse, y la regla usa comparaciones estrictas (`test/crear_reserva_solapamiento_test.dart:83`, `lib/domain/crear_reserva.dart:18-21`).

## Riesgo más grave del repositorio

El riesgo más grave es tener la clave `service_role` dentro del proyecto: el README indica que se use esa clave (`README.md:19-20`) y está escrita en `lib/data/supabase_config.dart:3-4`. Además, la app la carga al inicializar Supabase (`lib/main.dart:11`). Si se distribuye la app, esa credencial privilegiada puede extraerse; la constitution prohíbe guardar secretos en el código (`.specify/memory/constitution.md:16-17`).

## ¿La regla protege la app real?

Por ahora protege solo las reservas que pasan por `CrearReserva`, donde se consultan las reservas y se comprueba el intervalo (`lib/domain/crear_reserva.dart:16-29`). El formulario hace un `insert` directo a Supabase (`lib/presentation/reserva_page.dart:58-65`), y la base solo valida que el fin sea posterior al inicio (`supabase/migracion.sql:11`); su política de inserción no comprueba solapamientos (`supabase/migracion.sql:21-24`). Así que desde la pantalla todavía se podría crear una reserva solapada.
