
create table school(
    school_id int primary key,
    schoolname varchar2(255) not null,
    description varchar2(255),
    Address varchar2(255),
    phone varchar2(255),
    postcode varchar2(255),
    postaddress varchar2(255) ,
    unique(schoolname) 
);
INSERT INTO school values(101,'czs','best place in earth','cumilla','0123','3507','kandirpar');

INSERT INTO school values(102,'bzs','not the best place in earth','barisal','0123','3507','kandirpar');

INSERT INTO school values(103,'rzs','not the best place in earth','rangpur','0123','3507','kandirpar');



create table class(
    class_id int not null,
    school_id int not null,
    ClassName varchar2(50),
    description varchar2(255),
    primary key(class_id),
     FOREIGN KEY (school_id) REFERENCES school(school_id),
     unique(ClassName)
);
INSERT INTO class values(1001,101,'six','abcd');
INSERT INTO class values(1002,102,'seven','abcd');
INSERT INTO class values(1003,103,'nine','abcd');



create table teacher(
    teacher_id int not null,
    school_id int ,
    teacher_name varchar2(50),
    description varchar2(255),
    primary key(teacher_id),
    FOREIGN KEY (school_id) REFERENCES school(school_id)
);
INSERT INTO teacher values(11,101,'eren yeger','abc');
INSERT INTO teacher values(12,101,'mikasa ackerman','abc');
INSERT INTO teacher values(13,101,'yagami','abc');


create table course(
    course_id int not null,
    school_id int not null,
    course_name varchar2(50),
    description varchar2(255),
    primary key(course_id),
    FOREIGN KEY (school_id) REFERENCES school(school_id)
);
INSERT INTO course values(4501,101,'OS','abc');
INSERT INTO course values(4503,101,'MicroP','abc');
INSERT INTO course values(4508,101,'RDBMS','abc');




create table course_teacher(
    teacher_id int  ,
    course_id  int ,
    primary key(teacher_id,course_id),
    FOREIGN KEY(teacher_id) REFERENCES teacher(teacher_id),
    foreign key(course_id) REFERENCES course(course_id)
);
INSERT INTO course_teacher values(11,4501);
INSERT INTO course_teacher values(12,4503);
INSERT INTO course_teacher values(13,4503);



CREATE TABLE student (
    student_id INT PRIMARY KEY,
    class_id INT NOT NULL,
    student_name VARCHAR(255) NOT NULL,
    student_number INT,
    TotalGrade DECIMAL(4, 2) CHECK (TotalGrade >= 2.0 AND TotalGrade <= 4.0),
    address VARCHAR(255) DEFAULT 'IUT',
    phone VARCHAR2(15),
    email VARCHAR(255) CHECK (email LIKE '%@gmail.com'),
    FOREIGN KEY (class_id) REFERENCES class (class_id)
);

INSERT INTO student(class_id,student_name, student_number, TotalGrade, address, phone, email)
VALUES (1001,'Jane Smith', 1, 3.95, '456 Elm St', '5555678', 'jane.smith@gmail.com');

INSERT INTO student(class_id,student_name, student_number, TotalGrade, phone, email)
VALUES (1001,'Joe rogan', 1, 3.95,  '5555678', 'jane.smith@gmail.com');

INSERT INTO student(class_id,student_name, student_number, TotalGrade, phone, email)
VALUES (1001,'Captain Levi', 1, 4.00,  '666678', 'leviAckerman@gmail.com');



create table student_course(
    student_id int not null,
    course_id int  not null,
    FOREIGN key(student_id) REFERENCES  student(student_id) on delete cascade,
    FOREIGN key(course_id) REFERENCES course(course_id) on delete cascade
);
insert into student_course values(2041104,4501);
insert into student_course values(2041104,4503);




CREATE SEQUENCE student_id_sequence
    START WITH 2041101
    INCREMENT BY 1
    NOMAXVALUE
    NOCACHE;


create table std(
    std_id int primary key,
    name varchar2(10)
)
CREATE OR REPLACE TRIGGER set_student_id_trigger
BEFORE INSERT ON student
FOR EACH ROW
DECLARE
    v_query_result NUMBER;
BEGIN
    
    SELECT student_id_sequence.NEXTVAL INTO v_query_result FROM dual;
    :NEW.student_id := v_query_result;
END;
/

create table grade(
    student_id int not null,
    course_id int not null,
    grade NUMBER,
    FOREIGN key(student_id) REFERENCES student(student_id),
     foreign key(course_id) REFERENCES course(course_id)
);

insert into grade values(2041104,4501,4);
insert into grade values(2041104,4501,4);
insert into grade values(2041104,4501,4);