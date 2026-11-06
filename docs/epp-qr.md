# EPP y códigos QR · mapa de la parte 6

Daniel Ruben Gutierrez Galvez. Pantallas W06, W14, W15 y W16.

## Archivos de esta parte

```
js/epp.js                   Entrega, consulta, verificación y devolución de EPP
js/access.js                QR, ingresos, salidas, modo sin conexión y sincronización
qr.js                       Generador de QR 1-L en SVG
pages/w06.html              Mi código QR
pages/w14.html              EPP
pages/w15.html              Ingresos y salidas
pages/w16.html              Sincronización simulada
features/equipment.feature  Escenarios de aceptación de EPP
features/access.feature     Escenarios de aceptación de accesos
docs/integracion.md         Qué cambió en index.html y main.js
```

## Historias y dónde se demuestran

| Historia | Qué cubre | Pantalla | Archivo |
|---|---|---|---|
| US36 | Registrar entrega de EPP | W14 | `js/epp.js` · `handle('deliver-epp')` |
| US37 | Consultar EPP recibido | W14 | `js/epp.js` · `live()` |
| US38 | Verificar EPP antes del ingreso | W14 | `js/epp.js` · `handle('verify')` |
| US39 | Registrar devolución de EPP | W14 | `js/epp.js` · `handle('return-epp')` |
| US40 | Consultar entregas de EPP | W14 | `js/epp.js` · `handle('epp-history')` |
| US42 | Credencial QR del voluntario | W06 | `js/access.js` · `setup()`, `qr.js` |
| US43 | Lectura simulada de la credencial | W15 | `js/access.js` · `handle('scan')` |
| US45 | Registrar ingreso a la zona | W15 | `js/access.js` · `writeAccess()` |
| US46 | Registrar salida de la zona | W15 | `js/access.js` · `writeAccess()`, `live()` |
| US54 | Modo sin conexión | todas | `js/access.js` · `handle('offline')` |
| US55 | Registros pendientes en cola | W16 | `js/access.js` · `live()` |
| US56 | Sincronización simulada | W16 | `js/access.js` · `handle('sync')` |

Los números US42–US43, US45–US46 y US54–US56 vienen del reparto del equipo.
**No aparecen en `docs/historias.md` de la entrega**, que solo llega hasta US40
y US60. Los títulos de esta tabla describen lo que el código hace; conviene
contrastarlos con el informe antes de darlos por buenos, y añadir las filas que
falten a `docs/historias.md`.

## Reglas de negocio implementadas

- Un ingreso exige **registro, capacitación, asignación y EPP** completos
  (`requirements()` de `main.js`). Si falta alguno, se rechaza con el motivo.
- No se admite un segundo ingreso sin una salida previa, ni una salida sin
  ingreso activo.
- Solo se entrega el EPP que la **actividad de la zona** exige y que el
  voluntario aún no tiene.
- No se admite devolución con la tarea «En curso» o con un ingreso activo.
- Sin conexión, el movimiento se guarda con `synced: false` y queda en la cola
  de W16. «Sincronizar ahora» solo funciona con conexión.

## Estado que usa esta parte

| Campo | Dónde se crea | Para qué |
|---|---|---|
| `state.records[]` | `writeAccess()` | Ingresos y salidas, con `synced` |
| `state.equipmentHistory[]` | `deliver-epp`, `return-epp` | Historial de EPP |
| `state.offline` | `handle('offline')` | Modo sin conexión simulado |
| `volunteer.epp[]` | `deliver-epp`, `return-epp` | Índices sobre la constante `EPP` |
| `volunteer.inside` | `writeAccess()` | Ingreso activo |

`state.records`, `state.equipmentHistory` y `state.offline` se inicializan en
`main.js` (línea 43). Todo vive en `sessionStorage`: sobrevive a la recarga de
la pestaña y se borra al cerrarla. No hay servidor ni sincronización real.

## Contrato `ctx`

Los módulos no leen globales de `main.js`. Reciben:

```js
{state, save, notice, render, openDialog, safe, EPP, modal,
 all, text, replace, read, setField, bind, caption, nativeSelect,
 selected, me, zone, requirements, ready, id}
```

Cada módulo expone `BUTTONS`, `setup(page, ctx)`, `live(page, ctx)` y
`handle(action, param, el, ctx)`. `handle` devuelve `'done'` (ya terminó),
`'render'` (guardar y repintar) o `false` (no es suyo). Ver `docs/integracion.md`.

## Solapamientos con otras partes

- **W05 · Mi tarea** (Diego) muestra el contador de EPP recibido y el bloqueo de
  «Iniciar tarea» sin EPP. Esa lógica se queda en `main.js` (líneas 117, 120 y
  293), aunque toque US37/US38.
- **W08 · Condiciones** (Jethro) define qué EPP exige cada actividad. Escribe
  `activity.epp`, que es lo que esta parte lee.
- El interruptor «Simular sin conexión» se enlaza en `setupSidebar()` de
  `main.js`; el manejador está en `js/access.js`.
