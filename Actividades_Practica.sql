-- ===========================================================================
-- ==============================ACTIVIDADES==================================
-- ===========================================================================


-- ACTIVIDAD 1 - Registrar un nuevo cliente llamado Pedro Hernández --
INSERT INTO Clientes (id_cliente, nombre, apellidos, telefono, correo, ciudad) VALUES
(6,'Pedro','Hernández','4436666666', 'pedro@gmail.com', 'Morelia');


-- ACTIVIDAD 2 - Agregar Webcam HD --
INSERT INTO Productos (id_producto, nombre_producto, precio, existencia, id_categoria, id_proveedor) VALUES
(7, 'Webcam HD', 1200, 10, 2, 3);


-- ACTIVIDAD 3 - Mostrar clientes de Morelia --
SELECT * FROM Clientes WHERE ciudad = 'Morelia';


-- ACTIVIDAD 4 - Productos menores de $1,000 --
SELECT * FROM Productos
WHERE precio < 1000;


-- ACTIVIDAD 5 - Productos del más barato al más caro --
SELECT * FROM Productos
ORDER BY precio ASC;


-- ACTIVIDAD 6 - Productos con existencia menor de 15 --
SELECT * FROM Productos
WHERE existencia < 15;


-- ACTIVIDAD 7 - Obtener el producto más caro --
SELECT * FROM Productos
ORDER BY precio DESC
LIMIT 1;


-- ACTIVIDAD 8 - Obtener el promedio de precios --
SELECT AVG(precio) AS promedio_precio
FROM Productos;


-- ACTIVIDAD 9 - Mostrar producto y categoría --
SELECT Productos.nombre_producto, Categorias.nombre_categoria
FROM Productos
INNER JOIN Categorias ON Productos.id_categoria = Categorias.id_categoria
ORDER BY Productos.nombre_producto;

SELECT Productos.id_producto, Productos.nombre_producto,
    Categorias.nombre_categoria, Productos.precio, 
    Productos.existencia
FROM Productos
INNER JOIN Categorias
ON Productos.id_categoria = Categorias.id_categoria
ORDER BY Productos.nombre_producto;


-- ACTIVIDAD 10 - Mostrar cada venta con el nombre del cliente --
SELECT * FROM Ventas;
SELECT * FROM Clientes;
SELECT * FROM Detalle_Venta;

SELECT Ventas.id_venta, Ventas.id_cliente, 
    Clientes.nombre, Clientes.apellidos
FROM Ventas
INNER JOIN Clientes ON Ventas.id_cliente = Clientes.id_cliente
ORDER BY Ventas.id_venta;


