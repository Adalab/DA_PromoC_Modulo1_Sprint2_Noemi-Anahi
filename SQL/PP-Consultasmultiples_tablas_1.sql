						-- CONSULTAS EN MULTIPLES TABLAS 1 --

/* Enunciado
En esta lección de pair programming vamos a continuar trabajando sobre la base de datos Northwind.
El día de hoy vamos a realizar ejercicios en los que practicaremos las queries SQL a múltiples tablas usando los operadores CROSS JOIN, 
INNER JOIN y NATURAL JOIN. De esta manera podremos combinar los datos de diferentes tablas en las mismas bases de datos, para así realizar
 consultas mucho mas complejas.*/
 
 USE northwind;
 
/* 1)Pedidos por empresa en UK:
Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base de datos 
con la que podamos conocer cuántos pedidos ha realizado cada empresa cliente de UK. Nos piden el ID del cliente 
y el nombre de la empresa y el número de pedidos.*/

SELECT  customers.company_name AS NombreEmpresa , customers.customer_id AS Identificador, COUNT(orders.order_id) AS NumeroPedidos
FROM customers INNER JOIN orders
ON customers.customer_id = orders.customer_id 
WHERE country = 'UK'
GROUP BY customers.customer_id ;


/*2)Productos pedidos por empresa en UK por año:
Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición anterior y
han decidido pedirnos una serie de consultas adicionales. La primera de ellas consiste en una query que nos sirva para
 conocer cuántos objetos ha pedido cada empresa cliente de UK durante cada año. Nos piden concretamente conocer el nombre 
 de la empresa, el año, y la cantidad de objetos que han pedido. Para ello hará falta hacer 2 joins.*/
 
 
SELECT  company_name AS NombreEmpresa , COUNT(orders.order_id) AS NumObjetos, orders.customer_id, orders.order_date 
FROM customers INNER JOIN orders
ON customers.customer_id = orders.customer_id 
WHERE country = 'UK'
GROUP BY YEAR (order_date) ;

SELECT customers.company_name, orders.order_date, customer_id
FROM customers INNER JOIN orders
WHERE country = 'UK'
GROUP BY YEAR(order_date);
USING (customers.company_name, orders.order_date, orders.customer_id);


(DAY()), el mes (MONTH()) y el año (YEAR())


/*3)Mejorad la query anterior:
Lo siguiente que nos han pedido es la misma consulta anterior pero con la adición de la cantidad de dinero que han pedido por
esa cantidad de objetos, teniendo en cuenta los descuentos, etc. Ojo que los descuentos en nuestra tabla nos salen en porcentajes,
15% nos sale como 0.15.*/


/*4)BONUS: Pedidos que han realizado cada compañía y su fecha:
Después de estas solicitudes desde UK y gracias a la utilidad de los resultados que se han obtenido, desde la central nos han pedido una
consulta que indique el nombre de cada compañia cliente junto con cada pedido que han realizado y su fecha.*/


/*5)BONUS: Tipos de producto vendidos:
Ahora nos piden una lista con cada tipo de producto que se han vendido, sus categorías, nombre de la categoría y el nombre del producto, 
y el total de dinero por el que se ha vendido cada tipo de producto (teniendo en cuenta los descuentos).
Pista Necesitaréis usar 3 joins.*/

