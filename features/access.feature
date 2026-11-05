# Credencial QR, control de ingresos y salidas, y registros sin conexión.
# US42–US43, US45–US46 y US54–US56.
# Pantallas W06 (Mi código QR), W15 (Ingresos y salidas) y W16 (Sincronización).
# La lectura del QR y la conexión son simuladas: no hay cámara ni servidor.

# language: es
Característica: Control de accesos con credencial QR
  Como coordinadora
  quiero registrar los ingresos y las salidas leyendo la credencial del voluntario
  para saber quién está dentro de la zona aunque no haya conexión.

  # US42
  Escenario: Ver mi credencial QR
    Dado que abro la demostración como voluntaria
    Cuando entro a "Mi código QR"
    Entonces veo el código QR de la credencial "ECQ-0248"
    Y el QR se dibuja en el navegador, no es una imagen del diseño

  # US42
  Escenario: Ver la credencial a pantalla completa
    Dado que estoy en "Mi código QR"
    Cuando pulso "Ver a pantalla completa"
    Entonces se abre la credencial "ECQ-0248" ampliada

  # US42
  Escenario: Descargar la credencial
    Dado que estoy en "Mi código QR"
    Cuando pulso "Descargar QR"
    Entonces se descarga el archivo "ECQ-0248.svg"

  # US42
  Escenario: La credencial indica si estoy dentro de la zona
    Dado que tengo un ingreso activo en "Playa Costa Azul"
    Cuando entro a "Mi código QR"
    Entonces la pantalla indica "Dentro de Playa Costa Azul"

  # US43
  Escenario: Leer una credencial simulada
    Dado que abro la demostración como coordinadora
    Y entro a "Ingresos y salidas"
    Cuando pulso "Simular escaneo"
    Entonces el campo "Código del voluntario" muestra "ECQ-0248"
    Y aparece el aviso "Credencial simulada leída."

  # US43
  Escenario: Rechazar una credencial desconocida
    Dado que escribo "ECQ-0000" en "Código del voluntario"
    Cuando pulso "Registrar"
    Entonces no se registra ningún movimiento
    Y aparece el aviso "Credencial no encontrada."

  # US45
  Escenario: Registrar el ingreso de un voluntario apto
    Dado que María completó registro, capacitación, asignación y EPP
    Y el modo de escaneo es "Ingreso"
    Cuando leo su credencial y pulso "Registrar"
    Entonces se registra su ingreso a la zona seleccionada
    Y María aparece en la tabla "Dentro de la zona"
    Y aparece el aviso "Ingreso registrado"

  # US45
  Escenario: Bloquear el ingreso sin EPP completo
    Dado que a María le faltan las botas de jebe
    Y el modo de escaneo es "Ingreso"
    Cuando leo su credencial y pulso "Registrar"
    Entonces no se registra el ingreso
    Y aparece el aviso "Ingreso bloqueado: completa registro, capacitación, asignación y EPP."

  # US45
  Escenario: Bloquear un ingreso duplicado
    Dado que María ya tiene un ingreso activo
    Y el modo de escaneo es "Ingreso"
    Cuando leo su credencial y pulso "Registrar"
    Entonces no se registra un segundo ingreso
    Y aparece el aviso "El voluntario ya tiene un ingreso activo."

  # US46
  Escenario: Registrar la salida desde la tabla
    Dado que María tiene un ingreso activo
    Cuando pulso "Registrar salida" en su fila
    Entonces se registra su salida
    Y María deja de aparecer en la tabla "Dentro de la zona"
    Y el contador de personas dentro de la zona baja en uno

  # US46
  Escenario: Rechazar una salida sin ingreso activo
    Dado que María no tiene un ingreso activo
    Cuando intento registrar su salida
    Entonces no se registra ningún movimiento
    Y aparece el aviso "El voluntario no tiene un ingreso activo."

  # US54
  Escenario: Activar el modo sin conexión
    Dado que estoy en cualquier pantalla de la demostración
    Cuando pulso "Simular sin conexión"
    Entonces aparece el aviso "Modo sin conexión simulado."

  # US55
  Escenario: Guardar un movimiento sin conexión
    Dado que el modo sin conexión está activo
    Y María cumple todos los requisitos de ingreso
    Cuando leo su credencial y pulso "Registrar"
    Entonces el movimiento queda guardado como pendiente
    Y aparece el aviso "Ingreso registrado · por sincronizar"

  # US55
  Escenario: Consultar los registros pendientes
    Dado que tengo dos movimientos sin sincronizar
    Cuando entro a "Sincronización"
    Entonces la cola muestra "2 registros"
    Y cada fila indica tipo, voluntario, zona, hora y el estado "En cola"

  # US56
  Escenario: Sincronizar al recuperar la conexión
    Dado que tengo movimientos pendientes
    Y recuperé la conexión
    Cuando pulso "Sincronizar ahora"
    Entonces todos los movimientos quedan sincronizados
    Y aparece el aviso "Sincronización simulada completada."

  # US56
  Escenario: No sincronizar sin conexión
    Dado que el modo sin conexión está activo
    Cuando pulso "Sincronizar ahora"
    Entonces los movimientos siguen pendientes
    Y aparece el aviso "Recupera la conexión para sincronizar."
