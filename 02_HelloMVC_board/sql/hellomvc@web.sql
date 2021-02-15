--==============================================
-- 관리자(system)계정
--==============================================
--web계정 생성
create user web
identified by web
default tablespace users;

grant connect, resource to web;

--==============================================
-- web 계정
--==============================================
create table member (
		member_id varchar2(15),                       --PK
		password varchar2(300) not null,              --필수
		member_name varchar2(30) not null,            --필수
		member_role char(1) default 'U' not null,     --필수
		gender char(1),
		birthday date,
		email varchar2(100),
		phone char(11) not null,                      --필수
		address varchar2(200),
		hobby varchar2(100),
		enroll_date date default sysdate,
		constraint pk_member_id primary key(member_id),
		constraint ck_gender check(gender in ('M', 'F')),
		constraint ck_member_role check(member_role in ('U', 'A'))
	);
	--회원 추가
	insert into member
	values (
		'honggd', '1234', '홍길동', 'U', 'M', to_date('20000909','yyyymmdd'),
		'honggd@naver.com', '01012341234', '서울시 강남구', '운동,등산,독서', default);
	insert into member
	values (
		'qwerty', '1234', '쿠어티', 'U', 'F', to_date('19900215','yyyymmdd'),
		'qwerty@naver.com', '01012341234', '서울시 송파구', '운동,등산', default);
	insert into member
	values (
		'admin', '1234', '관리자', 'A', 'M', to_date('19801010','yyyymmdd'),
		'admin@naver.com', '01056785678', '서울시 관악구', '게임,독서', default);
	select * from member;
	commit;
    
    desc member;
    
    delete from member where member_id = 'ybjooooon';
    
    update member set password = '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==';

--페이징
--rownum
select *
from (
    select rownum rnum, E.*
    from(
            select * 
            from member
            order by enroll_date desc
        )E
    )E
where rnum between 11 and 20;

--row_number
select *
from (
        select M.*,
                    row_number() over(order by enroll_date desc) rnum
        from member M
    )M
where rnum between 11 and 20;

select * from (select M.*, row_number() over(order by enroll_date desc) rnum from member M )M where rnum between 11 and 20;

--페이징 검색
select *
from (
        select M.*,
                row_number() over(order by enroll_date desc) rnum
        from member M
        where member_id like '%a%'
    )
where rnum between 11 and 20;

--=====================================
--게시판
--=====================================

--게시판생성
	CREATE TABLE BOARD (
		BOARD_NO NUMBER,
		BOARD_TITLE VARCHAR2(50) NOT NULL,
		BOARD_WRITER VARCHAR2(15),
		BOARD_CONTENT VARCHAR2(2000) NOT NULL,
		BOARD_ORIGINAL_FILENAME VARCHAR2(200),
		BOARD_RENAMED_FILENAME VARCHAR2(200),
		BOARD_DATE DATE DEFAULT SYSDATE,
		BOARD_READ_COUNT NUMBER DEFAULT 0,
		CONSTRAINT PK_BOARD_NO PRIMARY KEY(BOARD_NO),
		CONSTRAINT FK_BOARD_WRITER FOREIGN KEY(BOARD_WRITER)
											 REFERENCES MEMBER(MEMBER_ID)
											 ON DELETE SET NULL
	);
	COMMENT ON TABLE BOARD IS '게시판테이블';
	COMMENT ON COLUMN "BOARD"."BOARD_NO" IS '게시글번호';
	COMMENT ON COLUMN "BOARD"."BOARD_TITLE" IS '게시글제목';
	COMMENT ON COLUMN "BOARD"."BOARD_WRITER" IS '게시글작성자 아이디';
	COMMENT ON COLUMN "BOARD"."BOARD_CONTENT" IS '게시글내용';
	COMMENT ON COLUMN "BOARD"."BOARD_ORIGINAL_FILENAME" IS '첨부파일원래이름';
	COMMENT ON COLUMN "BOARD"."BOARD_RENAMED_FILENAME" IS '첨부파일변경이름';
	COMMENT ON COLUMN "BOARD"."BOARD_DATE" IS '게시글올린날짜';
	COMMENT ON COLUMN "BOARD"."BOARD_READ_COUNT" IS '조회수';
	--게시판시퀀스생성
	CREATE SEQUENCE SEQ_BOARD_NO
	START WITH 1
	INCREMENT BY 1
	NOMINVALUE
	NOMAXVALUE
	NOCYCLE
	NOCACHE;
    
select *
from user_col_comments      -- 컬럼 코멘트 확인
where table_name = 'BOARD';

select * from board;

commit;




--회원추가

Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) 
values ('hihiroo','NieQminDE4Ggcewn98nKl3Jhgq7Smn3dLlQ1MyLPswq7njpt8qwsIP4jQ2MR1nhWTQyNMFkwV19g4tPQSBhNeQ==','김안녕','U','F',to_date('01/10/18','RR/MM/DD'),'hihiroo@naver.com','01023454635','경기도 시흥시','운동,여행',to_date('18/02/05','RR/MM/DD'));

Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('encrypten_man','mZNR9KFjogJnD9J0+gGMKxAAstZidIXEKPLv+Ns42TvZY/o9QcBbDR0s1Vjm4a5HqKZDVPH+sAuM1BD/YwKyVw==','암호화','U','M',to_date('91/02/03','RR/MM/DD'),null,'01012341243',null,null,to_date('18/03/24','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('abcd','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김준호','U','M',to_date('92/02/02','RR/MM/DD'),'abcd@naver.com','01012345678','서울시 관악구','운동,등산,독서',to_date('18/02/01','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('bcde','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','서지와','U','F',to_date('93/01/20','RR/MM/DD'),'bcde@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('18/03/02','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('cdef','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김윤정','U','M',to_date('94/04/20','RR/MM/DD'),'cdef@naver.com','01056745678','서울시 강북구','운동,독서',to_date('18/11/03','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('defg','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','박봉철','U','F',to_date('95/01/20','RR/MM/DD'),'defg@naver.com','01012345678','서울시 중구','운동,등산,독서',to_date('18/04/04','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('efgh','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','하정운','U','M',to_date('96/06/03','RR/MM/DD'),'efgh@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('18/11/05','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('fghi','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','유병송','U','F',to_date('97/01/01','RR/MM/DD'),'fghi@naver.com','01056745678','서울시 중구','운동,등산,독서',to_date('18/03/06','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('ghij','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','노민우','U','M',to_date('98/07/02','RR/MM/DD'),'ghij@naver.com','01056745678','서울시 관악구','운동,등산,독서',to_date('18/11/07','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('hijk','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김지호','U','M',to_date('99/04/18','RR/MM/DD'),'hijk@naver.com','01012345678','서울시 관악구','등산,독서',to_date('18/06/08','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('ijkl','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','장동준','U','M',to_date('00/04/01','RR/MM/DD'),'ijkl@naver.com','01012345678','서울시 중랑구','운동,등산,독서',to_date('18/06/09','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('jklm','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','서연','U','M',to_date('89/07/20','RR/MM/DD'),'jklm@naver.com','01012345678','서울시 강남구','운동,등산,독서',to_date('18/06/10','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('klmn','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','서연호','U','M',to_date('88/04/15','RR/MM/DD'),'klmn@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('18/01/11','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('lmno','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김연우','U','M',to_date('87/03/01','RR/MM/DD'),'lmno@naver.com','01056745678','서울시 중랑구','운동,등산,독서',to_date('18/04/12','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('mnop','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','정지운','U','M',to_date('86/06/03','RR/MM/DD'),'mnop@naver.com','01056745678','서울시 관악구','운동,등산,독서',to_date('18/06/13','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('nopq','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','정구운','U','M',to_date('85/03/20','RR/MM/DD'),'nopq@naver.com','01012345678','서울시 관악구','운동,독서',to_date('18/04/14','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('opqr','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','안성우','U','M',to_date('84/07/01','RR/MM/DD'),'opqr@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('18/01/15','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('pqrs','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','이주은','U','M',to_date('83/01/18','RR/MM/DD'),'pqrs@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('18/01/16','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('qrst','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김보리','U','M',to_date('82/03/02','RR/MM/DD'),'qrst@naver.com','01056745678','서울시 중구','운동,등산,독서',to_date('18/11/17','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('rstu','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','차보라','U','M',to_date('81/06/01','RR/MM/DD'),'rstu@naver.com','01056745678','서울시 서초구','운동,등산,독서',to_date('18/06/18','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('stuv','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','장경자','U','M',to_date('80/07/15','RR/MM/DD'),'stuv@naver.com','01012345678','서울시 관악구','운동,등산,독서',to_date('18/01/19','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('tuvw','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','정성택','U','M',to_date('83/06/20','RR/MM/DD'),'tuvw@naver.com','01012345678','서울시 관악구','운동,등산,독서',to_date('18/03/01','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('uvwx','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김정은','U','M',to_date('02/07/18','RR/MM/DD'),'uvwx@naver.com','01012345678','서울시 서초구','운동,등산,독서',to_date('18/11/21','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('wxyz','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','박보람','U','M',to_date('75/01/01','RR/MM/DD'),'wxyz@naver.com','01098765678','서울시 중구','운동,등산,독서',to_date('18/07/22','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('catmom','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','구본우','U','M',to_date('79/06/15','RR/MM/DD'),'catmom@naver.com','01098765678','서울시 관악구','운동,등산,독서',to_date('18/04/23','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('bear','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','가제트','U','M',to_date('79/11/01','RR/MM/DD'),'bear@naver.com','01012345678','서울시 관악구','운동,독서',to_date('18/03/24','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('dogpapa','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','한석규','U','M',to_date('75/07/03','RR/MM/DD'),'dogpapa@naver.com','01012345678','서울시 강남구','운동,등산,독서',to_date('18/06/25','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('fishman','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','두석규','U','M',to_date('83/01/02','RR/MM/DD'),'fishman@naver.com','01012345678','서울시 강남구','등산,독서',to_date('18/07/26','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('buckey','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','세석규','U','M',to_date('75/01/01','RR/MM/DD'),'buckey@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('18/11/27','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('mmary','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','네석규','U','M',to_date('01/03/20','RR/MM/DD'),'mmary@naver.com','01012345678','서울시 관악구','운동,등산,독서',to_date('18/07/28','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('usbteacher','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','마동석','U','M',to_date('79/06/01','RR/MM/DD'),'usbteacher@naver.com','01012345678','서울시 중구','운동,등산,독서',to_date('18/01/29','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('mslove','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','아무개','U','M',to_date('75/11/03','RR/MM/DD'),'mslove@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('18/07/30','RR/MM/DD'));


Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('spongebob','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김밥','U','F',to_date('75/04/20','RR/MM/DD'),'spongebob@naver.com','01023454635','경기도 시흥시','운동,여행',to_date('16/02/05','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('ordovician','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','암호화','U','M',to_date('01/01/01','RR/MM/DD'),null,'01012341243',null,null,to_date('16/03/24','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('patli','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김준호','U','M',to_date('75/07/18','RR/MM/DD'),'patli@naver.com','01012345678','서울시 관악구','운동,등산,독서',to_date('16/04/01','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('skitz','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','서지와','U','F',to_date('79/07/02','RR/MM/DD'),'skitz@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('16/11/02','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('hlal','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','정윤정','U','M',to_date('75/06/03','RR/MM/DD'),'hlal@naver.com','01056745678','서울시 강북구','운동,독서',to_date('16/02/03','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('skytear','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','박봉철','U','F',to_date('83/11/15','RR/MM/DD'),'skyTear@naver.com','01012345678','서울시 중구','운동,등산,독서',to_date('16/07/04','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('leander','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','하정운','U','M',to_date('75/01/01','RR/MM/DD'),'leander@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('16/04/05','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('ripsnarl','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','유병송','U','F',to_date('90/07/03','RR/MM/DD'),'ripSnarl@naver.com','01056745678','서울시 중구','운동,등산,독서',to_date('16/06/06','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('eleuia','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','노민우','U','M',to_date('75/07/20','RR/MM/DD'),'eleuia@naver.com','01056745678','서울시 관악구','운동,등산,독서',to_date('16/01/07','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('mrcuddles','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김지호','U','M',to_date('79/06/01','RR/MM/DD'),'mrCuddles@naver.com','01012345678','서울시 관악구','등산,독서',to_date('16/02/08','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('lior','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','장동준','U','M',to_date('79/11/02','RR/MM/DD'),'lior@naver.com','01012345678','서울시 중랑구','운동,등산,독서',to_date('16/01/09','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('eseit','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','서연','U','M',to_date('75/01/18','RR/MM/DD'),'eseit@naver.com','01012345678','서울시 강남구','운동,등산,독서',to_date('16/07/10','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('shimmer','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','서연호','U','M',to_date('83/06/01','RR/MM/DD'),'shimmer@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('16/04/11','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('nibbles','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김연우','U','M',to_date('75/11/03','RR/MM/DD'),'nibbles@naver.com','01056745678','서울시 중랑구','운동,등산,독서',to_date('16/01/12','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('pastel','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','정지운','U','F',to_date('79/11/15','RR/MM/DD'),'pastel@naver.com','01056745678','서울시 관악구','운동,등산,독서',to_date('16/04/13','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('pewner','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','정구운','U','M',to_date('75/07/20','RR/MM/DD'),'pewner@naver.com','01012345678','서울시 관악구','운동,독서',to_date('16/06/14','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('mrglows','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','안성우','U','M',to_date('83/02/01','RR/MM/DD'),'mrGlows@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('16/04/15','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('raich','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','이주은','U','M',to_date('01/01/02','RR/MM/DD'),'raich@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('16/11/16','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('jasmine','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김보리','U','M',to_date('75/07/03','RR/MM/DD'),'jasmine@naver.com','01056745678','서울시 중구','운동,등산,독서',to_date('16/01/17','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('zothath','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','차보라','U','M',to_date('75/02/20','RR/MM/DD'),'zothath@naver.com','01056745678','서울시 서초구','운동,등산,독서',to_date('16/07/18','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('imamu','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','장경자','U','M',to_date('79/06/01','RR/MM/DD'),'imamu@naver.com','01012345678','서울시 관악구','운동,등산,독서',to_date('16/01/19','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('floater','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','정성택','U','M',to_date('75/02/03','RR/MM/DD'),'floater@naver.com','01012345678','서울시 관악구','운동,등산,독서',to_date('16/01/15','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('nana','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김정은','U','M',to_date('79/09/20','RR/MM/DD'),'nana@naver.com','01012345678','서울시 서초구','운동,등산,독서',to_date('16/02/21','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('shotsathothu','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','박보람','U','M',to_date('75/07/02','RR/MM/DD'),'shotSathothu@naver.com','01098765678','서울시 중구','운동,등산,독서',to_date('16/01/22','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('kisaki','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','구본우','U','M',to_date('83/06/01','RR/MM/DD'),'kisaki@naver.com','01098765678','서울시 관악구','운동,등산,독서',to_date('16/07/23','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('notyours','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','가제트','U','M',to_date('79/07/03','RR/MM/DD'),'notYours@naver.com','01012345678','서울시 관악구','운동,독서',to_date('16/09/24','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('cipanr','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','한석규','U','M',to_date('75/02/01','RR/MM/DD'),'cipanr@naver.com','01012345678','서울시 강남구','운동,등산,독서',to_date('16/01/30','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('iarsere','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','두석규','U','M',to_date('90/02/18','RR/MM/DD'),'iarsere@naver.com','01012345678','서울시 강남구','등산,독서',to_date('16/04/26','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('kubcthothoth','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','세석규','U','M',to_date('75/02/03','RR/MM/DD'),'kubCthothoth@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('16/01/27','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('claw','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','네석규','U','M',to_date('79/02/01','RR/MM/DD'),'claw@naver.com','01012345678','서울시 관악구','운동,등산,독서',to_date('16/09/28','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('hibiscus','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','마동석','U','M',to_date('75/10/18','RR/MM/DD'),'hibiscus@naver.com','01012345678','서울시 중구','운동,등산,독서',to_date('16/04/29','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('elania','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','아무개','U','M',to_date('83/10/03','RR/MM/DD'),'elania@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('16/06/30','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('mothball','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','노바디','U','M',to_date('75/10/01','RR/MM/DD'),'mothball@naver.com','01012341234','서울시 중구','등산',to_date('16/03/24','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('ssynec','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','네오','U','M',to_date('79/02/02','RR/MM/DD'),'ssynec@naver.com','01040021863','서울시 강남구',null,to_date('16/04/15','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('amethyst','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','감사용','U','M',to_date('90/04/01','RR/MM/DD'),'amethyst@naver.com','01012341234','부산시 동래구','운동,등산',to_date('16/04/19','RR/MM/DD'));


Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('xapreiye','NieQminDE4Ggcewn98nKl3Jhgq7Smn3dLlQ1MyLPswq7njpt8qwsIP4jQ2MR1nhWTQyNMFkwV19g4tPQSBhNeQ==','허안녕','U','F',to_date('75/10/03','RR/MM/DD'),'xapreiye@naver.com','01023454635','경기도 시흥시','운동,여행',to_date('17/02/05','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('fliostium','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','부호화','U','M',to_date('83/10/02','RR/MM/DD'),null,'01012341243',null,null,to_date('17/03/24','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('ocrait','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','박준호','U','M',to_date('75/01/01','RR/MM/DD'),'ocrait@naver.com','01012345678','서울시 관악구','운동,등산,독서',to_date('17/09/01','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('oshary','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','치와와','U','F',to_date('79/04/20','RR/MM/DD'),'oshary@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('17/10/02','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('bleze','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','박윤정','U','M',to_date('75/06/03','RR/MM/DD'),'bleze@naver.com','01056745678','서울시 강북구','운동,독서',to_date('17/10/03','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('megriuvania','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','박성철','U','M',to_date('90/09/02','RR/MM/DD'),'megriuvania@naver.com','01012345678','전라도 여수시','운동,등산,독서',to_date('17/01/04','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('glosau','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','고정운','U','M',to_date('75/10/15','RR/MM/DD'),'glosau@naver.com','01012345678','서울시 송파구','독서',to_date('17/03/05','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('lasken','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','유병우','U','F',to_date('79/07/02','RR/MM/DD'),'lasken@naver.com','01056745678','수원시 팔달구','운동,등산,독서',to_date('17/04/06','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('nesnesh','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','노민호','U','M',to_date('90/09/03','RR/MM/DD'),'nesnesh@naver.com','01056745678','서울시 관악구','운동,등산,독서',to_date('17/10/07','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('granite','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김진호','U','M',to_date('75/01/20','RR/MM/DD'),'granite@naver.com','01012345678','서울시 관악구','등산,독서',to_date('17/09/08','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('arachnid','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','장옹이','U','M',to_date('75/10/01','RR/MM/DD'),'arachnid@naver.com','01012345678','서울시 중랑구','운동,등산,독서',to_date('17/04/09','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('blight','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','서지연','U','F',to_date('79/06/02','RR/MM/DD'),'blight@naver.com','01012345678','서울시 강남구','운동,등산,독서',to_date('17/10/10','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('mist','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','서연요','U','M',to_date('75/09/20','RR/MM/DD'),'mist@naver.com','01012345678','서울시 강북구','운동,등산',to_date('17/02/11','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('mouse','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김연유','U','M',to_date('02/10/03','RR/MM/DD'),'mouse@naver.com','01056745678','서울시 중랑구','운동,등산,독서',to_date('17/07/12','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('scramble','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','정지훈','U','M',to_date('75/10/20','RR/MM/DD'),'scramble@naver.com','01056745678','서울시 관악구','운동,등산,독서',to_date('17/01/13','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('rime','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','정수윤','U','F',to_date('90/04/02','RR/MM/DD'),'rime@naver.com','01012345678','서울시 관악구','운동,독서',to_date('17/10/14','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('wireless','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','안성호','U','M',to_date('79/07/01','RR/MM/DD'),'wireless@naver.com','01012345678','서울시 강북구','운동',to_date('17/02/15','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('fiend','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','이주흔','U','M',to_date('79/04/03','RR/MM/DD'),'fiend@naver.com','01012345678','서울시 강북구','운동,독서',to_date('17/01/16','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('pebble','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김보리차','U','M',to_date('01/04/02','RR/MM/DD'),'pebble@naver.com','01056745678','서울시 중구','운동,등산,독서',to_date('17/02/17','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('disperse','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','차보라','U','M',to_date('79/06/15','RR/MM/DD'),'disperse@naver.com','01056745678','서울시 서초구','등산,독서',to_date('17/02/18','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('inferno','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','장경택','U','M',to_date('01/09/02','RR/MM/DD'),'inferno@naver.com','01012345678','서울시 관악구','운동',to_date('17/10/19','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('virtue','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','정은택','U','M',to_date('90/02/01','RR/MM/DD'),'virtue@naver.com','01012345678','서울시 관악구','운동,등산,독서',to_date('17/04/20','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('plague','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김정인','U','F',to_date('79/01/03','RR/MM/DD'),'plague@naver.com','01012345678','서울시 서초구','등산,독서',to_date('17/03/21','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('light','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김보람','U','M',to_date('01/09/02','RR/MM/DD'),'light@naver.com','01098765678','서울시 중구','운동,등산,독서',to_date('17/02/22','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('plasma','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','구본승','U','M',to_date('02/04/02','RR/MM/DD'),'plasma@naver.com','01098765678','인천','등산',to_date('17/02/23','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('nightshade','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','가제현','U','M',to_date('90/10/20','RR/MM/DD'),'nightshade@naver.com','01012345678','서울시 관악구','운동,독서',to_date('17/01/24','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('ooze','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','한고은','U','F',to_date('01/06/02','RR/MM/DD'),'ooze@naver.com','01012345678','서울시 강남구','운동,등산,독서',to_date('17/09/25','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('shift','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','두고은','U','F',to_date('76/02/20','RR/MM/DD'),'shift@naver.com','01012345678','서울시 강남구','등산,독서',to_date('17/03/26','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('luna','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','세고은','U','F',to_date('02/02/03','RR/MM/DD'),'luna@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('17/09/27','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('cecirh','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','네고은','U','F',to_date('01/04/15','RR/MM/DD'),'cecirh@naver.com','01012345678','서울시 관악구','운동,등산,독서',to_date('17/04/28','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('illuminos','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','마동탁','U','M',to_date('76/02/02','RR/MM/DD'),'illuminos@naver.com','01012345678','서울시 중구','운동,등산,독서',to_date('17/10/29','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('shockwave','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','아무나','U','M',to_date('83/01/01','RR/MM/DD'),'shockwave@naver.com','01012345678','서울시 강북구','여행',to_date('17/02/15','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('thunder','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','애니바디','U','M',to_date('76/09/20','RR/MM/DD'),'thunder@naver.com','01012341234','서울시 중구','등산',to_date('17/03/24','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('steelskin','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김쇠살','U','M',to_date('90/10/01','RR/MM/DD'),'steelskin@naver.com','01040021863','서울시 강남구',null,to_date('17/04/01','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('glutton','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','감사용','U','M',to_date('83/02/02','RR/MM/DD'),'glutton@naver.com','01012341234','부산시 동래구','운동,등산',to_date('17/04/19','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('puma','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','하퓨마','U','M',to_date('76/04/03','RR/MM/DD'),'puma@naver.com','01012341234','부산광역시','운동',to_date('17/04/18','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('shadow','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','그리무','U','M',to_date('01/10/20','RR/MM/DD'),'shadow@naver.com','01012341234','대구','독서',to_date('17/04/17','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('bandit','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','반디','U','M',to_date('76/02/02','RR/MM/DD'),'bandit@naver.com','01012341234','충청남도','등산',to_date('17/04/16','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('pandemonium','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김판돌','U','M',to_date('83/03/03','RR/MM/DD'),'pandemonium@naver.com','01012341234','경상북도','등산,여행',to_date('17/04/15','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('shqkel','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','노바디','U','M',to_date('90/09/02','RR/MM/DD'),'shqkel@naver.com','01012341234','서울시 중구','등산',to_date('18/03/24','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('neoneo','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','네오','U','M',to_date('76/10/02','RR/MM/DD'),'neoneo@naver.com','01040021863','서울시 강남구',null,to_date('18/04/20','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('kamsayoyo','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','감사용','U','M',to_date('83/06/20','RR/MM/DD'),'ksy@naver.com','01012341234','부산시 동래구','운동,등산',to_date('18/04/19','RR/MM/DD'));

commit;