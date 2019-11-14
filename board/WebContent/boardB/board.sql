drop table Board;

create table Board (
	id int not null auto_increment,
	userName varchar(20),
	title varchar(20),
	content varchar(100),
	primary key (id)
) charset=utf8;

insert into Board(userName, title, content) values ('abcd', 'is title', 'is content');  


select * from Board;