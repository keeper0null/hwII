INSERT INTO students (id, "name") VALUES(1, 'Иван');
INSERT INTO students (id, "name") VALUES(2, 'Ольга');

select * 
  from students s 

INSERT INTO activity_scores
(student_id, activity_type, score)
VALUES(1, 'Homework', 90);

select * from activity_scores s;
select * from students s;

INSERT INTO activity_scores
(student_id, activity_type, score)
VALUES(2, 'Exam', 60);
INSERT INTO activity_scores
(student_id, activity_type, score)
VALUES(1, 'Exam', 40);

select * from activity_scores s;
select * from students s;
