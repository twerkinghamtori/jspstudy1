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

insert into member (id,pass,name,gender,tel,email,picture) values (1,12,123,1,1234,12345,0);
select * from member

drop table board;
create table board (
   num int primary key,
   writer varchar(30),
   pass varchar(20),
   title varchar(100),
   content varchar(2000),
   file1 varchar(200),  -- 첨부파일명
   boardid varchar(2),  -- 게시판 종류=1?공지사항:2?자유게시판?3:QnA
   regdate datetime,    -- 등록일시
   readcnt int(10),     -- 조회수
   grp int,             -- 답글 작성시 원글의 게시글 번호
   grplevel int(3),     -- 답글의 레벨. (답글의 답글의 ...)
   grpstep int(5)       -- 그룹의 출력 순서 
);

select * from board;