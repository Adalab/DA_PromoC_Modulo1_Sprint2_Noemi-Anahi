		
												-- CONSULTAS AVANZADAS 2

/*Enunciado
En esta lección de pair programming vamos a continuar trabajando sobre la base de datos Northwind.
El día de hoy vamos a realizar ejercicios en los que practicaremos sentencias SQL usando el operador GROUP BY, 
que nos ayudará a agrupar o seleccionar los resultados según los valores de algunos de los atributos de la tabla,
 y HAVING y CASE para añadir condiciones a la ejecución de ciertas partes de las consultas de manera similar a como
 hacemos con WHERE (aunque con diferencias).*/
 
 USE northwind ;
 
/*1)Relación entre número de pedidos y máxima carga:
Desde logística nos piden el número de pedidos y la máxima cantidad de carga de entre los mismos (freight)
que han sido enviados por cada empleado (mostrando el ID de empleado en cada caso).*/

SELECT employee_id, order_id, MAX(freight)
FROM orders
GROUP BY employee_id ;

/*2)Descartar pedidos sin fecha y ordénalos:
Una vez han revisado los datos de la consulta anterior, nos han pedido afinar un poco más el "disparo". 
En el resultado anterior se han incluido muchos pedidos cuya fecha de envío estaba vacía, por lo que tenemos que mejorar 
la consulta en este aspecto. También nos piden que ordenemos los resultados según el ID de empleado para que la visualización
 sea más sencilla.*/
 
SELECT employee_id, order_id, MAX(freight), shipped_date
FROM orders
WHERE shipped_date != "0000-00-00 00:00:00"
GROUP BY employee_id ;
 
/*3)Números de pedidos por día:
El siguiente paso en el análisis de los pedidos va a consistir en conocer mejor la distribución de los mismos según las fechas.
 Por lo tanto, tendremos que generar una consulta que nos saque el número de pedidos para cada día, mostrando de manera 
 separada el día (DAY()), el mes (MONTH()) y el año (YEAR()).*/
 
SELECT COUNT(order_id), DAY(order_date), MONTH(order_date),  YEAR(order_date) 
FROM orders
GROUP BY order_date ;
 
/*4)Número de pedidos por mes y año:
La consulta anterior nos muestra el número de pedidos para cada día concreto, pero esto es demasiado detalle.
 Genera una modificación de la consulta anterior para que agrupe los pedidos por cada mes concreto de cada año.*/
 
SELECT COUNT(order_id), MONTH(order_date), YEAR(order_date) 
FROM orders
GROUP BY order_date ;
  
/*5)Seleccionad las ciudades con 4 o más empleadas:
Desde recursos humanos nos piden seleccionar los nombres de las ciudades con 4 o más empleadas de cara a estudiar la apertura 
de nuevas oficinas.*/

SELECT city
FROM employees
GROUP BY city 
HAVING COUNT(employee_id) >= 4;

/*6)Cread una nueva columna basándonos en la cantidad monetaria:
Necesitamos una consulta que clasifique los pedidos en dos categorías ("Alto" y "Bajo") en función de la cantidad monetaria total 
que han supuesto: por encima o por debajo de 2000 euros.*/

SELECT CASE 
	WHEN (unit_price * quantity) < 2000 THEN "Bajo"
    ELSE "Alto"
    END AS OrderCategory, order_id, unit_price 
FROM order_details
GROUP BY order_id ;