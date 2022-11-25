									-- PP CONSULTAS CON CTEs --
USE northwind;

/*1- Extraer en una CTE todos los nombres de las compañias y los id de los clientes.
Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente y el nombre de la compañia de la tabla Customers. */

WITH cte1 AS (
SELECT company_name, customer_id 
FROM customers )
SELECT *
FROM cte1;


/*2-Selecciona solo los de que vengan de "Germany"
Ampliemos un poco la query anterior. En este caso, queremos un resultado similar al anterior, 
pero solo queremos los que pertezcan a "Germany".*/

WITH cte1 AS (
SELECT company_name, customer_id, country
FROM customers 
WHERE country = "Germany")
SELECT *
FROM cte1;


/*3 - Extraed el id de las facturas y su fecha de cada cliente. ##ENTENDEMOS QUE SE REFIERE AL ORDER_ID
En este caso queremos extraer todas las facturas que se han emitido a un cliente, su fecha la compañia a la que pertenece.
📌 NOTA En este caso tendremos columnas con elementos repetidos(CustomerID, y Company Name).*/

WITH cte1 AS (
SELECT company_name, customer_id
FROM customers )
SELECT C.company_name, C.customer_id, O.order_id, O.order_date
FROM orders AS O 
JOIN cte1 AS C 
ON C.customer_id = O.customer_id ;


/* 4- Contad el número de facturas por cliente ##ENTENDEMOS QUE SE REFIERE A ORDER_ID
Mejoremos la query anterior. En este caso queremos saber el número de facturas emitidas por cada cliente.*/ 

WITH cte1 AS (
SELECT company_name, customer_id
FROM customers )
SELECT C.company_name, C.customer_id, COUNT(O.order_id)
FROM orders AS O 
JOIN cte1 AS C 
ON C.customer_id = O.customer_id 
GROUP BY C.company_name ;


/*5-Cuál la cantidad media pedida de todos los productos ProductID.
Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media.*/

WITH suma
AS (
      SELECT SUM(quantity)
      FROM order_details 
      )
SELECT COUNT(quantity)
FROM order_details
JOIN suma
ON P.product_id = M.product_id ;



SELECT product_id, SUM(quantity) AS suma
FROM ( WITH pedidos_sum 
AS (
      SELECT SUM(quantity) 
      FROM order_details
      )
SELECT product_name, media
FROM products AS P
JOIN pedidos_sum AS S
ON P.product_id = S.product_id);
