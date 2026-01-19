# Bar App - Gestor de Pedidos

Una aplicación Flutter  para la gestión de pedidos de un bar. En ella podrás crear, organizar y visualizar pedidos de bebidas y productos desglosados en las distintas mesas del bar.

---

## 📋 Tabla de Contenidos

- [Características](#características)
- [Requisitos Previos](#requisitos-previos)
- [Instalación](#instalación)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Arquitectura](#arquitectura)
- [Características Principales](#características-principales)
- [Tecnologías Utilizadas](#tecnologías-utilizadas)
- [Uso de la Aplicación](#uso-de-la-aplicación)

---

## Características

- **Creación de Pedidos**: Crear pedidos nuevos de manera rápida y sencilla
- **Selección de Productos**: Amplio catálogo de bebidas y productos disponibles
- **Resumen de Pedidos**: Visualizar en tiempo real el desglose de los pedidos
- **Gestión de Cantidades**: Ajustar cantidades de productos en los pedidos
- **Interfaz Intuitiva**: Diseño moderno con colores atractivos (tema rosa/magenta)
- **Historial de Pedidos**: Ver todos los pedidos creados y completados
- **Tipografía Personalizada**: Fuente Raleway para mejor legibilidad

---

## Requisitos Previos

Antes de comenzar, asegúrate de tener instalado:

- **Flutter**: v3.9.2 o superior
- **Dart**: v3.9.2 o superior
- **Git** (opcional, para control de versiones)
- Un editor como **VS Code** o **Android Studio**

---

## Instalación

### 1. Clonar el Repositorio

```bash
git clone https://github.com/AngelPG77/t4_1
cd t4_1
```

### 2. Obtener Dependencias

```bash
flutter pub get
```

### 3. Ejecutar la Aplicación

Para ejecutar en un dispositivo o emulador:

```bash
flutter run
```

Para ejecutar en plataforma específica:

```bash
# En Android
flutter run -d android

# En Web
flutter run -d chrome
```

---

## Estructura del Proyecto

```
lib/
├── main.dart                          # Punto de entrada de la aplicación
├── models/
│   ├── Producto.dart                  # Modelo de productos
│   ├── Pedido.dart                    # Modelo de pedidos
│   └── PedidoDetalle.dart             # Detalles de cada línea del pedido
├── viewModels/
│   ├── HomeViewModel.dart             # Lógica de la pantalla principal
│   ├── PedidoViewModel.dart           # Lógica de creación de pedidos
│   └── SeleccionViewModel.dart        # Lógica de selección de productos
└── views/
    ├── HomePage.dart                  # Pantalla principal
    ├── CrearPedidoScreen.dart         # Pantalla de creación de pedidos
    ├── SeleccionProductosScreen.dart  # Pantalla de selección de productos
    └── ResumenPedido.dart             # Pantalla de resumen del pedido

assets/
├── fonts/                             # Fuentes personalizadas
│   └── Raleway-*.ttf                  # Fuentes Raleway
└── icons/                             # Iconos de la aplicación
```

---

## Arquitectura

La aplicación sigue el patrón **MVVM (Model-View-ViewModel)**:

### **Models** 
Contienen la lógica de datos puros:
- `Producto`: Representa un producto con id, nombre y precio
- `Pedido`: Estructura principal de un pedido
- `PedidoDetalle`: Detalle de un pedido

### **ViewModels** 
Contienen la lógica empresarial:
- `HomeViewModel`: Gestiona el estado y datos de la pantalla principal
- `PedidoViewModel`: Controla la creación y modificación de pedidos
- `SeleccionViewModel`: Maneja la selección y búsqueda de productos

### **Views** 
Componentes visuales de Flutter:
- `HomePage`: Pantalla inicial con listado de pedidos
- `CrearPedidoScreen`: Interfaz para crear nuevos pedidos
- `SeleccionProductosScreen`: Catálogo y selección de productos
- `ResumenPedido`: Resumen detallado del pedido

---

## Características Principales

### Pantalla de Inicio
- Visualiza todos los pedidos existentes
- Opción para crear un nuevo pedido
- Acceso rápido a pedidos recientes

### Creación de Pedidos
- Interfaz intuitiva paso a paso
- Validación de datos en tiempo real
- Confirmación antes de finalizar

### Selección de Productos
- Catálogo completo de bebidas y productos
- Búsqueda y filtrado de productos
- Vista previa de precios

### Resumen del Pedido
- Desglose detallado de todos los items
- Cálculo automático de totales
- Historial de cambios

---

## Tecnologías Utilizadas

| Tecnología | Versión | Propósito |
|-----------|---------|----------|
| **Flutter** | 3.9.2+ | Framework de desarrollo multiplataforma |
| **Dart** | 3.9.2+ | Lenguaje de programación |
| **Material Design 3** | Incluido | Diseño y componentes UI |
| **Raleway Font** | - | Tipografía personalizada |

### Dependencias

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_launcher_icons: ^0.13.1
  flutter_lints: ^5.0.0
```

---

## Uso de la Aplicación

### 1. Iniciar la Aplicación
```bash
flutter run
```

### 2. Crear un Nuevo Pedido
- Toca el botón **"Nuevo Pedido"** en la pantalla principal
- Se abrirá la pantalla de creación

### 3. Seleccionar Productos
- Navega a través del catálogo de productos
- Selecciona los productos deseados
- Ajusta las cantidades según sea necesario

### 4. Revisar Resumen
- Visualiza el resumen completo del pedido
- Verifica precios y cantidades
- Confirma o edita si es necesario

### 5. Completar Pedido
- Una vez confirmado, el pedido se agrega al historial
- Puedes ver todos los pedidos en la pantalla principal

---

## Recomendaciones del chef

### Arroz con mandarina

Degusta nuestro plato experimental que aporta la energía del arroz con la dulzura de la mandarina

### Sopa de patata

Disfruta de la cocina tradicional humilde española, con un caldo suave y espeso y el sabor de la patata

**Versión**: 1.0.0  
**Última actualización**: Enero 2026  
**Estado**: Finalizado
