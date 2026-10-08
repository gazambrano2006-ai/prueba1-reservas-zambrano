## Prompt 1

```text
Lee el repositorio completo antes de modificar nada.

Revisa especialmente:
- .specify/memory/constitution.md
- specs/001-reservas-sala/spec.md
- specs/001-reservas-sala/plan.md
- lib/domain/crear_reserva.dart
- la interfaz ReservasRepository
- las pruebas existentes en test/

No modifiques ningún archivo todavía.

Explícame:
1. cómo funciona actualmente CrearReserva;
2. cómo obtiene las reservas existentes;
3. qué comportamiento actual permite que se solapen reservas;
4. qué pruebas existen actualmente;
5. qué restricciones de constitution.md y plan.md debo respetar.

Cita las rutas de los archivos que revisaste.
```

## Prompt 2

```text
Modifica únicamente specs/001-reservas-sala/spec.md.

No modifiques constitution.md, plan.md, código, pruebas ni ningún otro archivo.

Mantén los dos escenarios existentes y agrega escenarios nuevos en formato Dado/Cuando/Entonces para dejar sin ambigüedad esta regla:

“Dos reservas de la misma sala no pueden solaparse.”

Agrega estos casos:
1. La nueva reserva empieza antes de una existente y termina dentro de ella.
2. La nueva reserva empieza dentro de una existente y termina después.
3. La nueva reserva está completamente contenida dentro de una existente.
4. La nueva reserva contiene completamente a una existente.
5. Una reserva comienza exactamente cuando termina otra: debe permitirse.

Para todos los casos de rechazo utiliza exactamente este mensaje:
“La sala ya está reservada en ese horario.”

La spec debe describir únicamente QUÉ debe ocurrir.
No menciones widgets, setState, paquetes, clases, métodos, carpetas ni detalles de implementación.
No agregues funcionalidades fuera del alcance.
```

## Prompt 3

```text
Ahora modifica únicamente las pruebas necesarias en test/.

No modifiques todavía ningún archivo dentro de lib/ ni cambies la implementación.

Agrega pruebas para la regla de solapamiento definida en spec.md.

Las pruebas deben:
- usar el ReservasRepository en memoria existente;
- no usar red ni Supabase;
- compilar correctamente;
- comprobar los cuatro casos de solapamiento definidos en la spec;
- comprobar que una reserva que comienza exactamente cuando termina otra sea permitida;
- comprobar exactamente el mensaje:
  "La sala ya está reservada en ese horario."

No modifiques las pruebas existentes.
No cambies analysis_options.yaml ni pubspec.lock.
Cuando termines, indícame qué archivo modificaste.
```

## Prompt 4

```text
Ahora sí ayúdame a implementar la regla para que pasen las pruebas nuevas y cambiasolo lo necesario en lib/domain/crear_reserva.dart.

No cambies:
- la firma de CrearReserva;
- la interfaz ReservasRepository;
- las pruebas;
- constitution.md;
- plan.md;
- analysis_options.yaml;
- pubspec.lock.

La idea es que antes de guardar una reserva revise las reservas existentes de esa misma sala.

Dos reservas se solapan si:
inicioNuevo < finExistente
y
finNuevo > inicioExistente.

Si hay solapamiento, debe rechazarse con exactamente este mensaje:
"La sala ya está reservada en ese horario."

Si una reserva empieza justo cuando termina otra, sí debe permitirse.

Haz solo lo necesario para cumplir esta regla y después ejecuta flutter test.
```

## Prompt 5

```text
Ahora ayúdame a crear RESPUESTAS.md en la raíz del proyecto. Debe tener exactamente estas tres secciones:

## Escenarios que elegí y por qué
## Riesgo más grave del repositorio
## ¿La regla protege la app real?

Quiero que quede corto y escrito de forma natural, como estudiante.

Usa evidencia real del repositorio y en cada afirmación importante cita la ruta y la línea, por ejemplo:
lib/domain/crear_reserva.dart:12

Para la primera sección explica por qué probé los distintos tipos de solapamiento y el caso donde una reserva empieza justo cuando termina otra.

Para la segunda, revisa cuál es el riesgo más grave que encontraste en el repositorio y justifícalo con evidencia.

Para la tercera, analiza si la regla realmente protege la app completa o solo el caso de uso CrearReserva. Recuerda que antes encontraste que la pantalla hace un insert directo en Supabase.

No inventes números de línea: revísalos en los archivos actuales.
Máximo unas 400 palabras en total.

No modifiques ningún otro archivo.
```

## Prompt 6

```text
Ahora crea prompts.md en la raíz del proyecto.

Pon ahí, en el mismo orden, todos los prompts que te envié enesta prueba, copiados exactamente, sin resumirlos ni corregirlos ni nadota.

No modifiques ningún otro archivo.
```
