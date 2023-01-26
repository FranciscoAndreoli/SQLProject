CREATE DATABASE hoteldb;

USE hoteldb;

CREATE TABLE `beneficios_empleado` (
  `id_beneficios_empleado` int NOT NULL AUTO_INCREMENT,
  `bonoNavideno` tinyint NOT NULL,
  `obraSocial` tinyint NOT NULL,
  `trabajoRemoto` tinyint NOT NULL,
  `licenciaPaternal` tinyint NOT NULL,
  `gym_membresia` tinyint NOT NULL,
  `empleado_id` int NOT NULL,
  PRIMARY KEY (`id_beneficios_empleado`),
  KEY `fk_beneficios_empleado_empleado1_idx` (`empleado_id`),
  CONSTRAINT `fk_beneficios_empleado_empleado1` FOREIGN KEY (`empleado_id`) REFERENCES `empleado` (`id_empleado`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `categoria_habitacion` (
  `id_categoria_habitacion` int NOT NULL AUTO_INCREMENT,
  `categoria` varchar(15) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `numHabitacion` int NOT NULL,
  PRIMARY KEY (`id_categoria_habitacion`),
  KEY `fk_estadoHabitacion_habitacion1_idx` (`numHabitacion`),
  CONSTRAINT `fk_estadoHabitacion_habitacion1` FOREIGN KEY (`numHabitacion`) REFERENCES `habitacion` (`numHabitacion`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `apellido` varchar(50) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `numero_documento` int NOT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `contacto_cliente` (
  `id_contacto_cliente` int NOT NULL AUTO_INCREMENT,
  `correoElectronico` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `cliente_id` int NOT NULL,
  PRIMARY KEY (`id_contacto_cliente`),
  UNIQUE KEY `correoElectronico_UNIQUE` (`correoElectronico`),
  KEY `fk_contactoCliente_cliente_idx` (`cliente_id`),
  CONSTRAINT `fk_contactoCliente_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `contacto_empleado` (
  `id_contactoEmpleado` int NOT NULL AUTO_INCREMENT,
  `direccion` varchar(50) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `correoElectronico` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `empleado_id` int NOT NULL,
  PRIMARY KEY (`id_contactoEmpleado`),
  UNIQUE KEY `telefono_UNIQUE` (`telefono`),
  KEY `fk_contactoEmpleado_empleado1_idx` (`empleado_id`),
  CONSTRAINT `fk_contactoEmpleado_empleado1` FOREIGN KEY (`empleado_id`) REFERENCES `empleado` (`id_empleado`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `credenciales_empleado` (
  `id_credenciales` int NOT NULL AUTO_INCREMENT,
  `usuario` varchar(45) NOT NULL,
  `contraseña` varchar(45) NOT NULL,
  `status` varchar(45) NOT NULL,
  `empleado_id` int NOT NULL,
  PRIMARY KEY (`id_credenciales`),
  KEY `fk_credenciales_empleado1_idx` (`empleado_id`),
  CONSTRAINT `fk_credenciales_empleado1` FOREIGN KEY (`empleado_id`) REFERENCES `empleado` (`id_empleado`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `cuotas` (
  `id_cuotas` int NOT NULL AUTO_INCREMENT,
  `numDeCuotas` int unsigned NOT NULL,
  `monto` decimal(10,0) unsigned NOT NULL,
  `interes` decimal(10,0) unsigned DEFAULT NULL,
  `fecha` date NOT NULL,
  `pago_id` int NOT NULL,
  PRIMARY KEY (`id_cuotas`),
  KEY `fk_cuotas_pago1_idx` (`pago_id`),
  CONSTRAINT `fk_cuotas_pago1` FOREIGN KEY (`pago_id`) REFERENCES `pago` (`id_pago`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `departamento_empleado` (
  `id_departamento` int NOT NULL AUTO_INCREMENT,
  `nombreDpto` varchar(20) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`id_departamento`),
  UNIQUE KEY `nombreDpto_UNIQUE` (`nombreDpto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `empleado` (
  `id_empleado` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `puestoTrabajo` varchar(50) NOT NULL,
  `hotel_cuil` int unsigned NOT NULL,
  `departamento_id` int NOT NULL,
  PRIMARY KEY (`id_empleado`),
  KEY `fk_empleado_hotel1_idx` (`hotel_cuil`),
  KEY `fk_empleado_departamento1_idx` (`departamento_id`),
  CONSTRAINT `fk_empleado_departamento1` FOREIGN KEY (`departamento_id`) REFERENCES `departamento_empleado` (`id_departamento`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_empleado_hotel1` FOREIGN KEY (`hotel_cuil`) REFERENCES `hotel` (`cuil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `empleado_info_adicional` (
  `id_info_adicional` int NOT NULL AUTO_INCREMENT,
  `fechaInicioContrato` date NOT NULL,
  `fechaFinContrato` date DEFAULT NULL,
  `sueldoMensual` decimal(10,0) unsigned NOT NULL,
  `empleado_id` int NOT NULL,
  PRIMARY KEY (`id_info_adicional`),
  KEY `fk_empleado_info_adicional_empleado1_idx` (`empleado_id`),
  CONSTRAINT `fk_empleado_info_adicional_empleado1` FOREIGN KEY (`empleado_id`) REFERENCES `empleado` (`id_empleado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `habitacion` (
  `numHabitacion` int NOT NULL AUTO_INCREMENT,
  `numeroDePiso` int NOT NULL,
  `descripcion` tinytext NOT NULL,
  `id_reserva` int NOT NULL,
  `hotel_cuil` int unsigned NOT NULL,
  PRIMARY KEY (`numHabitacion`),
  KEY `fk_habitacion_reserva1_idx` (`id_reserva`),
  KEY `fk_habitacion_hotel1_idx` (`hotel_cuil`),
  CONSTRAINT `fk_habitacion_hotel1` FOREIGN KEY (`hotel_cuil`) REFERENCES `hotel` (`cuil`),
  CONSTRAINT `fk_habitacion_reserva1` FOREIGN KEY (`id_reserva`) REFERENCES `reserva` (`id_reserva`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `hotel` (
  `cuil` int unsigned NOT NULL,
  `nombreHotel` varchar(50) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `correoElectronico` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`cuil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pago` (
  `id_pago` int NOT NULL,
  `concepto` varchar(70) NOT NULL,
  `montoTotal` decimal(10,0) unsigned NOT NULL,
  `fecha` date NOT NULL,
  `reserva_id` int NOT NULL,
  `cliente_id` int NOT NULL,
  PRIMARY KEY (`id_pago`),
  KEY `fk_pago_reserva1_idx` (`reserva_id`),
  KEY `fk_pago_cliente1_idx` (`cliente_id`),
  CONSTRAINT `fk_pago_cliente1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pago_reserva1` FOREIGN KEY (`reserva_id`) REFERENCES `reserva` (`id_reserva`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `reserva` (
  `id_reserva` int NOT NULL AUTO_INCREMENT,
  `fechaLlegada` date NOT NULL,
  `fechaSalida` date NOT NULL,
  `precio` decimal(10,0) unsigned NOT NULL,
  `cliente_id` int NOT NULL,
  PRIMARY KEY (`id_reserva`),
  KEY `fk_reserva_cliente1_idx` (`cliente_id`),
  CONSTRAINT `fk_reserva_cliente1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `servicio_extra_habitacion` (
  `id_servicio_Extra` int NOT NULL AUTO_INCREMENT,
  `servicio` varchar(50) NOT NULL,
  `num_habitacion` int NOT NULL,
  `pago_id` int NOT NULL,
  PRIMARY KEY (`id_servicio_Extra`),
  KEY `fk_servicioExtra_habitacion1_idx` (`num_habitacion`),
  KEY `fk_servicioExtra_pago1_idx` (`pago_id`),
  CONSTRAINT `fk_servicioExtra_habitacion1` FOREIGN KEY (`num_habitacion`) REFERENCES `habitacion` (`numHabitacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_servicioExtra_pago1` FOREIGN KEY (`pago_id`) REFERENCES `pago` (`id_pago`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
