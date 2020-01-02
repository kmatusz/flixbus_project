create table if not exists users(
  user_id int primary key,
  name varchar(30) null,
  password varchar(30) null,
  admin tinyint not null default 0,
  active tinyint not null default 1,
  time_created date null,
  unique(name)
);
create table if not exists jobs(
  job_id int primary key autoincrement,
  user_created int null,
  active tinyint null default 1,
  time_created datetime null,
  last_run datetime null,
  job_name varchar(20) null,
  foreign key (user_created)
  references users (user_id)
);
create table if not exists requests(
  request_id int primary key autoincrement,
  job_id int null,
  start_city int null,
  end_city int null,
  date int null,
  foreign key (job_id)
  references jobs (job_id),
  foreign key (start_city)
  references cities (city_id),
  foreign key (end_city)
  references cities (city_id)
);
create table if not exists distances(
  start_city int not null,
  end_city int not null,
  distance int null,
  primary key (
    start_city, 
    end_city
  ),
  foreign key (start_city)
  references cities (city_id)
);
create table if not exists results(
  result_id int autoincrement,
  request_id int not null,  
  time_created datetime not null,
  start_city int null,
  end_city int null,
  time int null,
  date date null,
  price double null,
  changes_number int null,
  primary key (
    result_id
  ),
  foreign key (request_id)
  references requests (request_id),
  foreign key (start_city)
  references cities (city_id),
  foreign key (end_city)
  references cities (city_id),
  foreign key (date)
  references working_days (date)
);
create table if not exists cities(
  city_id int primary key,
  city_name int null
);
create table if not exists execution_logs(
  id int primary key,
  request_id int null,
  successful tinyint null,
  time datetime null,
  details varchar(1000) null,
  foreign key (request_id)
  references requests (request_id)
);
create table if not exists working_days(
  date date primary key,
  weekday int null,
  working tinyint null
);

