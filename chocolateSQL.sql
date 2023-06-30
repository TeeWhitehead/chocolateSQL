# Awesome Chocolates
# Tables
SHOW TABLES;

# View sales table
SELECT * 
FROM sales;

# Sales with amounts more than 10,000 in 2022
SELECT * 
FROM sales
WHERE amount > 10000 and year(saledate) = 2022
ORDER BY amount;

# Shipments on Fridays
SELECT saledate, amount, boxes, weekday(saledate) AS 'Day of Week'
FROM sales
WHERE weekday(saledate) = 4;

# Salespeople on the Delish or Juices team
SELECT *
FROM people
WHERE team = 'Delish' OR team = 'Jucies';
# OR
SELECT * 
FROM people
WHERE team in ('Delish','Jucies');

 # Salespeople who names start with B
SELECT * 
FROM people
WHERE salesperson LIKE 'B%';
 
# Categorize amounts with CASE statement
SELECT saledate, amount,
	CASE WHEN amount < 1000 THEN 'Under 1k'
		 WHEN amount < 5000 THEN 'Under 5k'
		 WHEN amount < 10000 THEN 'Under 10k'
		ELSE '10k or more'
	END AS 'Amount category'
FROM sales;

# Sales data with each person's name
SELECT  p.salesperson, s.spid, s.saledate, s.amount
FROM sales AS s
JOIN people AS p
	ON s.spid = p.spid;
    
# Product name and person name for sales
SELECT p.salesperson, pr.product, p.team, s.saledate, s.amount
FROM sales AS s
JOIN people AS p 
	ON p.spid = s.spid
JOIN products AS pr 
	ON pr.pid = s.pid;

# Total and Average amount for each Geo
SELECT geo, SUM(amount) AS total_amount, AVG(amount) AS avg_amount
FROM sales AS s
JOIN geo AS g
	ON g.geoid = s.geoid
GROUP BY geo
ORDER BY total_amount DESC;

# Top 10 products sold
SELECT pr.product, SUM(s.amount) AS total_amount
FROM sales AS s
JOIN products AS pr
	ON pr.pid = s.pid
GROUP BY pr.product
ORDER BY total_amount DESC
LIMIT 10;