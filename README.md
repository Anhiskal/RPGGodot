# Enemy AI System - Godot Project

## Descripción

Este proyecto corresponde a la implementación de un sistema de combate y comportamiento enemigo desarrollado en Godot 4 utilizando una arquitectura basada en componentes y una máquina de estados jerárquica (HSM).

El objetivo principal del ejercicio fue crear un enemigo capaz de:

- Patrullar una ruta definida por diseño.
- Detectar al jugador mediante un sistema de percepción.
- Perseguir al jugador cuando entra dentro del rango de detección.
- Atacar cuando el jugador se encuentra dentro del rango permitido.
- Recibir daño, aplicar efectos visuales y retroceso (knockback).
- Ejecutar una secuencia de muerte con efectos y destrucción controlada.

Además, se implementó un sistema preparado para escalar nuevos enemigos mediante configuración de datos, evitando duplicación de lógica.

---

# Tecnologías utilizadas

## Engine

- Godot Engine **4.6.2**

## Addons

### LimboAI 4.6

Utilizado para la implementación de la máquina de estados jerárquica (LimboHSM).

Repositorio:
https://github.com/limbonaut/limboai

---

# Instalación y ejecución

## Requisitos

- Godot Engine 4.6.2
- Addon LimboAI 4.6 instalado y habilitado.

## Pasos para ejecutar el proyecto

1. Clonar o descargar el repositorio.

2. Abrir Godot Engine 4.6.2.

3. Seleccionar: Scenes/main

4. Abrir el archivo: main.tscn

5. Verificar que el addon LimboAI se encuentre habilitado:

# Controles

## Movimiento del jugador

| Tecla | Acción |
|---|---|
| W | Movimiento hacia arriba |
| A | Movimiento hacia la izquierda |
| S | Movimiento hacia abajo |
| D | Movimiento hacia la derecha |

## Combate

| Tecla | Acción |
|---|---|
| J | Ataque 1 |
| I | Ataque 2 |
| K | Usar escudo |

---

# Arquitectura del proyecto

El proyecto fue diseñado utilizando una arquitectura basada en composición, separando responsabilidades en sistemas independientes.

La intención principal fue evitar una clase de enemigo monolítica y permitir reutilización de sistemas entre diferentes tipos de enemigos.

---

# Arquitectura del enemigo

Cada enemigo está compuesto por diferentes módulos:

Enemy
│
├── BrainLimbo
│
├── LimboHSM
│ ├── Idle State
│ ├── Patrol State
│ ├── Chase State
│ ├── Attack State
│ ├── Hurt State
│ └── Dead State
│
├── Components
│ ├── MovementComponent
│ ├── CombatComponent
│ ├── HealthComponent
│ ├── PatrolComponent
│ ├── AnimationComponent
│ ├── EffectsComponent
│ └── SoundComponent
│
└── Collision
├── Detection Area
└── Hurtbox

---

# Máquina de estados (LimboHSM)

El comportamiento del enemigo está controlado mediante una máquina de estados utilizando sistemas propios y LimboAI.

Los estados implementados son:

## Patrol

Responsable de:

- Seguir una ruta definida mediante Path2D.
- Detectar llegada a puntos.
- Esperar un tiempo configurable.
- Continuar hacia el siguiente punto.

---

## Chase

Responsable de:

- Seguir al jugador cuando es detectado.
- Evaluar distancia al objetivo.
- Solicitar transición al estado de ataque cuando corresponde.

---

## Attack

Responsable de:

- Detener el movimiento.
- Ejecutar animación de ataque.
- Sincronizar el daño con la animación.
- Esperar cooldown antes de permitir otro ataque.

El ataque está desacoplado del estado mediante señales:

Attack Animation
|
↓
Combat Component
|
↓
Hitbox Enable
|
↓
Damage Event

---

## Hurt

Responsable de:

- Recibir información del golpe.
- Ejecutar efectos visuales.
- Reproducir sonido.
- Aplicar knockback.

---

## Dead

Responsable de:

- Ejecutar efectos de muerte.
- Reproducir sonido final.
- Esperar finalización de efectos.
- Destruir el enemigo de forma segura.

---

# Diseño basado en componentes

Los sistemas principales fueron separados para favorecer mantenimiento y escalabilidad.

## MovementComponent

Responsabilidades:

- Controlar desplazamiento.
- Recibir órdenes desde estados.
- Mantener desacoplada la lógica de movimiento.

Ejemplo:

Patrol State
|
↓
MovementComponent
|
↓
CharacterBody2D

---

## CombatComponent

Responsabilidades:

- Controlar ataques.
- Manejar cooldown.
- Activar/desactivar hitboxes.
- Emitir eventos de combate.

No decide cuándo atacar, solamente ejecuta las acciones solicitadas.

---

## HealthComponent

Responsabilidades:

- Administrar vida.
- Emitir eventos de daño.
- Emitir evento de muerte.

---

## PatrolComponent

Responsabilidades:

- Administrar rutas de patrulla.
- Obtener puntos actuales.
- Controlar tiempos de espera.

La ruta puede modificarse desde el editor sin cambiar código.

---

# Data Driven Design

Los valores configurables del enemigo fueron separados mediante recursos:

Contiene información como:

- Vida máxima.
- Velocidad.
- Daño.
- Knockback.
- Rango de ataque.
- Configuración de muerte.

Esto permite crear diferentes enemigos reutilizando la misma lógica.

Ejemplo:

GoblinData

Health: 50
Damage: 10
Speed: 80

OrcData

Health: 150
Damage: 30
Speed: 50

Ambos utilizan los mismos componentes.

---

# Sistema de animaciones

Las animaciones son controladas mediante:

- AnimationTree.
- AnimationNodeStateMachine.
- EnemyAnimationController.

Los estados solicitan cambios de animación:

Ejemplo:

Patrol State
|
↓
AnimationController
|
↓
Run Animation


Esto mantiene los estados de gameplay independientes del sistema visual.

---

# Decisiones importantes de diseño

## Separación entre comportamiento y ejecución

Los estados no contienen lógica profunda de movimiento, combate o efectos.

Ejemplo:

Incorrecto:

AttackState
├── Crear daño
├── Activar collider
├── Manejar cooldown
└── Reproducir sonido

Implementación utilizada:

AttackState
|
↓
CombatComponent
|
↓
Damage / Hitbox / Cooldown

Esto permite reutilizar componentes.

---

## Uso de señales

Los sistemas se comunican mediante señales para reducir dependencias.

Ejemplo:

HealthComponent
|
↓
damaged signal
|
↓
Enemy Brain
|
↓
Hurt State

---

# Posibles extensiones

La arquitectura permite agregar fácilmente:

- Nuevos enemigos.
- Nuevos ataques.
- Diferentes armas.
- Estados adicionales.
- IA más avanzada.
- Sistemas de habilidades.
- Comportamientos especiales por enemigo.

Sin modificar los sistemas existentes.

---

# Autor

Jorge Alejandro Bueno Velez

Desarrollado como prueba técnica utilizando Godot Engine 4.6.2.

Arquitectura enfocada en:
- Escalabilidad.
- Mantenibilidad.
- Separación de responsabilidades.
- Sistemas reutilizables.
