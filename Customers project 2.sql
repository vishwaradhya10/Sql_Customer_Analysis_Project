-- Creating Table 

CREATE TABLE customers (
    CustomerID INT PRIMARY KEY,
    Gender VARCHAR(10),
    Age INT,
    Annual_Income DECIMAL(10,2),
    Spending_Score INT,
    Profession VARCHAR(50),
    Work_Experience INT,
    Family_Size INT
);

SELECT * 
FROM Customers 
WHERE Customerid IS NOT NULL;


Select * from customers


-- Data Exploration and analysis

--1.What is the average age of customers?
   Select Round(avg(age),2) as average_age
   from customers

--2.How many male and female customers are there?
    select gender, 
	Count (*) 
	from customers
	group by gender

--3.What is the average annual income of customers by profession?
    select Profession,
	avg (annual_income) as avg_income
     from customers
     Group by Profession


-- Business questions and its key answers

-- 1. List all customers who are under the age of 25.

     Select *
	 From customers
	 where age <=25
	  
--2.Retrieve the top 10 customers with the highest spending score.

	 Select * 
	 from customers
	 order by spending_score desc
	 limit 10;

-- 3.Find all male customers whose annual income is above ₹50,000.

     Select *
	 from customers
	 Where Gender = 'Male'
	 and annual_income = '50000'


-- 4. What is the average spending score by gender?

     Select Gender,
	 AVG (spending_score) as avg_spendeing_score
	 from customers
	 Group by gender

-- 5. Count the number of customers in each profession.

	 Select Profession,
	 Count (*) as customer_count 
	 From Customers
	 Group by profession;

-- 6. Find the profession with the highest average annual income.

	 Select profession,
	 Avg (annual_income) as highest_income
	 From customers
	 Group by profession
	 order by highest_income desc
	 limit 1;

-- 7. Find customers whose income is above the median income.

     SELECT *
FROM Customers
WHERE "annual_income" > (
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY "annual_income") 
    FROM Customers
);

-- 8.For each profession, calculate the difference between a customer’s income and the average income in that profession.

	 SELECT 
    CustomerID,
    Profession,
    "annual_income",
    AVG("annual_income") OVER (PARTITION BY Profession) AS avg_income_in_profession,
    "annual_income" - AVG("annual_income") OVER (PARTITION BY Profession) AS income_difference
FROM Customers;


-- 9. Select all customers whose spending score is greater than the average for their profession.

     SELECT *
FROM Customers 
WHERE "spending_score" > (
    SELECT AVG("spending_score")
    FROM Customers
    WHERE Profession = Profession
);
 
-- 10. Rank customers within each profession based on their spending score.	  

       SELECT 
    CustomerID,
    Profession,
    "spending_score",
    RANK() OVER (PARTITION BY Profession ORDER BY "spending_score" DESC) AS spending_rank
FROM Customers;


---END OF THE ANALYSIS

