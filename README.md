# Dorado Frontend - Calculadora de Intercambio de Criptomonedas - Challenge tecnico

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

Una mini aplicación moderna y multiplataforma desarrollada en Flutter para cálculos de intercambio de criptomonedas entre monedas FIAT y CRYPTO. Construida con principios de Arquitectura Limpia e integración de tasas de cambio en tiempo real.

## 🚀 Características

- **Tasas de Cambio en Tiempo Real**: Tasas de conversión en vivo entre monedas FIAT y CRYPTO
- **Soporte Multi-Moneda**:
  - **FIAT**: Real Brasileño (BRL), Peso Colombiano (COP), Sol Peruano (PEN), Bolívar Venezolano (VES)
  - **CRYPTO**: TATUM-TRON-USDT
- **Entrada Inteligente de Montos**: Detección automática de separadores de miles vs decimales
- **Multiplataforma**: Funciona en Android, iOS, Web, Windows, macOS y Linux
- **UI/UX Limpia**: Diseño moderno con interfaz intuitiva de conversión de monedas
- **Actualizaciones en Tiempo Real**: Los resultados se reinician automáticamente cuando cambia la entrada
- **Respaldo Sin Conexión**: Datos de prueba para demostración cuando la API no está disponible


## 🏗️ Arquitectura

Este proyecto sigue los principios de **Arquitectura Limpia** con organización basada en características:

```
lib/
├── core/                    # Infraestructura compartida
│   ├── api/                # Cliente HTTP y configuración de API
│   └── models/             # Modelos de datos compartidos
│
├── features/
│   └── conversion/         # Característica de conversión de moneda
│       ├── data/           # Capa de datos
│       │   ├── dto/        # Objetos de Transferencia de Datos
│       │   └── repo/       # Implementaciones de repositorio
│       ├── domain/         # Capa de lógica de negocio
│       │   ├── entities/   # Entidades de negocio
│       │   ├── repositories/ # Interfaces de repositorio
│       │   └── usecases/   # Casos de uso
│       └── presentation/   # Capa de UI
│           ├── notifier/   # Gestión de estado (Riverpod)
│           ├── pages/      # Páginas de UI
│           └── widgets/    # Widgets reutilizables
│
├── utils/                  # Utilidades y auxiliares
│   └── theme/              # Temas de la aplicación
│
└── main.dart               # Punto de entrada de la aplicación
```

### Decisiones Arquitectónicas Clave

- **Gestión de Estado**: Riverpod para gestión de estado reactiva
- **Inyección de Dependencias**: Proveedores de Riverpod
- **Cliente HTTP**: Dio con Retrofit para llamadas API type-safe
- **Generación de Código**: Soporte integrado para serialización JSON y clientes API
- **Formato de Números**: Paquete Intl para formato de monedas

## 🛠️ Stack Tecnológico

### Dependencias Core

- **flutter_riverpod**: Solución de gestión de estado
- **dio & retrofit**: Cliente HTTP e integración API type-safe
- **flutter_dotenv**: Configuración de entorno
- **intl**: Internacionalización y formato de números

### Herramientas de Desarrollo

- **build_runner**: Generación de código
- **retrofit_generator**: Generación de cliente API
- **json_annotation & json_serializable**: Serialización JSON

## Inicio Rápido

### Prerrequisitos

- Flutter 3.0 o superior
- Dart 3.0 o superior
- Android Studio / VS Code
- Git

### Instalación

1. **Clonar el repositorio**

   ```bash
   git clone https://github.com/tu-usuario/dorado-frontend.git
   cd dorado-frontend
   ```

2. **Instalar dependencias**

   ```bash
   flutter pub get
   ```

3. **Generar código**

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Ejecutar la aplicación**

   ```bash
   # Ejecutar en tu plataforma preferida
   flutter run                    # Dispositivo conectado
   flutter run -d web            # Navegador web
   flutter run -d android        # Emulador Android
   flutter run -d ios           # Simulador iOS
   ```

### Configuración del Entorno

Crear un archivo `.env` en el directorio raíz:

```env
API_BASE_URL=https://74j6q7lg6a.execute-api.eu-west-1.amazonaws.com/stage
```


## 🏢 Integración API

La aplicación se integra con una API pública de tasas de cambio:

- **URL Base**: `https://74j6q7lg6a.execute-api.eu-west-1.amazonaws.com/stage/orderbook/public/recommendations`
- **Parámetros**:
  - `type`: 0 (CRYPTO→FIAT) o 1 (FIAT→CRYPTO)
  - `cryptoCurrencyId`: Identificador de criptomoneda
  - `fiatCurrencyId`: Identificador de moneda FIAT
  - `amount`: Monto a convertir
  - `amountCurrencyId`: Identificador de moneda de entrada


### Estándares de Codificación

- Seguir convenciones de Dart/Flutter
- Usar nombres significativos para variables y funciones
- Actualizar documentación según sea necesario
- Asegurar principios de arquitectura limpia

## 📝 Detalles de Estructura del Proyecto

### Capa Core (`lib/core/`)

- **API**: Configuración de cliente HTTP y servicios API
- **Models**: Modelos de datos compartidos utilizados en las características
- **Utils**: Clases utilitarias y funciones auxiliares
- **Theme**: Temas y estilos de la aplicación

### Capa de Características (`lib/features/conversion/`)

- **Data**: Fuentes de datos externos, DTOs, implementaciones de repositorio
- **Domain**: Entidades de negocio, interfaces de repositorio, casos de uso
- **Presentation**: Componentes UI, gestión de estado, interacciones de usuario

## 🐛 Problemas Conocidos

- La API ocasionalmente devuelve respuestas vacías (manejado con datos de prueba)
- Algunas monedas pueden tener actualizaciones de tasa retrasadas

## 📄 Licencia

Este proyecto está licenciado bajo la Licencia MIT - consulta el archivo [LICENSE](LICENSE) para más detalles.

**Hecho con ❤️ por Abraham Jimenez usando Flutter**