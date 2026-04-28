

# STUDYPLAY
### Motivar el aprendizaje mediante una experiencia interactiva y gamificada, facilitando el estudio en distintas áreas académicas.

StudyPlay es una aplicación móvil que transforma el aprendizaje en una experiencia interactiva mediante gamificación. Permite a los usuarios estudiar a través de trivias dinamicas, obtener recompensas y mejorar sus habitos de estudio en cualquier lugar buscando resolver el problema de la desmotivación en el aprendizaje tradicional, incorporando elementos de juego como puntos, niveles y logros

## CARACTERISTICAS PROPIAS DEL MÓVIL

* Notificaciones push inteligentes para recordar sesiones de estudio
* Acceso ubicuo (estudio en cualquier momento y lugar)
* Conectividad en tiempo real mediante Firebase
* Interacción dinámica con quizzes
* Interfaz táctil intuitiva 

## HISTORIAS DE USUARIO

* Como estudiante, quiero responder quizzes para practicar mis conocimientos
* Como estudiante, quiero y necesito tener recordatorios para estudiar y poder mejorar mis notas
* Como estudiante, me gustaria ganar puntos para motivarme a estudiar
* Como estudiante, me cuesta concentrarme, seria entretenido aprender de una forma menos rigida y más amigable para la gente que no logra concentrarse

## REQUERIMIENTO FUNCIONALES (RF)
* RF1: El sistema debe permitir responder quizzes
* RF2: El sistema debe mostar resultados al finalizar una actividad
* RF3: El sistema debe registrar el progreso dell usuario
* RF4: El sistema debe enviar notificaciones push
* RF5: El sistema debe mostar puntuación o un sistema de ranking entre usuarios

## REQUERIMIENTOS NO FUNCIONALES (RNF)
* RNF1: La aplicaciónn debe ser responsiva
* RNF2: La app debe funcionar en Android
* RNF3: La interfaz debe ser intuitiva
* RNF4: El tiempo de respuesta debe ser rapido
* RNF5: La app debe ser escalable


## DETALLE TÉCNICO

### La aplicación utiliza

* Flutter para el desarrollo de la interfaz
* Firebase para:
    * Auteticación
    * Base de datos en tiempo real
    * Notificaciones push
# Arquitectura:
Cliente(Flutter) ↔ Servidor(Firebase)

## TECNOLOGÍAS UTILIZADAS
* Flutter
* Dart
* Firebase
* Material Design

## Manual de uso

### MENU

* Presiona el icono jugar para acceder a los quiz
* Accede al historial desde la barra inferior boton izquierdo
* Accede al perfil del usuario desde la barra inferior boton derecho

### Pantalla de asignaturas

* Seleccionar materia para las preguntas

### Dentro del quiz

* Responder preguntas
* Obtener resultados al finalizar

### Historial

#### Ver partidas anteriores con: 
* Fecha
* Tiempo de juego
* Dificultad
* Asignatura
* Conteo de respuestas correctas e incorrectas

## Diagrama de flujo

[Diagrama](assets/images/diagrama.png)

[Link Diagrama](https://mermaid.ai/d/94ece48e-1112-4477-a783-1d48d7ebf778)

[RESEARCH.md](./RESEARCH.md)

### AUTOR
* Renato León
