SELECT
	w.warehouse_name,
	COUNT(*) AS total_shipments,
	SUM(CASE WHEN s.delivery_status = 'Arrived' THEN 1 ELSE 0 END) AS arrived_shipments,
	ROUND(
		100.0 * SUM(CASE WHEN s.delivery_status = 'Arrived' THEN 1 ELSE 0 END) / COUNT(*),
		2
	) AS on_time_rate
FROM shipments s
JOIN warehouses w
	ON s.warehouse_id = w.warehouse_id
GROUP BY w.warehouse_name
ORDER BY on_time_rate DESC;
*******************************************************

SELECT
	delivery_status,
	COUNT (*) AS shipment_count
FROM shipments
GROUP BY delivery_status
ORDER BY shipment_count DESC;
*********************************************************

 SELECT
 	customer_region, 
	 COUNT(*) AS total_shipments,
	 ROUND(AVG(shipping_cost), 2) AS avg_shipping_cost
FROM shipments
GROUP BY customer_region
ORDER BY avg_shipping_cost DESC;
**********************************************************
SELECT
	p.category,
	COUNT(*) AS total_orders,
	SUM(s.order_value) AS total_order_value
FROM shipments s
JOIN products_summary p
	ON s.order_id = p.order_id 
GROUP BY p.category
ORDER BY total_order_value DESC;
***********************************************************

SELECT
	ROUND(
	100.0 * SUM(CASE WHEN delivery_status = 'Arrived' THEN 1 ELSE 0 END) / COUNT(*),
	2
) AS on_time_delivery_rate
FROM shipments;
************************************************************

SELECT
	s.order_id,
	c.carrier_name,
	w.warehouse_name,
	s.customer_region,
	p.category,
	s.ship_date,
	s.estimated_delivery_date,
	s.actual_delivery_date,
	(s.actual_delivery_date - s.ship_date) AS delivery_days,
	s.shipping_cost,
	s.order_value,
	s.delivery_status
FROM shipments s
JOIN carriers c
	ON s.carrier_id = c.carrier_id
JOIN warehouses w
	ON s.warehouse_id = w.warehouse_id
JOIN products_summary p
	ON s.order_id = p.order_id
ORDER BY s.order_id;
***************************************************************

SELECT
	customer_region,
	COUNT (*) AS total_shipments,
	SUM(CASE WHEN delivery_status = 'Delayed' THEN 1 ELSE 0 END) AS delayed_shipments	
FROM shipments
GROUP BY customer_region
ORDER BY delayed_shipments DESC;
****************************************************************

SELECT
	p.category,
	COUNT(*) AS total_orders,
	ROUND(AVG(s.shipping_cost), 2) AS avg_shipping_cost
FROM shipments s 
JOIN products_summary p
	ON s.order_id = p.order_id
GROUP BY p.category
ORDER BY avg_shipping_cost DESC;
***************************************************************

**Average Delivery Days
SELECT
	c.carrier_name,
	ROUND(AVG(actual_delivery_date - ship_date), 2) AS avg_delivery_days
FROM shipments s
JOIN carriers c
	ON s.carrier_id = c.carrier_id
GROUP BY c.carrier_name
ORDER BY avg_delivery_days ASC;