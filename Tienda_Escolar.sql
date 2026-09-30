DROP TABLE IF EXISTS Detalle_Venta;
DROP TABLE IF EXISTS Ventas;
DROP TABLE IF EXISTS Productos;
DROP TABLE IF EXISTS Clientes;
DROP TABLE IF EXISTS Proveedores;
DROP TABLE IF EXISTS Categorias;


CREATE TABLE Categorias (
	id_categoria INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre_categoria VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE Proveedores (
	id_proveedor INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre_proveedor VARCHAR(100) NOT NULL,
	ciudad VARCHAR(60) NOT NULL
);

CREATE TABLE Clientes (
	id_cliente INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre_cliente VARCHAR(100) NOT NULL,
	grupo VARCHAR(10) NOT NULL
);


CREATE TABLE Productos (
	id_producto INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre_producto VARCHAR(100) NOT NULL,
	precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
	existencia INTEGER NOT NULL CHECK (existencia >= 0),
	id_categoria INTEGER NOT NULL,
	id_proveedor INTEGER NOT NULL,
	FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria),
	FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id_proveedor)
);


CREATE TABLE Ventas (
	id_venta INTEGER PRIMARY KEY AUTOINCREMENT,
	fecha DATE NOT NULL,
	id_cliente INTEGER NOT NULL,
	FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);


CREATE TABLE Detalle_Venta (
	id_venta INTEGER NOT NULL,
	id_producto INTEGER NOT NULL,
	cantidad INTEGER NOT NULL CHECK (cantidad > 0),
	precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario > 0),
    PRIMARY KEY (id_venta, id_producto),
	FOREIGN KEY (id_venta) REFERENCES Ventas(id_venta),
	FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);


-- ===========================================================================
-- =========================INSERTAR_DATOS====================================
-- ===========================================================================


INSERT INTO Categorias (nombre_categoria) VALUES
	('Papelería'), ('Tecnología'), ('Bebidas');



INSERT INTO Proveedores (nombre_proveedor, ciudad) VALUES
	('Distribuidora Escolar', 'Morelia'),
	('Tecnología del Centro', 'Morelia'),
	('Bebidas del Bajío', 'Pátzcuaro');


INSERT INTO Clientes (nombre_cliente, grupo) VALUES
	('Ana López', '1A'),
	('Luis Pérez', '1B'),
	('María Torres', '2A'),
	('Carlos Ruiz', '2B');


INSERT INTO Productos (nombre_producto, precio, existencia, id_categoria, id_proveedor) VALUES
	('Cuaderno', 35.00, 40, 1, 1),
	('Lápiz', 8.00, 100, 1, 1),
	('Memoria USB', 120.00, 12, 2, 2),
	('Agua', 15.00, 50, 3, 3);


INSERT INTO Ventas (fecha, id_cliente) VALUES
	('2026-09-01', 1),
	('2026-09-02', 2),
	('2026-09-03', 1),
	('2026-09-04', 3);


INSERT INTO Detalle_Venta (id_venta, id_producto, cantidad, precio_unitario) VALUES
	(1, 1, 2, 35.00),
	(1, 2, 3, 8.00),
	(2, 3, 1, 120.00),
	(2, 4, 2, 15.00),
	(3, 2, 1, 8.00),
	(4, 1, 1, 35.00);


-- ===========================================================================
-- ========================COMPROBACION DE CONTEOS============================
-- ===========================================================================


SELECT 'Categorias' AS tabla, COUNT(*) AS registros FROM Categorias
UNION ALL
SELECT 'Proveedores', COUNT(*) FROM Proveedores
UNION ALL
SELECT 'Clientes', COUNT(*) FROM Clientes
UNION ALL
SELECT 'Productos', COUNT(*) FROM Productos
UNION ALL
SELECT 'Ventas', COUNT(*) FROM Ventas
UNION ALL
SELECT 'Detalle_Venta', COUNT(*) FROM Detalle_Venta;


-- ===========================================================================
-- ================================CONSULTAS==================================
-- ===========================================================================


-- 1. Mostrar todos los clientes.
SELECT * FROM Clientes;

-- 2. Mostrar nombre, precio y existencia de los productos.
SELECT nombre_producto, precio, existencia 
FROM Productos;

-- 3. Encontrar los productos con precio menor a $50.
SELECT nombre_producto, precio 
FROM Productos 
WHERE precio < 50;

-- 4. Encontrar los productos con existencia menor a 15 unidades.
SELECT nombre_producto, existencia 
FROM Productos 
WHERE existencia < 15;

-- 5. Ordenar los productos del más caro al más barato.
SELECT nombre_producto, precio 
FROM Productos 
ORDER BY precio DESC;

-- 6. Mostrar los clientes del grupo 1A.
SELECT * FROM Clientes 
WHERE grupo = '1A';

-- 7. Contar los productos registrados.
SELECT COUNT(*) AS total_productos 
FROM Productos;

-- 8. Calcular el precio promedio de todos los productos, con dos decimales.
SELECT ROUND(AVG(precio), 2) AS precio_promedio 
FROM Productos;

-- 9. Mostrar el producto más caro y su precio.
SELECT nombre_producto, precio FROM Productos 
ORDER BY precio DESC 
LIMIT 1;

-- 10. Mostrar cada producto junto con el nombre de su categoría.
SELECT productos.nombre_producto, categorias.nombre_categoria
FROM Productos 
JOIN Categorias ON Productos.id_categoria = Categorias.id_categoria;

-- 11. Mostrar cada producto junto con el nombre de su proveedor.
SELECT productos.nombre_producto, proveedores.nombre_proveedor
FROM Productos 
JOIN Proveedores ON Productos.id_proveedor = Proveedores.id_proveedor;

-- 12. Mostrar número de venta, fecha y nombre del cliente.
SELECT ventas.id_venta, ventas.fecha, clientes.nombre_cliente
FROM Ventas
JOIN Clientes ON Ventas.id_cliente = Clientes.id_cliente;

-- 13. Mostrar producto, cantidad y precio unitario de la venta 1.
SELECT productos.nombre_producto, detalle_venta.cantidad, detalle_venta.precio_unitario
FROM Detalle_Venta
JOIN Productos ON Detalle_Venta.id_producto = Productos.id_producto
WHERE Detalle_Venta.id_venta = 1;

-- 14. Calcular el importe total de cada venta: SUM(cantidad * precio_unitario).
SELECT id_venta, SUM(cantidad * precio_unitario) AS importe_total
FROM Detalle_Venta
GROUP BY id_venta;

-- 15. Calcular lo gastado por cada cliente, incluso quienes no han comprado; mostrar cero para estos últimos.
SELECT clientes.nombre_cliente, 
    COALESCE(SUM(detalle_venta.cantidad * detalle_venta.precio_unitario), 0) AS total_gastado
FROM Clientes
LEFT JOIN Ventas ON Clientes.id_cliente = Ventas.id_cliente
LEFT JOIN Detalle_Venta ON Ventas.id_venta = Detalle_Venta.id_venta
GROUP BY clientes.id_cliente, clientes.nombre_cliente;


-- ===========================================================================
-- ================================PREGUNTAS==================================
-- ===========================================================================


-- ¿Por qué una venta puede tener varios registros en Detalle_Venta?
--  R= Esto pasa porque un cliente puede comprar varios productos en una sola venta.


-- ¿Por qué se conserva precio_unitario en Detalle_Venta, aunque Productos tenga precio?
--  R= Para registrar el precio al momento de la venta, ya que el precio de un producto puede cambiar con el tiempo.


-- ¿Qué diferencia hay entre JOIN y LEFT JOIN al buscar clientes sin compras?
--  R= "JOIN" solo devuelve solo los registros que tienen coincidencias en ambas tablas,
--     en cambio "LEFT JOIN" devuelve todos los registros de la tabla izquierda "CLIENTES" y los registros coincidentes de la tabla derecha "VENTAS", 
--     mostrando NULL para aquellos clientes que no han realizado compras.


-- ¿Qué error esperas al usar en Ventas un id_cliente inexistente?
--  R= Un error en la clave foránea, ya que el "id_cliente" debe existir en la tabla "CLIENTES" sino no habra ninguna relacion.


-- ¿Qué ventaja tiene separar Categorías y Proveedores de Productos?
--  R= Nos ayuda para la organización de los datos, evita la redundancia y facilita las relaciones entre tablas.