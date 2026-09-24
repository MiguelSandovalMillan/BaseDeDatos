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
