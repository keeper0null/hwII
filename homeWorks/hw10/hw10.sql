create table if not exists students
(
     id serial 
    ,name text
    ,total_score integer
    ,primary key(id)
);
comment on column students.id is 'идентификатор студента';
comment on column students.name is 'имя студента';
comment on column students.total_score is 'общий балл студента';

create table if not exists activity_scores
(
     student_id integer references students (id)
    ,activity_type text
    ,score integer
);
comment on column activity_scores.student_id is 'ссылка на студента в таблице students';
comment on column activity_scores.activity_type is 'вид деятельности';
comment on column activity_scores.score is 'балл за деятельность';

create or replace function calculate_scholarship(p_total_score integer)
returns integer as $$
begin
    return case
            when p_total_score >= 90 then 1000
            when p_total_score >= 80 and p_total_score < 90 then 500
            else 0
           end case;
end;
$$ language plpgsql

alter table students add column scholarship integer;
comment on column students.scholarship is 'стипендия студента';

create or replace function calculate_total_score(student_id integer)
returns integer as $$
declare
    p_student_id alias for $1;
    v_total_score integer := 0;
    c_scores record;
begin
    for c_scores in (
        select s.score 
          from activity_scores s
         where s.student_id = p_student_id
    ) loop
        v_total_score := v_total_score + c_scores.score;
    end loop;

    return v_total_score;
end;
$$ language plpgsql

create or replace function update_total_score() 
returns trigger as $$
declare
    v_total_score integer;
    v_scholarship integer;
begin
    v_total_score := calculate_total_score(student_id =>  new.student_id);
    v_scholarship := calculate_scholarship(p_total_score => v_total_score);
    update students 
       set total_score = v_total_score
          ,scholarship = v_scholarship
     where id = new.student_id; 
    return new;
end;
$$ language plpgsql

create or replace trigger update_total_score_trigger
    after insert or update or delete on activity_scores 
    for each row execute procedure update_total_score();