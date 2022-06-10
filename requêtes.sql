# Normalisation des bases de données

select id, year,host, category, nominee,movie,character,won
from ceremonies
inner join nominations
on nominations.ceremony_id == ceremonies.id;



//
select * from film;
select distinct rating from film;
select distinct rental_rate from film;
select rating, count(rating) from film group by rating;
select rental_rate, count(rental_rate) from film group by rental_rate;
select * from rental;
select rental_date, count(rental_id) as total_rental from rental group by rental_date order by total_rental desc;
select extract(year from rental_date), extract(month from rental_date), count(rental_id) from rental group by 1,2;  

select email from customer where first_name='Gloria' and last_name='Cook';
select description from film where title='Texas Watch';
select phone from address where address='270 Toulon Boulevard';

select * from rental;

select customer_id, rental_id, return_date from rental where customer_id in (1,2) order by return_date desc;

select first_name from customer where first_name like 'Jen%';
select first_name from customer where first_name like '%er_';

select * from actor;
select count(last_name) from actor where last_name like 'P%';
select * from film;
select count(title) from film where title like '%Truman%';
select first_name, last_name from customer where first_name like 'E%' and address_id < 500 order by customer_id desc limit 1;

select * from payment;
select staff_id, count(amount), sum(amount) from payment group by staff_id;

select rating,round(avg(replacement_cost),2) from film group by rating;

select * from payment;
select customer_id, sum(amount) from payment group by customer_id order by sum(amount) desc limit 5;

select rating, avg(rental_rate) from film where rating in ('R', 'G', 'PG') group by rating having avg(rental_rate) > 3;

select * from payment;
select customer_id, count(amount) from payment group by customer_id having count(amount) >=30;
select rating, avg(rental_duration) from film group by rating having avg(rental_duration) > 5;
select * from payment;
select customer_id, sum(amount) from payment where staff_id = 2 group by customer_id having sum(amount) > 110;
select * from customer;
select customer.customer_id from customer inner join payment on payment.customer_id = customer.customer_id;
select store_id, title, count(title) from inventory inner join film on inventory.film_id=film.film_id;



select f.film_id,title,inventory_id,store_id 
from film as f 
left outer join inventory as i on f.film_id=i.film_id 
where f.film_id is null 
order by f.film_id;



select film.title, language.name, category.name 
from film 
inner join film_category on film.film_id=film_category.film_id 
inner join category on film_category.category_id=category.category_id 
inner join language on film.language_id=language.language_id;




select title,count(rental_id), count(rental_id)*rental_rate as revenue
from film as f
inner join inventory as i on f.film_id=i.film_id
inner join rental as r on r.inventory_id=r.inventory_id
group by title, rental_rate
order by revenue desc;


select store_id, sum(p.amount) as revenue
from inventory as i
inner join rental as r on r.inventory_id=i.inventory_id
inner join payment as p on p.rental_id=r.rental_id
group by store_id
order by revenue desc;

select c.name as category, count(r.rental_id) as number_of_rental_per_category
from category as c
inner join film_category as fc on fc.category_id=c.category_id
inner join film as f on f.film_id=fc.film_id
inner join inventory as i on i.film_id=f.film_id
inner join rental as r on r.inventory_id=i.inventory_id
where c.name in ('Action','Comedy','Animation')
group by c.name;

select email as Customer_email, count(rental_id) as number_of_rentals
from customer as c
inner join rental as r on r.customer_id=c.customer_id
group by email
having count(rental_id) >= 40;