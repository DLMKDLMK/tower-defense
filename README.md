# Tower Defense

Prototipo de tower defense para un jugador, desarrollado con **Godot 4.7** e inspirado en Balloon Tower Defense. La escena principal contiene un mapa, un recorrido, globos, torres, oleadas y una interfaz con vidas, dinero, tiempo y número de oleada.

## Alcance y estado

El alcance de esta versión es una partida en un único mapa y de hasta 30 oleadas. El código incluye la lógica principal de oleadas, globos, recompensas, compra y colocación de torres, modo automático y venta de torres. La prioridad de cierre es mostrar la derrota cuando se agotan las vidas.

No se requiere una pantalla de victoria ni una acción de reinicio para cerrar este prototipo. Las mejoras de torres también quedan fuera del alcance.

## Contenido implementado

- Una partida comienza con **50 vidas** y **500 monedas**.
- Hay hasta **30 oleadas**. El tamaño crece de **11 globos en la primera** a **80 en la última**, con medio segundo entre apariciones.
- Hay globos de entre 1 y 7 puntos de vida. Al llegar al final del recorrido, un globo resta sus puntos de vida actuales; al destruirlo, entrega la recompensa definida para su tipo.
- Se puede iniciar la siguiente oleada manualmente o activar el modo automático.
- El catálogo tiene **nueve torres**: Dart, Machine, Viking, Ninja, Cannon, Mage, Ship, Snack Nails y Pineapple.
- La colocación comprueba el tipo de terreno y evita solapamientos con otras torres. Las torres colocadas se pueden vender por la mitad de su precio de compra.
- Las torres normales atacan desde el terreno; Ship se coloca sobre agua, y Snack Nails y Pineapple sobre el recorrido.

Los valores de daño, alcance, cadencia, precio, velocidad y recompensa se ajustan en los recursos de datos de cada torre y globo. Se ha aplicado una primera pasada de balance; necesita comprobarse jugando en Godot.

## Pendiente para cerrar el prototipo

1. Comprobar en ejecución la pantalla de derrota y que las vidas muestren cero.
2. Revisar selección, colocación, cancelación de previsualización y venta de torres, además del cambio entre oleadas manuales y automáticas.
3. Validar la primera pasada de balance y ajustar los datos después de jugar varias oleadas.

## Fuera del alcance

Esta versión no incluye:

- Mejoras, niveles o árboles de habilidades para las torres.
- Pantalla de victoria y reinicio de partida.
- Más mapas, campaña, progresión persistente o guardado de partidas.
- Menú de inicio, ajustes de juego o selección de niveles.
- Nuevas familias de globos especiales o sistemas de contenido posteriores a las 30 oleadas.

## Requisitos y ejecución

- Godot **4.7**.
- Abre `project.godot` con Godot y ejecuta el proyecto con **F6/F5** o el botón de ejecutar.

## Mapa y recorrido

La escena `scenes/main.tscn` contiene dos capas `TileMapLayer` bajo `scenary`: `background` para los tipos de terreno y `path` para el recorrido. `systems/map/map_generator.gd` busca un camino entre las celdas inicial y final usando movimientos ortogonales, sin diagonales. Edita las capas en la escena principal para cambiar el trazado.

## Estructura

```text
assets/          Texturas, sprites y TileSet
autoload/        Gestor global de partida
data/            Definiciones de globos y torres; catálogo de torres
entities/        Globos, torres y proyectiles
scenes/          Escenas principal e interfaz
systems/map/     Generación del recorrido y aparición de globos
systems/         Constantes globales
```

## Créditos

Proyecto de aprendizaje inspirado en **Balloon Tower Defense**. Los recursos gráficos se encuentran en `assets/`.
