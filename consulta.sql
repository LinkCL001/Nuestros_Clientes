-- 1. Cargar el respaldo de la base de datos unidad2.sql. (2 Puntos)
-- DROP DATABASE unidad2;

CREATE DATABASE unidad2;
psql -U postgres unidad2 < unidad2.sql


-- 2. El cliente usuario01 ha realizado la siguiente compra:
-- ● producto: producto9.
-- ● cantidad: 5.
-- ● fecha: fecha del sistema.
-- Mediante el uso de transacciones, realiza las consultas correspondientes para este
-- requerimiento y luego consulta la tabla producto para validar si fue efectivamente
-- descontado en el stock. (3 Puntos)

BEGIN TRANSACTION;
INSERT INTO compra(id, cliente_id, fecha) VALUES (33, 1, '2021-11-18');
INSERT INTO detalle_compra (id, producto_id, compra_id, cantidad) VALUES (43, 9, 33, 5);
UPDATE producto SET stock = stock - 5 WHERE id = 9;
COMMIT;

SELECT * FROM producto;

-- 3. El cliente usuario02 ha realizado la siguiente compra:
-- ● producto: producto1, producto 2, producto 8.
-- ● cantidad: 3 de cada producto.
-- ● fecha: fecha del sistema.
-- Mediante el uso de transacciones, realiza las consultas correspondientes para este
-- requerimiento y luego consulta la tabla producto para validar que si alguno de ellos
-- se queda sin stock, no se realice la compra. (3 Puntos)

BEGIN TRANSACTION;
INSERT INTO compra(id, cliente_id, fecha) VALUES (34, 2, '2021-11-18');
INSERT INTO detalle_compra (id, producto_id, compra_id, cantidad) VALUES (44, 1, 34, 3), (45, 2, 34, 3), (46, 8, 34, 3);
UPDATE producto SET stock = stock - 3 WHERE id = 1;
UPDATE producto SET stock = stock - 3 WHERE id = 2;
UPDATE producto SET stock = stock - 3 WHERE id = 8;
COMMIT;

SELECT * FROM producto;

-- 4. Realizar las siguientes consultas (2 Puntos):
-- a. Deshabilitar el AUTOCOMMIT.

\set AUTOCOMMIT off;

-- b. Insertar un nuevo cliente.
SAVEPOINT savepoint;
INSERT INTO cliente(id, nombre , email) VALUES (11, 'Juan
Gonzalez', 'usuario011@hotmail.com');

-- c. Confirmar que fue agregado en la tabla cliente.

SELECT * FROM cliente;

-- d. Realizar un ROLLBACK.

ROLLBACK TO savepoint;

-- e. Confirmar que se restauró la información, sin considerar la inserción del punto b

SELECT * FROM cliente;

-- f. Habilitar de nuevo el AUTOCOMMIT.
\set AUTOCOMMIT on;