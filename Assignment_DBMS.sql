-- 1.Table creation queries
-- Passenger table creation
CREATE TABLE IF NOT EXISTS `PASSENGER`(
`Passenger_name` VARCHAR(100),
`Category` VARCHAR(20),
`Gender` VARCHAR(10) ,
`Boarding_City` VARCHAR(50),
`Destination_City` VARCHAR(50),
`Distance` INT,
`Bus_Type` VARCHAR(50)
);

-- Price table creation
CREATE TABLE IF NOT EXISTS `PRICE`(
`Bus_Type` VARCHAR(50),
`Distance` INT,
`Price` INT
);


--2.Data insertion queries
-- Data Insert query for Passenger table
INSERT INTO PASSENGER(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type)
VALUES
('Sejal','AC','F','Bengaluru','Chennai',350,'Sleeper'),
('Anmol','Non-AC','M','Mumbai','Hyderabad',700,'Sitting'),
('Pallavi','AC','F','Panaji','Bengaluru',600,'Sleeper'),
('Khusboo','AC','F','Chennai','Mumbai',1500,'Sleeper'),
('Udit','Non-AC','M','Trivandrum','panaji',1000,'Sleeper'),
('Ankur','AC','M','Nagpur','Hyderabad',500,'Sitting'),
('Hemant','Non-AC','M','panaji','Mumbai',700,'Sleeper'),
('Manish','Non-AC','M','Hyderabad','Bengaluru',500,'Sitting'),
('Piyush','AC','M','Pune','Nagpur',700,'Sitting');

-- Data insertion query for Price table
INSERT INTO price (Bus_Type,Distance,Price ) 
VALUES
('Sleeper',350,770),
('Sleeper',500,1100),
('Sleeper',600,1320),
('Sleeper',700,1540),
('Sleeper',1000,2200),
('Sleeper',1200,2640),
('Sleeper',1500,2700),
('Sitting',500,620),
('Sitting',600,744),
('Sitting',700,868),
('Sitting',1000,1240),
('Sitting',1200,1488),
('Sitting',1500,1860);


--3.How many females and how many male passengers travelled for a minimum distance of 600 KMs?
SELECT Gender,COUNT(*) as person_count 
from passenger
where Distance>=600 
GROUP BY Gender;


--4.Find the minimum ticket price for Sleeper Bus. 
SELECT Price 
from price
where Bus_Type='Sleeper' 
having Price = min(Price);


--5.Select passenger names whose names start with character 'S'
SELECT Passenger_name
from passenger
where Passenger_name like 'S%';
--  or Passenger_name like 's%';


--6.Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output
SELECT DISTINCT passenger.Passenger_name,passenger.Boarding_City,Passenger.Destination_City,passenger.Bus_Type,price.Price
FROM passenger,price
WHERE passenger.Bus_Type=price.Bus_Type and passenger.Distance=price.Distance;


-- 7.What are the passenger name/s and his/her ticket price who travelled in the Sitting bus for a distance of 1000 KM s
SELECT DISTINCT Passenger_name,Price
FROM passenger,price
where passenger.Bus_Type=price.Bus_Type and passenger.Distance=price.Distance AND 
passenger.Bus_Type='Sitting' and price.Distance=1000;


-- 8.What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
SELECT DISTINCT passenger.Bus_Type,price.Price
FROM passenger,price
where 
passenger.Bus_Type=price.Bus_Type and 
passenger.Distance=price.Distance AND 
passenger.Passenger_name='Pallavi' and
passenger.Boarding_City='Bangalore' and
passenger.Destination_City='panaji';


-- 9.List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order
SELECT DISTINCT Distance
FROM passenger 
ORDER BY Distance DESC;


-- 10.Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables
SELECT Passenger_name, Distance * 100 / p.total_distance AS '% of Distance''
FROM passenger
CROSS JOIN (SELECT SUM(Distance) AS total_distance FROM passenger) p;


-- 11. Display the distance, price in three categories in table Price
-- a) Expensive if the cost is more than 1000
-- b) Average Cost if the cost is less than 1000 and greater than 500
-- c) Cheap otherwise
SELECT passenger.Distance,price.Price,
CASE
    WHEN price.Price>=1000 then 'Expensive'
    WHEN price.Price>=500 and price.Price<1000 then 'Average Cost'
    else 'Cheap' end as 'Cost' 
from passenger,price
where 
passenger.Bus_Type=price.Bus_Type and 
passenger.Distance=price.Distance;