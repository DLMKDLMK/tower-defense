# TowerDefense

Prototipo de tower defense desarrollado con **Godot 4.7**, inspirado en Balloon Tower Defense. Incluye un mapa con recorrido generado desde sus celdas, globos con distintos puntos de vida, varias torres y proyectiles, oleadas automáticas y una interfaz con tiempo, oleada, vidas y dinero.

## Estado

Al iniciar, la partida comienza con 30 vidas y 500 monedas. Se generan hasta 30 oleadas de 30 globos, con medio segundo entre apariciones. Hay un catálogo de seis torres y varias escenas de torres ya colocadas en el mapa de prueba.

El proyecto sigue en fase de prototipo: la colocación y mejora de torres y la economía no están conectadas al juego. Los globos desaparecen al llegar al final de la ruta, pero todavía no descuentan vidas.

## Requisitos y ejecución

- Godot **4.7**.
- Abre `project.godot` con Godot y ejecuta el proyecto con **F6/F5** o el botón de ejecutar.

## Torres disponibles

Las seis definiciones aparecen en `data/t_definitions/` y se agrupan en el catálogo básico.

- **Dart (básica):** dispara dardos de impacto a un ritmo estándar; opción sencilla y económica.
- **Machine (ametralladora):** lanza clavos en rápida sucesión para cubrir una zona con muchos disparos.
- **Viking:** arroja un hacha que gira alrededor de la torre y puede golpear globos durante su recorrido.
- **Ninja:** lanza estrellas que persiguen al objetivo y pueden alcanzar a otros globos en el trayecto.
- **Cannon (cañón):** dispara una bomba de mayor daño que explota y daña a los globos cercanos.
- **Mage (mago):** lanza fuego que queda activo brevemente y daña a los globos que lo atraviesan.

## Mapa y recorrido

La escena `scenes/main.tscn` contiene dos capas `TileMapLayer` bajo `scenary`: `background` para el suelo y `path` para las celdas transitables. `systems/map/map_generator.gd` calcula un recorrido entre el inicio y el final usando las celdas dibujadas, sin diagonales. Edita esas capas en la escena principal para cambiar el trazado.

## Estructura

```text
assets/          Texturas, sprites y TileSet
autoload/        Gestor global de partida
data/            Definiciones de globos y torres; catálogo de torres
entities/        Globos, torres y proyectiles
scenes/          Escenas principal e interfaz
systems/map/     Generación de recorrido y aparición de globos
systems/         Constantes globales
```

El gestor global inicializa vidas, oleada, dinero y tiempo. La interfaz muestra esos valores; el tiempo y el número de oleada se actualizan durante la partida. Las capas físicas se nombran en `project.godot`.

## Créditos

Proyecto de aprendizaje inspirado en **Balloon Tower Defense**. Los recursos gráficos se encuentran en `assets/`.
