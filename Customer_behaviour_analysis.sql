select*from customer limit 20
--what is the total revenue genrated by male vs female customer
select gender,sum(purchase_amount) as revenue
from customer
group by gender
--which customer used a dicscount but still spent more than avg customer amount?
select customer_id,purchase_amount
from customer
where discount_applied='Yes' and  purchase_amount>=(select AVG(purchase_amount) from customer)
-- which are the top  5  with highest review rating 
select item_purchased,ROUND(Avg(review_rating::numeric),2)as "Average Product Review"
from customer 
group by item_purchased
order by avg (review_rating )desc
limit 5