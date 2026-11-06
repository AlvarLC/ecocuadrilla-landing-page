# Entrega, consulta, verificación y devolución de EPP. US36–US40.
# Pantalla W14 (Coordinadora → EPP). Datos ficticios en sessionStorage.

# language: es
Característica: Registro de EPP
  Como coordinadora
  quiero registrar qué equipo de protección recibe y devuelve cada voluntario
  para que nadie ingrese a la zona sin su equipo obligatorio.

  Antecedentes:
    Dado que abro la demostración como coordinadora
    Y entro a la pantalla "EPP"
    Y el voluntario seleccionado es "María Quispe Rojas"
    Y su tarea asignada exige guantes de nitrilo, mascarilla N95 y botas de jebe

  # US36
  Escenario: Registrar la entrega del EPP que falta
    Dado que María ya recibió los guantes de nitrilo y la mascarilla N95
    Cuando pulso "Registrar entrega"
    Entonces se registra la entrega de las botas de jebe
    Y el contador muestra "3 de 3"
    Y aparece el aviso "Entrega de EPP registrada."

  # US36
  Escenario: No repetir una entrega ya completa
    Dado que María recibió los tres elementos obligatorios
    Cuando pulso "Registrar entrega"
    Entonces no se añade ningún movimiento al historial
    Y aparece el aviso "El equipo ya está completo."

  # US36
  Escenario: Entregar EPP sin tarea asignada
    Dado que selecciono un voluntario sin tarea asignada
    Cuando pulso "Registrar entrega"
    Entonces no se registra ninguna entrega
    Y aparece el aviso "Asigna una tarea primero."

  # US37
  Escenario: Consultar el EPP recibido por el voluntario
    Cuando abro el panel "EPP requerido"
    Entonces cada elemento obligatorio aparece como "Entregado" o "Pendiente"
    Y el elemento que aún no recibió aparece como "Pendiente"

  # US38
  Escenario: Verificar antes del ingreso con un requisito pendiente
    Dado que a María le faltan las botas de jebe
    Cuando pulso "Verificar de nuevo"
    Entonces la verificación muestra "EPP: pendiente"
    Y la pantalla indica "No puede ingresar a la zona"

  # US38
  Escenario: Verificar antes del ingreso con todo cumplido
    Dado que María completó registro, capacitación, asignación y EPP
    Cuando pulso "Verificar de nuevo"
    Entonces los cuatro requisitos aparecen como "cumplido"
    Y la pantalla indica "Puede ingresar a la zona"

  # US39
  Escenario: Registrar la devolución del EPP
    Dado que María finalizó su tarea y registró su salida
    Cuando pulso "Registrar devolución"
    Entonces su EPP queda vacío
    Y el historial suma un movimiento de tipo "Devolución" por cada elemento
    Y aparece el aviso "Devolución registrada."

  # US39
  Escenario: Rechazar la devolución con la tarea en curso
    Dado que la tarea de María está "En curso"
    Cuando pulso "Registrar devolución"
    Entonces su EPP no cambia
    Y aparece el aviso "Finaliza la tarea y registra la salida antes de devolver EPP."

  # US39
  Escenario: Rechazar la devolución con un ingreso activo
    Dado que María tiene un ingreso activo en la zona
    Cuando pulso "Registrar devolución"
    Entonces su EPP no cambia
    Y aparece el aviso "Finaliza la tarea y registra la salida antes de devolver EPP."

  # US40
  Escenario: Consultar el historial de entregas y devoluciones
    Dado que registré una entrega y una devolución en esta sesión
    Cuando abro "Entregas recientes"
    Entonces veo cada movimiento con voluntario, tipo, elemento y fecha

  # US40
  Escenario: Historial vacío al empezar
    Dado que no registré movimientos en esta sesión
    Cuando abro "Entregas recientes"
    Entonces veo el texto "Aún no hay movimientos en esta sesión."

  # US37
  Escenario: Cambiar de voluntario sin salir de la pantalla
    Cuando pulso "Cambiar voluntario"
    Y elijo "Carla Mendoza"
    Entonces la pantalla muestra el EPP de "Carla Mendoza"
