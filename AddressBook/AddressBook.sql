create table Address (
	id int not null auto_increment primary key,
    name varchar(50) not null,
    relationship varchar(50) not null,
    email varchar(50) not null,
    phoneNumber varchar(50) not null
);

select * from Address; 