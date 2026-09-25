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

--_A_--
SELECT Productos.nombre_producto, Categorias.nombre_categoria
FROM Productos
INNER JOIN Categorias ON Productos.id_categoria = Categorias.id_categoria
ORDER BY Productos.nombre_producto;

--_B_--
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


-- PREGUNTAS DE COMPROBACION --

- ¿Qué función tiene una PRIMARY KEY?
    -R= PRIMARY KEY nos ayuda en la tabla creada que contiene una columna llena de datos unicos e irrepetibles.

- ¿Qué diferencia existe entre PRIMARY KEY y FOREIGN KEY?
    -R= PRIMARY KEY lo utilizamos para indicar que los datos son unicos e irrepetibles, y FOREIN KEY nos ayuda
        para interlazar los registros de otras tablas para una tabla en especifico y poder cambiar una relacion
        N:M a 1:N o N:1

- ¿Por qué Productos contiene id_categoria e id_proveedor?
    -R= Esto para poder crear una relacion entre las 3 tablas (Productos, Categorias y Proveedores). 
        Esto para tener registros sin redundancia y optimizados. 
            
            Esto lo ocupamos para que las relaciones dadas se puedan dividir de una manera mejor:
            -> Un producto solo tiene una categoria, una categoria puede tener muchos productos.
            -> Un producto lo abastece varios proveedores, un proveedor abastece varios productos.

- ¿Por qué una venta no guarda directamente producto1, producto2, producto3, etc.?
    -R= Porque de esa manera se crearian varios registros vacios(nulos) o habria una cantidad exagerada de registros,
        obteniendo una base de datos con relaciones no soportados para SQL.

- ¿Qué problema resuelve Detalle_Venta?
    -R= "Detalle_Venta" actua como una tabla intermediaria entre las dos tablas con una relacion N:M.
        Al crear la tabla intermediaria evitamos tener datos duplicados o forzar al sistema guardar
        una gran cantidad de datos en una sola celda.

- ¿Qué hace WHERE?
    -R= Realiza una filtracion de datos almacenados en una columna de una tabla, lo utilizamos usualmente para
        que solo nos muestren los registros que cumplan una condicion establecida.

- ¿Qué diferencia existe entre ASC y DESC?
    -R= Ambas se ocupan para ordenar los datos, pero ASC los ordena de menor a mayor y DESC los ordena de mayor a menor.

- ¿Para qué sirve INNER JOIN?
    -R= Nos sirve para devolver solo las filas que tienen coincidencias en ambas tablas, generalmente se usa
        para hacer coincidir los ID de los clientes con los ID correpondientes a las compras que realizaron
        los clientes.

- ¿Qué función tiene GROUP BY?
    -R= Se utiliza para 