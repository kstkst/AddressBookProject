create table Address (
	id int not null auto_increment,
	name varchar(20),
	relationship varchar(20),
	email varchar(20),
    phoneNumber varchar(20),
	primary key (id)
) charset=utf8;

insert into Address(name,relationship,email,phoneNumber) values ('a', 'good', 'zz@gmail.com','010-0000-0000');  


select * from Address;