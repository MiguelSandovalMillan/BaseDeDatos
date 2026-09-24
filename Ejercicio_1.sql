CREATE TABLE Clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    apellidos TEXT NOT NULL,
    telefono TEXT,
    correo TEXT,
    ciudad TEXT
)


CREATE TABLE Proveedores (
    id_proveedor INTEGER PRIMARY KEY,
    nombre_proveedor TEXT NOT NULL,
    telefono TEXT,
    correo TEXT,
    ciudad TEXT
)


CREATE TABLE Categorias (
    id_categoria INTEGER PRIMARY KEY,
    nombre_categoria TEXT NOT NULL,
    descripcion TEXT
)


CREATE TABLE Productos (
    id_producto INTEGER PRIMARY KEY,
    nombre_producto TEXT NOT NULL,
    precio REAL NOT NULL,
    existencia INTEGER NOT NULL,
    id_categoria INTEGER,
    id_proveedor INTEGER,
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria),
    FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id_proveedor)
)


CREATE TABLE Ventas (
    id_venta INTEGER PRIMARY KEY,
    fecha TEXT NOT NULL,
    id_cliente INTEGER NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
)


CREATE TABLE Detalle_Venta (
    id_detalle INTEGER PRIMARY KEY,
    id_venta INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    precio_unitario REAL NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES Ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
)


===========================================================================
===========================================================================





INSERT INTO Clientes (id_cliente, nombre, apellidos, telefono, correo, ciudad) VALUES
(1,'Ana','López García','4431111111','ana@gmail.com','Morelia'),
(2,'Carlos','Martínez Pérez','4432222222','carlos@gmail.com','Morelia'),
(3,'María','González Torres','4433333333','maria@gmail.com','Pátzcuaro'),
(4,'José','Ramírez Hernández','4434444444','jose@gmail.com','Uruapan'),
(5,'Laura','Sánchez Mora','4435555555','laura@gmail.com','Morelia');