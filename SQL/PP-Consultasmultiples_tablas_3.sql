					-- CONSULTAS MULTIPLES TABLAS 3 --


/*En esta lección de pair programming vamos a continuar trabajando sobre la base de datos Northwind.
Hoy prondremos en práctica sentencias como UNION, UNION ALL, INTERSECT o EXCEPT.
Para esta práctica te hara falta crear en algunos de los ejercicios una columna temporal.
Para ver como funciona esta creación de columnas temporales prueba el siguiente código:
SELECT  'Hola!'  AS tipo_nombre
FROM customers;*/

 USE northwind;

SELECT  'Hola!'  AS tipo_nombre
FROM customers;

/*Enunciados*/
/* 1)Extraer toda la información sobre las compañias que tengamos en la BBDD
Nuestros jefes nos han pedido que creemos una query que nos devuelva todos los clientes y proveedores que tenemos en la BBDD.
Mostrad la ciudad a la que pertenecen, el nombre de la empresa y el nombre del contacto, además de la relación (Proveedor o Cliente). 
Pero importante! No debe haber duplicados en nuestra respuesta. La columna Relationship no existe y debe ser creada como columna temporal. 
Para ello añade el valor que le quieras dar al campo y utilizada como alias Relationship.
Nota: Deberás crear esta columna temporal en cada instrucción SELECT.*/

SELECT city AS Ciudad, company_name AS Nombre, contact_name AS Contacto, 'customers' AS Relationship 
FROM customers
UNION
SELECT city AS Ciudad, company_name AS Nombre, contact_name As Contacto,'suppliers' AS  Relationship 
FROM suppliers;



/*2)Extraer todos los pedidos gestinados por "Nancy Davolio"
En este caso, nuestro jefe quiere saber cuantos pedidos ha gestionado "Nancy Davolio", una de nuestras empleadas.
Nos pide todos los detalles tramitados por ella.*/

SELECT *
FROM orders
WHERE employee_id IN (
					SELECT employee_id
                    FROM employees
                    WHERE first_name = "Nancy");


/*3)Extraed todas las empresas que no han comprado en el año 1997
En este caso, nuestro jefe quiere saber cuántas empresas no han comprado en el año 1997.
💡 Pista 💡 Para extraer el año de una fecha, podemos usar el estamento year. Más documentación sobre este método.*/

SELECT company_name AS NombreEmpresa, country
FROM customers
WHERE customer_id NOT IN(
						SELECT customer_id
						FROM orders
						WHERE YEAR (order_date) = 1997);


/*4)Extraed toda la información de los pedidos donde tengamos "Konbu"
Estamos muy interesados en saber como ha sido la evolución de la venta de Konbu a lo largo del tiempo. 
Nuestro jefe nos pide que nos muestre todos los pedidos que contengan "Konbu".
💡 Pista 💡 En esta query tendremos que combinar conocimientos adquiridos en las lecciones anteriores como por ejemplo el INNER JOIN.*/

SELECT products.product_name AS NombreProducto,order_id AS Orden, order_details.product_id AS producto, order_details.unit_price AS precio, quantity AS cantidad, discount AS descuento
FROM order_details
INNER JOIN products
ON products.product_id = order_details.product_id
WHERE products.product_name = 'Konbu';
