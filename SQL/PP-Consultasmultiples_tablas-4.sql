									-- CONSULTAS MULTIPLES TABLAS 4--
                    
USE northwind;

/*1)Extraed información de los productos "Beverages"
En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria para
identificar un tipo de producto. En concreto, tienen especial interés por los productos con categoría "Beverages". 
Devuelve el ID del producto, el nombre del producto y su ID de categoría.*/

SELECT product_id AS ProductID,product_name AS ProductName,category_id AS CategoryID
FROM products
WHERE category_id = ALL  (
						SELECT category_id
						FROM categories
						WHERE category_name = 'Beverages');


/*2)Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país
Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes, entonces podría dirigirse a estos
países para buscar proveedores adicionales.*/

SELECT DISTINCT country
FROM customers
WHERE country NOT IN (SELECT country
					  FROM suppliers);
                    

/*3)Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread"
Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto "Grandma's Boysenberry Spread"
(ProductID 6) en un solo pedido.*/

SELECT order_id AS OrderID, customer_id AS CustomerID
FROM orders
WHERE order_id IN (SELECT order_id
					FROM order_details
                    WHERE product_id = 6 AND quantity >20);


/*4)Extraed los 10 productos más caros
Nos siguen pidiendo más queries correlacionadas. En este caso queremos saber cuáles son los 10 productos más caros.*/

SELECT product_name AS Ten_Most_Expensive_Products, unit_price AS UnitPrice
FROM products
ORDER BY unit_price desc
LIMIT 10;

/*BONUS:
5)Qué producto es más popular.
Extraed cuál es el producto que más ha sido comprado y la cantidad que se compró.*/
				
SELECT products.product_name AS ProductName, SUM(order_details.quantity) AS SumQuantity
FROM products, order_details
WHERE products.product_id IN (
								SELECT order_details.product_id
								FROM order_details
								GROUP BY products.product_id
								ORDER BY SUM(order_details.quantity) DESC );
                    







