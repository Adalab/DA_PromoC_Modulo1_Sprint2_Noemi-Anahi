						-- CONSULTAS EN MULTIPLES TABLAS 5 --

/*Ejercicios*/

USE northwind;

/*1)Extraed los pedidos con el máximo "order_date" para cada empleado.
Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. 
Para eso nos pide que lo hagamos con una query correlacionada.*/

SELECT O.order_id, O.customer_id, O.employee_id,O.order_date,O.required_date
FROM orders AS O
WHERE O.employee_id = ( SELECT E.employee_id
							FROM employees AS E
                            WHERE E.employee_id = O.employee_id
							GROUP BY E.employee_id
                            ORDER BY O.order_date DESC);
                           



/*2)Extraed el precio unitario máximo (unit_price) de cada producto vendido.
Supongamos que ahora nuestro jefe quiere un informe de los productos vendidos y su precio unitario. 
De nuevo lo tendréis que hacer con queries correlacionadas.*/

SELECT product_id, unit_price
FROM products AS P
WHERE unit_price = (SELECT MAX(unit_price)
					FROM order_details AS OD
                    WHERE OD.product_id = P.product_id);


/*3)Ciudades que empiezan con "A" o "B".
Por un extraño motivo, nuestro jefe quiere que le devolvamos una tabla con aquelas compañias que están afincadas en ciudades que empiezan por "A" o "B".
Necesita que le devolvamos la ciudad, el nombre de la compañia y el nombre de contacto.*/

SELECT city AS City,company_name AS CompanyName,contact_name AS ContactName
FROM customers
WHERE city LIKE 'A%' OR city LIKE 'B%';


/*4)Número de pedidos que han hecho en las ciudades que empiezan con L.
En este caso, nuestro objetivo es devolver los mismos campos que en la query anterior el número de total de pedidos que han hecho todas las ciudades que
empiezan por "L".*/

SELECT C.city AS City,C.company_name AS CompanyName,C.contact_name AS ContactName, C.order_id
FROM customers AS C
WHERE  C.order_id = (SELECT COUNT(O.order_id)
					FROM orders AS O
					WHERE   C.city LIKE 'L%'
					GROUP BY O.order_id);
                  
                                     O.order_id = C.order_id
SELECT C.city AS City,C.company_name AS CompanyName,C.contact_name AS ContactName,COUNT(O.order_id)
FROM orders AS O
WHERE   SELECT C.city AS City,C.company_name AS CompanyName,C.contact_name AS ContactName, C.order_id
FROM customers AS C
WHERE C.city LIKE 'L%' 
                    
                    

O.order_id = C.order_id
/*5)Todos los clientes cuyo "contact_title" no incluya "Sales".
Nuestro objetivo es extraer los clientes que no tienen el contacto "Sales" en su "contact_title". 
Extraer el nombre de contacto, su posisión (contact_title) y el nombre de la compañia.*/

SELECT company_name,contact_name,contact_title
FROM customers
WHERE contact_title NOT LIKE 'Sales%';



/*6)Todos los clientes que no tengan una "A" en segunda posición en su nombre.
Devolved unicamente el nombre de contacto.*/

SELECT contact_name
FROM customers
WHERE contact_name NOT LIKE '_a%';
