CREATE DATABASE IF NOT EXISTS MateWeb;
USE MateWeb;


 DROP TABLE IF EXISTS `Users`;
CREATE TABLE Users(
	`id` int AUTO_INCREMENT NOT NULL,
	`email` varchar(100) NOT NULL,
	`name` varchar(100) NOT NULL,
	`password` varchar(250) NOT NULL,
	`nombre` varchar(250) NULL,
	`imagen`  varchar(300) NULL,
	`dni` bigint NULL,
	`fechaNacimiento` date NULL,
	`telefono` varchar(50) NULL,
	`domicilio` varchar(100) NULL,
	`idLocalidad` int NULL,
	`idRol` int NOT NULL,
	`activo` Tinyint NOT NULL,	
	`google` Tinyint NOT NULL,	
	`created_at` datetime DEFAULT NULL,
	`updated_at` datetime DEFAULT NULL,
	`remember_token` varchar(255) COLLATE utf8_spanish2_ci DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `fk_Usuario_Localidad` (`idLocalidad`),
	KEY `fk_Usuario_Rol` (`idRol`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;
ALTER TABLE `Users`
  ADD CONSTRAINT `fk_Usuario_Localidad` FOREIGN KEY (`idLocalidad`) REFERENCES `localidads` (`id`);
ALTER TABLE `Users`
  ADD CONSTRAINT `fk_Usuario_Rol` FOREIGN KEY (`idRol`) REFERENCES `rols` (`id`);



DROP TABLE IF EXISTS `provincias`;
CREATE TABLE provincias(
	`id` int AUTO_INCREMENT NOT NULL,
	`descripcion` varchar(250) NOT NULL,
	PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

DROP TABLE IF EXISTS `localidads`; 
CREATE TABLE localidads(
	`id` int AUTO_INCREMENT NOT NULL,
	`descripcion` varchar(250) NOT NULL,
	`idProvincia` int NOT NULL,	
	PRIMARY KEY (`id`),
	KEY `fk_Localidad_Provincia` (`idProvincia`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;
ALTER TABLE `localidads`
  ADD CONSTRAINT `fk_Localidad_Provincia` FOREIGN KEY (`idProvincia`) REFERENCES `provincias` (`Id`);
 
 DROP TABLE IF EXISTS `rols`; 
CREATE TABLE rols(
	`id` int AUTO_INCREMENT NOT NULL,
	`descripcion` varchar(250) NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;
 
 DROP TABLE IF EXISTS `Users`;
CREATE TABLE Users(
	`id` int AUTO_INCREMENT NOT NULL,
	`email` varchar(100) NOT NULL,
	`name` varchar(100) NOT NULL,
	`password` varchar(250) NOT NULL,
	`nombre` varchar(250) NULL,
	`imagen`  varchar(300) NULL,
	`dni` bigint NULL,
	`fechaNacimiento` date NULL,
	`telefono` varchar(50) NULL,
	`domicilio` varchar(100) NULL,
	`idLocalidad` int NULL,
	`idRol` int NOT NULL,
	`activo` Tinyint NOT NULL,	
	`google` Tinyint NOT NULL,	
	`created_at` datetime DEFAULT NULL,
	`updated_at` datetime DEFAULT NULL,
	`remember_token` varchar(255) COLLATE utf8_spanish2_ci DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `fk_Usuario_Localidad` (`idLocalidad`),
	KEY `fk_Usuario_Rol` (`idRol`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;
ALTER TABLE `Users`
  ADD CONSTRAINT `fk_Usuario_Localidad` FOREIGN KEY (`idLocalidad`) REFERENCES `localidads` (`id`);
ALTER TABLE `Users`
  ADD CONSTRAINT `fk_Usuario_Rol` FOREIGN KEY (`idRol`) REFERENCES `rols` (`id`);
  
  DROP TABLE IF EXISTS `libros`;
CREATE TABLE libros(
	`id` int AUTO_INCREMENT NOT NULL,	
	`nombre`  varchar(30) NULL,	
	`descripcion`  varchar(300) NULL,
	`imagen`  varchar(300) NULL,
	`video`  varchar(300) NULL,
	`activo` Tinyint NULL,
	`created_at` datetime DEFAULT NULL,	
	`updated_at` datetime DEFAULT NULL,
	`idUsuario` int NOT NULL,	
PRIMARY KEY (`id`),
KEY `fk_Libro_Usuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;
ALTER TABLE `libros`
  ADD CONSTRAINT `fk_Libro_Usuario` FOREIGN KEY (`idUsuario`) REFERENCES `Users` (`id`);
 
 
DROP TABLE IF EXISTS `cursos`;
CREATE TABLE cursos(
	`id` int AUTO_INCREMENT NOT NULL,	
	`nombre`  varchar(30) NULL,	
	`descripcion`  varchar(300) NULL,
	`duracion`  varchar(300) NULL,
	`imagen`  varchar(300) NULL,
	`video`  varchar(300) NULL,
	`activo` Tinyint NULL,
	`created_at` datetime DEFAULT NULL,	
	`updated_at` datetime DEFAULT NULL,
	`idUsuario` int NOT NULL,	
PRIMARY KEY (`id`),
KEY `fk_Curso_Usuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;
ALTER TABLE `cursos`
  ADD CONSTRAINT `fk_Curso_Usuario` FOREIGN KEY (`idUsuario`) REFERENCES `Users` (`id`);

 DROP TABLE IF EXISTS `clases`;
CREATE TABLE clases(
	`id` int AUTO_INCREMENT NOT NULL,
	`nombre`  varchar(30) NULL,	
	`descripcion`  varchar(300) NULL,
	`duracion`  varchar(300) NULL,
	`imagen` varchar(300) NULL,
	`video`  varchar(300) NULL,
	`archivo` varchar(300) NULL,
	`orden` int NULL,
	`idCurso` int NOT NULL,
	`created_at` datetime DEFAULT NULL,
	`updated_at` datetime DEFAULT NULL,		
	`idUsuario` int NOT NULL,
	PRIMARY KEY (`id`),
	KEY `fk_Clase_Curso` (`idCurso`),
	KEY `fk_Clase_Usuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;
ALTER TABLE `clases`
  ADD CONSTRAINT `fk_Clase_Curso` FOREIGN KEY (`idCurso`) REFERENCES `cursos` (`id`);
  ALTER TABLE `clases`
  ADD CONSTRAINT `fk_Clase_Usuario` FOREIGN KEY (`idUsuario`) REFERENCES `Users` (`id`);

    DROP TABLE IF EXISTS `publicacions`;
CREATE TABLE publicacions(
	`id` int AUTO_INCREMENT NOT NULL,
	`idCurso` int NULL,
	`idLibro` int NULL,
	`precio` Double NOT NULL,	
	`nombre`  varchar(30) NULL,	
	`descripcion`  varchar(300) NULL,
	`activo` Tinyint NULL,
	`fechaDesde` date NOT NULL,
	`fechaHasta` date NULL,	
	`orden` int NULL,
	`novedad` Tinyint NULL,
	`created_at` datetime DEFAULT NULL,
	`updated_at` datetime DEFAULT NULL,		
	`idUsuario` int NOT NULL,
	PRIMARY KEY (`id`),	
	KEY `fk_Publicacion_Curso` (`idCurso`),
	KEY `fk_Publicacion_Libro` (idLibro),
	KEY `fk_Publicacion_Usuario` (`idUsuario`)	
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;
ALTER TABLE `publicacions`
  ADD CONSTRAINT `fk_Publicacion_Curso` FOREIGN KEY (`idCurso`) REFERENCES `cursos` (`id`);
  ALTER TABLE `publicacions`
  ADD CONSTRAINT `fk_Publicacion_Libro` FOREIGN KEY (`idLibro`) REFERENCES `libros` (`id`);
ALTER TABLE `publicacions`
  ADD CONSTRAINT `fk_Publicacion_Usuario` FOREIGN KEY (`idUsuario`) REFERENCES `Users` (`id`);
 
    DROP TABLE IF EXISTS `pagos`;
CREATE TABLE pagos(
	`id` int AUTO_INCREMENT NOT NULL,	
	`monto` Double NOT NULL,
	`factura`  varchar(300) NULL,	
	`created_at` datetime DEFAULT NULL,	
	`idUsuario` int NOT NULL,	
	PRIMARY KEY (`id`),	
	KEY `fk_Pago_Usuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;
ALTER TABLE `pagos`
  ADD CONSTRAINT `fk_Pago_Usuario` FOREIGN KEY (`idUsuario`) REFERENCES `Users` (`id`);
 
    DROP TABLE IF EXISTS `descuentos`;
CREATE TABLE descuentos(
	`id` int AUTO_INCREMENT NOT NULL,	
	`coeficiente` Double NOT NULL,
	`codigo` varchar(30) NOT NULL,
	`activo` Tinyint NULL,	
	`created_at` datetime DEFAULT NULL,
	`updated_at` datetime DEFAULT NULL,		
	`idUsuario` int NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;
ALTER TABLE `descuentos`
  ADD CONSTRAINT `fk_Descuento_Usuario` FOREIGN KEY (`idUsuario`) REFERENCES `Users` (`id`);
  
     DROP TABLE IF EXISTS `ventas`;
CREATE TABLE ventas(
	`id` int AUTO_INCREMENT NOT NULL,	
	`idPublicacion` int NOT NULL,	
	`idDescuento` int NULL,	
	`created_at` datetime DEFAULT NULL,	
	`idUsuario` int NOT NULL,
	PRIMARY KEY (`id`),	
	KEY `fk_Venta_Publicacion` (`idPublicacion`),
	KEY `fk_Venta_Descuento` (`idDescuento`),
	KEY `fk_Venta_Usuario` (`idUsuario`)	
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;
ALTER TABLE `ventas`
  ADD CONSTRAINT `fk_Venta_Publicacion` FOREIGN KEY (`idPublicacion`) REFERENCES `publicacions` (`id`);
  ALTER TABLE `ventas`
  ADD CONSTRAINT `fk_Venta_Descuento` FOREIGN KEY (`idDescuento`) REFERENCES `descuentos` (`id`);
ALTER TABLE `ventas`
  ADD CONSTRAINT `fk_Venta_Usuario` FOREIGN KEY (`idUsuario`) REFERENCES `Users` (`id`);

     DROP TABLE IF EXISTS `pagoVentas`;	
CREATE TABLE pagoVentas(
	`id` int AUTO_INCREMENT NOT NULL,	
	`idPago` int NOT NULL,
	`idVenta` int NOT NULL,
	`created_at` datetime DEFAULT NULL,
	`idUsuario` int NOT NULL,
	PRIMARY KEY (`id`),	
	KEY `fk_PagoVenta_Pago` (`idPago`),
	KEY `fk_PagoVenta_Venta` (`idVenta`),
KEY `fk_PagoVenta_Usuario` (`idUsuario`)	
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;
ALTER TABLE `pagoVentas`
  ADD CONSTRAINT `fk_PagoVenta_Pago` FOREIGN KEY (`idPago`) REFERENCES `pagos` (`id`);
ALTER TABLE `pagoVentas`
  ADD CONSTRAINT `fk_PagoVenta_Venta` FOREIGN KEY (`idVenta`) REFERENCES `ventas` (`id`);
  ALTER TABLE `pagoVentas`
  ADD CONSTRAINT `fk_PagoVenta_Usuario` FOREIGN KEY (`idUsuario`) REFERENCES `Users` (`id`);
  

 