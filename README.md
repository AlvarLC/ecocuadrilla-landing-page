# EcoCuadrilla · implementación del Figma

Landing y demo web en HTML, CSS y JavaScript. Sin instalación de paquetes ni compilación.

## Ejecutar en Windows

1. Extrae el ZIP y abre la carpeta `ecocuadrilla-figma` en VS Code.
2. En la terminal de esa carpeta ejecuta:

```powershell
py -m http.server 5500
```

3. Abre http://localhost:5500. También puedes usar Live Server.

Es necesario un servidor local porque las pantallas se cargan desde `pages/`. No abras `index.html` directamente con `file://`.

## Diseño

Referencia: Figma `f0sIxBHt0DQPAVskX8MFOa`.

- Landing de escritorio: frame 279:783, 1440 × 7723.
- Landing móvil: frame 288:1656, 360 × 10565.
- Demo: 16 pantallas web W01–W16 del diseño, con menú lateral y recursos originales.
- La landing se escala proporcionalmente al ancho de la ventana. La demo conserva la composición de escritorio; en móvil permite desplazamiento horizontal.
- Los textos, cantidades y estados cambian cuando realizas acciones en la demo. Las vistas adicionales de alertas, tareas y recomendaciones reutilizan la estructura visual; no tienen un frame independiente de referencia.

## Archivos

- `index.html`: entrada.
- `pages/`: secciones y pantallas originales convertidas a HTML.
- `figma.css`: estilos de los componentes del diseño, ya compilados.
- `styles.css`: tipografía local, contenedores y controles nativos.
- `main.js`: interacción y datos de demostración compartidos por los tres roles.
- `qr.js`: genera el QR de demostración ECQ-0248.
- `assets/`: SVG originales y fuentes Inter con licencia.
- `docs/`: mapa de pantallas, historias y comprobaciones.

## Recorrido

1. Probar la demo → Voluntaria. Completa el celular del contacto, acepta el uso de datos ficticios y continúa.
2. Guarda experiencia, habilidades y disponibilidad. Confirma los módulos de seguridad.
3. Mi tarea permanece bloqueada mientras falte EPP.
4. Cambia de rol desde el avatar. Como coordinadora, abre EPP y registra la entrega a María.
5. Como voluntaria, inicia y finaliza la tarea; consulta y descarga su QR.
6. Como coordinadora, crea una tarea, selecciona candidatos compatibles y asigna sin superar la capacidad.
7. Como especialista, registra zonas y riesgos, define condiciones de una actividad y comunica cambios de seguridad.
8. En Ingresos y salidas usa «Simular escaneo». El ingreso exige registro, capacitación, tarea y EPP completos. «Simular sin conexión» deja movimientos pendientes para una sincronización simulada.

Los datos son ficticios y se guardan en `sessionStorage`: sobreviven a la recarga de la misma pestaña, y se eliminan al cerrar su sesión. No hay autenticación, servidor de datos ni sincronización real entre personas. Los videos y el APK requieren los archivos finales del equipo; sus botones informan cuando todavía no están añadidos.

## Sustituir la versión anterior

Haz una copia de seguridad de tu carpeta actual. Copia todos los archivos y carpetas de esta entrega dentro de `D:\repos\ecocuadrilla-landing-page`, reemplazando los archivos del mismo nombre. Conserva `.git`. No mezcles el `index.html` anterior con los estilos nuevos. Este ZIP no cambia ramas ni realiza commits o push.
