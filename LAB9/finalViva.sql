select customer_id,total from order
(select order_id,product_id,sum(quantity*price) as total from orderItem,Products
where orderItem.product_id=Products.product_id) 
as totalTab
group by order.customer_id having customer_id=?