Feature: Gestión de Zonas y Evaluación de Riesgos (Zonas y Riesgos)
  Como Especialista Ambiental
  Quiero registrar y consultar zonas afectadas, clasificar niveles de riesgo, definir actividades permitidas y comunicar alertas
  Para proteger la seguridad de los voluntarios y organizar la intervención ante la emergencia

  # US14: Registrar recomendación de seguridad
  Scenario: Publicar una recomendación técnica de seguridad para una zona
    Given que el especialista ambiental se encuentra evaluando las condiciones en "Playa Costa Azul"
    When ingresa la recomendación técnica "Usa todo tu EPP. Punto de encuentro: caseta de salvavidas norte"
    And guarda las condiciones generales
    Then el sistema debe asociar la recomendación a la ficha de la zona
    And la recomendación debe quedar visible para los coordinadores y voluntarios

  # US15: Actualizar recomendaciones
  Scenario: Actualizar las recomendaciones ante cambios en el entorno
    Given que la zona "Playa Costa Azul" cuenta con recomendaciones previas
    When el especialista detecta oleaje anómalo y actualiza la indicación a "Evitar la línea de rompiente de olas"
    And guarda los cambios realizados
    Then el sistema debe actualizar la recomendación a la versión vigente
    And los voluntarios asignados a la zona deben ver la recomendación actualizada

  # US16: Registrar zona afectada
  Scenario: Registro exitoso de una nueva zona afectada en la emergencia
    Given que el especialista ambiental se encuentra en la pantalla de "Zonas afectadas"
    When ingresa el nombre de la zona "Playa Ventanilla sur"
    And ingresa las coordenadas de ubicación GPS "-11.8761, -77.1532"
    And selecciona el tipo de emergencia "Derrame de hidrocarburos"
    And define el nivel de riesgo "Alto"
    And añade la descripción "Crudo en la orilla y en las rocas; olor intenso"
    And presiona el botón "Registrar zona"
    Then la nueva zona debe agregarse a la lista de "Zonas registradas"
    And debe mostrarse con un pin de ubicación en el mapa interactivo

  Scenario: Intento de registro sin completar el nombre obligatorio de la zona
    Given que el especialista se encuentra en el formulario "Nueva zona afectada"
    When deja el campo "Nombre de la zona" vacío
    And presiona el botón "Registrar zona"
    Then el sistema no debe registrar la zona
    And debe mostrar un mensaje indicando que el nombre es un dato obligatorio

  # US17: Definir nivel de riesgo
  Scenario: Asignación de nivel de riesgo a una zona evaluada
    Given que el especialista concluye la inspección de una zona afectada
    When selecciona el nivel de riesgo "Alto"
    And guarda el registro de la zona
    Then el sistema debe registrar el nivel de riesgo con el indicador visual en color rojo
    And debe reflejar que solo se permitirá el ingreso con EPP completo y experiencia

  # US18: Registrar riesgos identificados
  Scenario: Registrar un nuevo peligro identificado en la zona
    Given que el especialista está en la sección "Riesgos identificados" de "Playa Costa Azul"
    When presiona el botón "Añadir"
    And ingresa el peligro "Contacto y vapores tóxicos" con severidad "Alto"
    Then el nuevo peligro debe listarse en la tarjeta de riesgos activos de la zona

  Scenario: Marcar un riesgo como mitigado o resuelto
    Given que la zona tiene registrado el riesgo "Gases en zona de acopio"
    When las cuadrillas culminan la ventilación y el especialista verifica la seguridad
    Then el riesgo debe mostrarse con la etiqueta "Resuelto" e indicador verde

  # US19: Definir actividades permitidas
  Scenario: Habilitar y restringir actividades en la zona
    Given que el especialista revisa la tabla de "Actividades y requisitos"
    When activa la actividad "Limpieza de arena" como permitida
    And desactiva "Rescate de fauna" indicando restricción por "oleaje fuerte"
    And presiona el botón "Guardar condiciones"
    Then las condiciones deben quedar registradas en el sistema
    And los coordinadores no podrán asignar tareas en actividades no permitidas

  # US20: Definir experiencia requerida
  Scenario: Configurar el nivel de experiencia requerido para una actividad
    Given que la actividad "Contener crudo" requiere preparación técnica
    When el especialista selecciona el nivel de experiencia "Avanzada"
    And presiona "Guardar condiciones"
    Then el sistema debe vincular dicho requisito a la actividad
    And no permitirá asignar voluntarios sin experiencia a esa tarea

  Scenario: Configurar una actividad que no requiere experiencia previa
    Given que el especialista evalúa la actividad "Limpieza de arena"
    When selecciona la opción "No requiere experiencia"
    And guarda los cambios
    Then la actividad debe quedar habilitada para voluntarios generales y espontáneos

  # US23: Actualizar estado de una zona
  Scenario: Modificación del estado operativo de una zona
    Given que la zona "Bahía Blanca" se encuentra en estado "En evaluación"
    When el especialista concluye la inspección técnica y determina que no es segura
    And actualiza el estado de la zona a "No apta"
    Then la lista de zonas debe mostrar la etiqueta "No apta" con indicador de alerta
    And deben suspenderse las autorizaciones de ingreso a dicha playa

  # US35: Definir EPP requerido
  Scenario: Definir el equipo de protección personal obligatorio
    Given que la actividad "Limpieza de arena" presenta contacto con hidrocarburos
    When el especialista selecciona los implementos obligatorios "Guantes de nitrilo", "Mascarilla N95" y "Botas de jebe"
    And presiona el botón "Guardar condiciones"
    Then el sistema debe exigir estos implementos como requisito obligatorio
    And los coordinadores deberán verificar su entrega antes de autorizar el ingreso

  # US60: Comunicar actualización de riesgo
  Scenario: Publicación y emisión de alerta de seguridad en tiempo real
    Given que el especialista ambiental se encuentra en la pantalla "Comunicar actualización de riesgo"
    When selecciona el nuevo nivel de riesgo y redacta el motivo del cambio
    And presiona el botón "Publicar actualización"
    Then el sistema debe registrar la actualización con la hora correspondiente
    And debe enviar una notificación inmediata a los coordinadores y voluntarios de la zona
