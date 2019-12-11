create table if not exists users(
  user_id int not null,
  name varchar(30) null,
  password varchar(30) null,
  admin tinyint not null default 0,
  active tinyint not null default 1,
  time_created date null,
  unique (name),
  primary key (user_id)
);

create table if not exists jobs(
  job_id int not null,
  user_created int null,
  active tinyint null default 1,
  time_created datetime null,
  last_run datetime null,
  job_name varchar(20) null,
  primary key (job_id)
);

create table if not exists requests(
  request_id int not null,
  job_id int null,
  start_city int null,
  end_city int null,
  date int null,
  "column" int null,
  primary key (request_id)
);

create table if not exists distances(
  start_city int not null,
  end_city int not null,
  distance int null,
  primary key (
    start_city, 
    end_city
  )
);

create table if not exists results(
  request_id int not null,
  time_created datetime not null,
  start_city int null,
  end_city int null,
  time int null,
  date int null,
  price int null,
  changes_number int null,
  primary key (
    request_id, 
    time_created
  )
);
create table if not exists cities(
  city_id int not null,
  city_name int null,
  primary key (city_id)
);
create table if not exists execution_log(
  id int not null,
  request_id int null,
  successful tinyint null,
  time datetime null,
  details varchar(1000) null,
  primary key (id)
);
create table if not exists calendar(
  date int not null,
  weekday int null,
  working tinyint null,
  primary key (date)
);

alter table jobs
  add foreign key (user_created)
  references users (user_id);
  
alter table requests
  add foreign key (job_id)
  references jobs (job_id);
  
alter table results
  add foreign key (request_id)
  references requests (request_id);
  
alter table distances
  add foreign key (start_city)
  references cities (city_id);
  
alter table distances
  add foreign key (end_city)
  references cities (city_id);
  
alter table requests
  add foreign key (start_city)
  references cities (city_id);
  
alter table requests
  add foreign key (end_city)
  references cities (city_id);
  
alter table results
  add foreign key (start_city)
  references cities (city_id);
  
alter table results
  add foreign key (end_city)
  references cities (city_id);
  
alter table execution_log
  add foreign key (request_id)
  references requests (request_id);
  
alter table results
  add foreign key (date)
  references calendar (date);
  
create index "Index" on users(name);