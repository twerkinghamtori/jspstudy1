drop table member;

create table member (
   id varchar(20) primary key,
   pass varchar(20),
   name varchar(20),
   gender int(1),
   tel varchar(15),
   email varchar(50),
   picture varchar(200)
);

select * from member