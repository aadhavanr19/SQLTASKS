-- 1. toatl amount of sales done by each customers

SELECT
  s.customer_id,
  SUM(m.price) AS total_sales
FROM sushiland.sales s
  JOIN sushiland.menu m
    ON s.product_id = m.product_id
GROUP BY s.customer_id
ORDER BY s.customer_id;

-- 2.No.of days each customer visited the restaurant

SELECT
  s.customer_id,
  COUNT(DISTINCT s.order_date) AS unique_visits
FROM sushiland.sales s
GROUP BY s.customer_id;

-- first item from the menu purchased by each customer

SELECT 
  s.customer_id,
  s.order_date,
  m.product_name
FROM sushiland.sales s
  JOIN sushiland.menu m
    ON s.product_id = m.product_id
WHERE 
  s.orderID IN
    (SELECT
      MIN(s.orderID)
    FROM sushiland.sales s
    GROUP BY
      s.customer_id
    )
ORDER BY
  s.customer_id;
  
  -- most purchased item on the menu and how many times was it purchased by all customers
SELECT
  m.product_name,
  COUNT(s.product_id) AS num_of_orders
FROM sushiland.menu m
  JOIN sushiland.sales s
    ON m.product_id = s.product_id
GROUP BY
  m.product_name
ORDER BY
  num_of_orders DESC;
  
  -- the most popular item for each customer
  WITH order_count AS 
  (SELECT
      s.customer_id, 
      m.product_name, 
      COUNT(s.product_id) AS order_count,
      DENSE_RANK()OVER(PARTITION BY s.customer_id ORDER BY COUNT(s.customer_id) DESC) AS rnk
  FROM sushiland.sales s
    JOIN sushiland.menu m
      ON s.product_id = m.product_id
  GROUP BY 
      s.customer_id, 
      m.product_name
  )  
SELECT
  customer_id,
  product_name,
  order_count
FROM order_count 
where rnk = 1 ;

-- item was purchased first by the customer after they became a member
WITH member_timeline AS 
  (SELECT 
      mb.customer_id,
      mb.join_date,
      s.order_date,
      s.product_id,
      DENSE_RANK()OVER (PARTITION BY s.customer_id ORDER BY s.order_date,s.OrderId) AS order_rank
  FROM sushiland.members mb
	  JOIN sushiland.sales s
      ON mb.customer_id = s.customer_id
  WHERE
      s.order_date >= mb.join_date
 ORDER BY
      mb.customer_id,
      s.order_date
)
SELECT
  mt.customer_id,
  mt.join_date,
  mt.order_date,
  m.product_name
FROM member_timeline mt
  JOIN sushiland.menu m
    ON mt.product_id = m.product_id
WHERE
  mt.order_rank = 1
ORDER BY
  mt.customer_id;
  
  -- item purchased just before the customer became a member
  
  select m.Customer_Id,m.Join_Date,s.Order_Date,mu.Product_Name from sushiland.members m
join sushiland.sales s
on m.Customer_Id = s.Customer_Id
join sushiland.menu mu
on s.Product_Id = mu.Product_ID
where Join_Date < s.Order_Date
limit 10 ;

-- the total items and amount spent for each member before they became a member

SELECT
  items.customer_id,
  items.total_items,
  total.total_spent
FROM
      (SELECT
          mb.customer_id,
          COUNT(s.order_date) as total_items
      FROM sushiland.members mb
          JOIN sushiland.sales s
            ON mb.customer_id = s.customer_id
      WHERE
          s.order_date < mb.join_date
      GROUP BY
          mb.customer_id
      ) items
  JOIN
      (SELECT
          mb.customer_id,
          SUM(m.price) AS total_spent
      FROM sushiland.members mb
          JOIN sushiland.sales s
            ON mb.customer_id = s.customer_id
          JOIN sushiland.menu m
            ON s.product_id = m.product_id
      WHERE
          s.order_date < mb.join_date
      GROUP BY
          mb.customer_id
      ORDER BY
          mb.customer_id
      ) total
  ON items.customer_id = total.customer_id;
  
  -- Join All The Things 
  
  SELECT
  s.customer_id,
  s.order_date,
  m.product_name,
  m.price,
  CASE WHEN s.order_date >= mb.join_date THEN 'Y'
       ELSE 'N' 
        END AS member
FROM sushiland.sales s
  LEFT JOIN sushiland.menu m
         ON s.product_id = m.product_id
  LEFT JOIN sushiland.members mb
         ON s.customer_id = mb.customer_id
ORDER BY
  s.customer_id,
  s.order_date 
  limit 10 ;