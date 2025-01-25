create table lifts
(
      id         	  int
    , capacity_kg     int
);

insert into lifts values (1, 300);
insert into lifts values (2, 350);

create table lift_passengers
(
      passenger_name    varchar(50)
    , weight_kg     	int
	, lift_id			int
);

insert into lift_passengers values ('Rahul', 85, 1);
insert into lift_passengers values ('Adarsh', 73, 1);
insert into lift_passengers values ('Riti', 95, 1);
insert into lift_passengers values ('Dheeraj', 80, 1);
insert into lift_passengers values ('Vimal', 83, 2);
insert into lift_passengers values ('Neha', 77, 2);
insert into lift_passengers values ('Priti', 73, 2);
insert into lift_passengers values ('Himanshi', 85, 2); 

select * from lifts;
select * from lift_passengers;
with cte as 
(select *
, sum(weight_kg) over (partition by id order by id,weight_kg) as cum_sum
, case when capacity_kg>=sum(weight_kg) over(partition by id order by id,weight_kg)
           then 1 else 0 end as flag
from lifts l
join lift_passengers p on id = lift_id 
-- for order weights

order by id, weight_kg)
select lift_id,string_agg(passenger_name,',') as passengers
from cte
where flag=1
group by lift_id
--string use for get row name get into only one row 
--group by use for strings