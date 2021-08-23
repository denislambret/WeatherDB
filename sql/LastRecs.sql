select id, MAX(date_timestamp) as latest 
from Records 
where id_location = 6
group by id
order by date_timestamp desc
limit 1;

select * 
From Records
Where date(date_timestamp) = (
		Select DATE(MAX(date_timestamp)) as latest 
		from Records 
		where id_location = 6
		group by id
		order by date(date_timestamp) desc
		limit 1
	) and (id_location = 6);

select count(*) as results 
From Records
Where date(date_timestamp) = (
		Select DATE(MAX(date_timestamp)) as latest 
		from Records 
		where id_location = 6
		group by id
		order by date(date_timestamp) desc
		limit 1
	) and (id_location = 6);

