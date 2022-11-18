										-- CONSULTAS EN MÚLTIPLES TABLAS 2 --
                    
USE northwind;

/* 1- Qué empresas tenemos en la BBDD Northwind:
Lo primero que queremos hacer es obtener una consulta SQL que nos devuelva el nombre de todas las empresas cliente, los ID de sus pedidos y las fechas. */

SELECT order_id AS OrderID, company_name AS CompanyName, order_date AS OrderDate
FROM orders
	LEFT JOIN customers 
ON customers.customer_id = orders.customer_id 
ORDER BY CompanyName ;


/* 2- Pedidos por cliente de UK:
Desde la oficina de Reino Unido (UK) nos solicitan información acerca del número de pedidos que ha realizado 
cada cliente del propio Reino Unido de cara a conocerlos mejor y poder adaptarse al mercado actual. 
Especificamente nos piden el nombre de cada compañía cliente junto con el número de pedidos.*/

SELECT company_name AS NombreCliente, count(order_id) AS NumeroPedidos
FROM customers
	LEFT JOIN orders
ON customers.customer_id = orders.customer_id 
WHERE country = "UK"
GROUP BY NombreCliente
ORDER BY NombreCliente ;

/* 3- Empresas de UK y sus pedidos:
También nos han pedido que obtengamos todos los nombres de las empresas cliente de Reino Unido (tengan pedidos o no) junto con los ID de todos los pedidos que han realizado, 
el nombre de contacto de cada empresa y la fecha del pedido.*/

SELECT order_id AS OrderID, company_name AS NombreCliente, order_date AS FechaPedido, contact_name AS NombreContacto
FROM orders
	LEFT JOIN customers 
ON customers.customer_id = orders.customer_id
WHERE country = "UK" 
ORDER BY NombreCliente ;

/* 4- Empleadas que sean de la misma ciudad:
Ejercicio de SELF JOIN: Desde recursos humanos nos piden realizar una consulta que muestre por pantalla
 los datos de todas las empleadas y sus supervisoras. Concretamente nos piden: la ubicación, nombre, 
 y apellido tanto de las empleadas como de las jefas. Investiga el resultado, ¿sabes decir quién es el director? */
 
SELECT A.city AS Ciudad, CONCAT(A.first_name, " ", A.last_name) AS Empleados, B.City AS Ciudad, CONCAT(B.first_name, " ", B.last_name) AS Jefes
FROM employees AS A, employees AS B
WHERE A.reports_to = B.employee_id
GROUP BY CONCAT(A.first_name, " ", A.last_name) ;

-- El jefe es Andrew Fuller ya que es el que más personas a su cargo tiene según nuestro resultado.