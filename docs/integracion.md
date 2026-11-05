# Qué cambió en `index.html` y `main.js`

La lógica de EPP, credencial QR, ingresos, salidas y sincronización salió de
`main.js` a dos módulos propios: `js/epp.js` y `js/access.js`. `main.js` pasó de
322 a 284 líneas y ya no contiene esa parte.

Estos dos archivos pertenecen a la integración general (parte 1). Este
documento existe para que el cambio sea revisable.

## Por qué

En la entrega original los seis integrantes compartían `main.js`. Cada commit
sobre ese archivo pisaba el de los demás. Separando la parte 6 en `js/`, sus
commits tocan archivos propios y el resto del equipo puede hacer lo mismo con su
área sin conflictos.

## `index.html`

Los módulos se cargan **antes** de `main.js`. `access.js` necesita `qr.js`.

```html
    <script src="qr.js"></script>
    <script src="js/epp.js"></script>     <!-- nuevo -->
    <script src="js/access.js"></script>  <!-- nuevo -->
    <script src="main.js"></script>
```

## `main.js`

### El objeto `ctx`

Los módulos no leen globales. Reciben el estado y los ayudantes en un objeto,
definido antes de `window.addEventListener('hashchange', render)` para que todas
las constantes ya existan:

```js
const ctx = {
  state, save, notice, render, openDialog, safe, EPP, modal,
  all, text, replace, read, setField, bind, caption, nativeSelect,
  selected, me, zone, requirements, ready, id
};
const modules = [window.ecqEPP, window.ecqAccess];
```

### Qué se movió

| Qué | Dónde estaba | Dónde está |
|---|---|---|
| `scanMode` | línea 46 | `js/access.js` |
| `writeAccess()` | línea 178 | `js/access.js` |
| `maps.w06`, `maps.w14`, `maps.w15`, `maps.w16` | línea 98 | `BUTTONS` de cada módulo |
| `setup()` bloques w06, w14, w15, w16 | 122, 151–158 | `setup()` de cada módulo |
| `setupLive()` bloques w14, w15, w16 | 298–316 | `live()` de cada módulo |
| 14 `case` del manejador de clics | ver tabla | `handle()` de cada módulo |

Los `case` movidos:

| `case` | Módulo | Línea original |
|---|---|---|
| `epp-history` | `js/epp.js` | 227 |
| `choose-volunteer` | `js/epp.js` | 237 |
| `select-volunteer` | `js/epp.js` | 238 |
| `deliver-epp` | `js/epp.js` | 239 |
| `return-epp` | `js/epp.js` | 240 |
| `verify` | `js/epp.js` | 241 |
| `offline` | `js/access.js` | 242 |
| `scan-mode` | `js/access.js` | 243 |
| `scan` | `js/access.js` | 244 |
| `access` | `js/access.js` | 245 |
| `exit` | `js/access.js` | 246 |
| `sync` | `js/access.js` | 247 |
| `qr-full` | `js/access.js` | 249 |
| `qr-download` | `js/access.js` | 250 |

### Los tres enganches

```js
// al final de setup()
 for(const module of modules) module.setup(page, ctx);

// al final de setupLive()
 for(const module of modules) module.live(page, ctx);

// en el manejador de clics, tras el if(action==='role') y antes del switch
 for(const module of modules){
  const result=module.handle(action,param,el,ctx);
  if(result==='render'){save();render();return;}
  if(result)return;
 }
```

Y el mapa de botones une los de los módulos:

```js
const maps={w02:{...}, ..., w13:{...},
            ...window.ecqEPP.BUTTONS, ...window.ecqAccess.BUTTONS};
```

El convenio de retorno de `handle()` conserva el comportamiento original: los
`case` que terminaban en `return` devuelven `'done'`, y los que terminaban en
`break` —y por tanto caían en `save();render();`— devuelven `'render'`.
`false` significa que la acción no es de ese módulo.

## Lo que **no** se movió

Sigue en `main.js` aunque pertenezca al recorrido de accesos, porque forma parte
de la carcasa compartida:

- `setupSidebar()` líneas 83–84: el enlace del interruptor «Simular sin
  conexión» con la acción `offline`. El manejador sí está en `js/access.js`.
- `setupSidebar()` línea 79: los destinos `'Mi código QR':'w06'`, `EPP:'w14'`,
  `'Ingresos y salidas':'w15'` y `Sincronización:'w16'`.
- `render()`: el cambio automático de rol según la pantalla.
- La constante `EPP` y el campo `requirements().EPP`, que comparte el
  especialista en W08 al definir el EPP obligatorio de cada actividad.
- Las líneas de EPP de la pantalla W05 (117, 120 y 293 del original), que son de
  la parte de tareas.

Ninguna pantalla de las otras cinco partes cambió. Los 34 `case` restantes del
manejador de clics siguen intactos.

## Cómo se comprobó

- `node --check` sobre `main.js`, `qr.js`, `js/epp.js` y `js/access.js`.
- 23 escenarios de `features/` ejecutados contra los módulos con un `ctx` de
  prueba: entrega, entrega duplicada, entrega sin tarea, verificación con y sin
  requisitos pendientes, devolución, devolución bloqueada por tarea en curso y
  por ingreso activo, historial vacío y con movimientos, credencial desconocida,
  ingreso apto, bloqueado y duplicado, salida, salida sin ingreso, modo sin
  conexión, cola de pendientes y sincronización con y sin conexión.
- Falta la comprobación visual en navegador de las tablas que se repueblan
  (W15 «Dentro de la zona» y W16 «Registros pendientes») y de los contadores del
  diseño.
