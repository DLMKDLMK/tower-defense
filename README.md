# TowerDefense

Prototipo de un juego tower defense hecho con **Godot 4.7**. Está inspirado en Balloon Tower Defense y sirve para probar el recorrido de enemigos, el alcance de las torretas y los proyectiles.

## Estado del prototipo

La escena principal genera el recorrido a partir de las celdas pintadas en el mapa y crea globos con distintos puntos de vida. Las torretas genéricas detectan globos en su área de alcance, los siguen y disparan proyectiles que persiguen al objetivo.

El proyecto está en fase de prototipo: no incluye todavía un sistema de colocación de torres, economía, oleadas configurables ni interfaz de usuario.

## Requisitos y ejecución

- Godot **4.7**.
- Abre `project.godot` con Godot y ejecuta la escena principal (`scenes/main.tscn`) con **F6/F5** o el botón de ejecutar proyecto.

Al iniciar, se genera una tanda de 30 globos con una pausa inicial de 3 segundos y 0,5 segundos entre apariciones. La escena principal contiene tres torretas genéricas colocadas en el mapa.

## Estructura del proyecto

```text
assets/
  texture/       Spritesheets y recursos AtlasTexture de globos y torretas
  tileset/       Textura y TileSet del mapa
entities/
  balloon/       Escena y comportamiento del globo
  projectile/    Escena y comportamiento del proyectil genérico
  turret/        Escena y comportamiento de la torreta genérica
scenes/
  main.tscn      Escena principal y mapa de prueba
systems/
  map/           Generación del recorrido y aparición de globos
  constants.gd   Constantes globales
```

## Mapa y recorrido

El mapa usa dos capas `TileMapLayer` bajo `scenary`: `background` para el suelo visual y `path` para las celdas transitables. El generador calcula una ruta entre `t_start` y `t_end` usando las celdas de `path`, sin movimientos diagonales.

Para cambiar el trazado, edita las capas del mapa en `scenes/main.tscn`. Los extremos del recorrido se configuran desde las propiedades exportadas del nodo principal.

## Entidades

- **Globo (`entities/balloon`)**: recorre la ruta, tiene puntos de vida y cambia de textura según su vida. Al llegar al final o quedarse sin vida se elimina.
- **Torreta genérica (`entities/turret`)**: detecta globos dentro del área, selecciona un objetivo y dispara según el temporizador. Sus propiedades exportadas incluyen alcance, daño, velocidad de ataque, precio y escena de proyectil.
- **Proyectil genérico (`entities/projectile`)**: se mueve hacia el objetivo, aplica daño al impactar y se elimina.

Las capas físicas están nombradas en `project.godot`: `balloon`, `turret` y `projectile`.

## Ideas para continuar

- Añadir colocación de torretas en las zonas válidas del mapa.
- Completar interfaz, economía y gestión de oleadas.
- Configurar prioridades de selección de objetivos y comportamientos de proyectiles.
- Convertir valores de balance en recursos de datos cuando haya suficientes variantes.

## Créditos e inspiración

Proyecto de aprendizaje inspirado en **Balloon Tower Defense**. Los recursos gráficos se encuentran en `assets/`.
