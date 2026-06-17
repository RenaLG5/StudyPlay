# STUDYPLAY
### Motivar el aprendizaje mediante una experiencia interactiva y gamificada, facilitando el estudio en distintas áreas académicas.

StudyPlay es una aplicación móvil que transforma el aprendizaje en una experiencia interactiva mediante gamificación. Permite a los usuarios estudiar a través de trivias dinámicas, obtener recompensas y mejorar sus hábitos de estudio en cualquier lugar, abordando la desmotivación del aprendizaje tradicional mediante el uso de puntos, logros y progreso visual.

---

## CARACTERÍSTICAS PROPIAS DEL MÓVIL

* Notificaciones locales programadas.
* Acceso ubicuo (uso en cualquier momento y lugar).
* Interfaz táctil intuitiva.
* Interacción dinámica mediante quizzes.
* Navegación fluida entre pantallas.
* Uso de recursos visuales (iconos, imágenes y tarjetas).
* Efectos de sonido y vibración.
* Selección de imagen de perfil desde la galería.

---

## HISTORIAS DE USUARIO

* Como estudiante, quiero responder quizzes para practicar mis conocimientos.
* Como estudiante, quiero recibir recordatorios para estudiar.
* Como estudiante, quiero ganar logros para motivarme.
* Como estudiante, quiero revisar mi historial de partidas.
* Como estudiante, quiero ver mi perfil y progreso.

---

## REQUERIMIENTOS FUNCIONALES (RF)

* RF1: El sistema debe permitir responder quizzes.
* RF2: El sistema debe mostrar resultados al finalizar.
* RF3: El sistema debe registrar el historial de partidas.
* RF4: El sistema debe mostrar logros y recompensas.
* RF5: El sistema debe permitir navegación entre pantallas.
* RF6: El sistema debe mostrar información del perfil del usuario.
* RF7: El sistema debe mostrar ayuda y soporte.
* RF8: El sistema debe permitir iniciar y cerrar sesión.
* RF9: El sistema debe guardar configuraciones personalizadas.
* RF10: El sistema debe permitir cambiar la foto de perfil.
* RF11: El sistema debe almacenar respuestas de encuestas en Firebase.

---

## REQUERIMIENTOS NO FUNCIONALES (RNF)

* RNF1: La aplicación debe ser responsiva.
* RNF2: Debe funcionar en Android.
* RNF3: La interfaz debe ser intuitiva.
* RNF4: Tiempo de respuesta rápido.
* RNF5: Arquitectura escalable y modular.
* RNF6: Persistencia de datos entre sesiones.
* RNF7: Compatibilidad con Firebase.

---

## ARQUITECTURA Y PATRONES

La aplicación sigue una estructura modular:

lib/
├── controller/
├── data/
├── models/
├── services/
├── ui/
│   ├── screens/
│   └── widgets/
├── utils/
├── viewmodels/
└── main.dart


## Patrón MVVM
* Model: Representa los datos y entidades del sistema.
* View: Pantallas e interfaces gráficas.
* ViewModel: Gestiona la lógica y el estado de la aplicación.

## Gestión de estado

Se utiliza Provider para:

* Compartir datos entre pantallas.
* Actualizar la interfaz automáticamente.
* Gestionar el estado global de la aplicación.

## Persistencia local

Se utiliza SharedPreferences para almacenar:

* Nombre del usuario.
* Edad.
* País.
* Foto de perfil.
* Configuración de sonido.
* Configuración de notificaciones.
* Tema oscuro.
* Usuario actual.

## Persistencia en la nube

Se utiliza Firebase:

* Firebase Authentication para inicio de sesión.
* Cloud Firestore para:
  * Historial de partidas.
  * Progreso del usuario.
  * Logros.
  * Encuestas de calidad.
  * Encuestas de satisfacción.

---

## TECNOLOGÍAS UTILIZADAS

### Framework
* Flutter
* Dart
### Gestión de estado
* Provider
### Base de datos y autenticación
* Firebase Core
* Firebase Authentication
* Cloud Firestore
### Persistencia local
* SharedPreferences
### Multimedia
* Audioplayers
* Vibration
* Image Picker
### Compartir contenido
* Share Plus
### Diseño
* Material Design 3

---

## NAVEGACIÓN

La aplicación utiliza múltiples sistemas de navegación:

### Bottom Navigation Bar
* Historial
* Perfil
### Floating Action Button
* Recompensas y logros
### Floating Action Button (centro)
* Iniciar juego (JUGAR)

### Drawer (menú lateral ☰)
* Perfil
* Configuración
* Notificaciones (simuladas)
* Ayuda y soporte

---

## PANTALLAS DE LA APLICACIÓN

* Splash Screen (inicio)
* Menú principal
* Selección de asignaturas
* Quiz
* Resultado de partida
* Historial (lista)
* Detalle de partida (detalle)
* Perfil de usuario
* Recompensas (logros)
* Configuración
* Ayuda y soporte

---

## GAMIFICACIÓN

La aplicación incluye un sistema de logros:

* Rachas de estudio (5, 10, 50 días)
* Logros por asignatura
* Progreso por cantidad de quizzes
* Logros bloqueados/desbloqueados

---

## MANUAL DE USO

### Menú principal
* Presionar "JUGAR" para iniciar un quiz
* Usar barra inferior para acceder a historial o perfil
* Usar menú lateral para opciones adicionales

### Quiz
* Seleccionar asignatura
* Responder preguntas
* Visualizar resultados

### Historial
* Ver partidas anteriores con:
  - Fecha
  - Tiempo
  - Dificultad
  - Asignatura
  - Respuestas correctas/incorrectas

### Recompensas
* Visualizar logros obtenidos
* Ver logros bloqueados

### Perfil
* Ver información personal
* Imagen de usuario
* Datos básicos

### Ayuda
* Preguntas frecuentes
* Información de soporte

---

## DIAGRAMA DE FLUJO

```mermaid
flowchart TD


    A[Splash Screen] --> B[Menú Principal]

    B --> C[Jugar]
    B --> H[Historial]
    B --> P[Perfil]
    B --> R[Recompensas]
    B --> D[Menú lateral]

    D --> S[Configuración]
    D --> N[Notificaciones]
    D --> AY[Ayuda]

    C --> E[Seleccionar Asignatura]
    E --> F[Iniciar Quiz]
    F --> G[Responder Preguntas]
    G --> I[Resultados]
    I --> H

    R --> B
    P --> B
    S --> B
    AY --> B
```

### AUTOR
* Renato León
