/* a. Напишите SQL запрос который возвращает имена студентов и их аккаунт в Telegram у которых родной город “Казань” или “Москва”.
      Результат отсортируйте по имени студента в убывающем порядке */
select s.name
      ,s.telegram_contact 
  from student s 
 where s.city in ('Казань', 'Москва') 
order by
       s.name desc;

/* b. Напишите SQL запрос который возвращает данные по университетам в следующем виде (один столбец со всеми данными внутри) с сортировкой по полю "полная информация" */
select format('университет: %s; количество студентов: %s', c.name, c.size) "полная информация"
  from college c 
order by "полная информация";

/* c. Напишите SQL запрос который возвращает список университетов и количество студентов,
      если идентификатор университета должен быть выбран из списка 10, 30, 50.
      Пожалуйста примените конструкцию IN.
      Результат запроса отсортируйте по количеству студентов И затем по наименованию университета.*/
select c.name
      ,c.size
  from college c 
 where c.id in (10, 30, 50)
order by
       c.size
      ,c.name;
      
/*d. Напишите SQL запрос который возвращает список университетов и количество студентов,
     если идентификатор университета НЕ должен соответствовать значениям из списка 10, 30, 50.
     Пожалуйста в основе примените конструкцию IN.
     Результат запроса отсортируйте по количеству студентов И затем по наименованию университета.*/
select c.name
      ,c.size
  from college c 
 where c.id not in (10, 30, 50)
order by
       c.size
      ,c.name;
      
/*e. Напишите SQL запрос который возвращает название online курсов университетов и количество заявленных слушателей.
     Количество заявленных слушателей на курсе должно быть в диапазоне от 27 до 310 студентов.
     Результат отсортируйте по названию курса и по количеству заявленных слушателей в убывающем порядке для двух полей.*/
select c.name
      ,c.amount_of_students
  from course c 
 where c.amount_of_students between 27 and 310
order by 
       c.name desc
      ,c.amount_of_students desc;
      
/*f. Напишите SQL запрос который возвращает имена студентов и название курсов университетов в одном списке.
     Результат отсортируйте в убывающем порядке.*/
select x.name
  from (
        select s.name
          from student s
        union all
        select c.name
          from course c) x
order by x.name desc;

/*g. Напишите SQL запрос который возвращает имена университетов и название курсов в одном списке,
     но с типом что запись является или "университет" или "курс".
     Результат отсортируйте в убывающем порядке по типу записи и потом по имени.*/
select x.name
      ,x.object_type
  from (
        select c.name, 'университет' object_type
          from college c
        union all
        select c.name, 'курс' object_type
          from course c) x
order by
       x.object_type desc
      ,x.name; --из постатновки не понятно по имени по возрастанию или по убыванию, сделал по возрастанию т.к. на примере по возрастанию похоже
      
/*h. Напишите SQL запрос который возвращает название курса и количество заявленных студентов
     в отсортированном списке по количеству слушателей в возрастающем порядке,
     НО запись с количеством слушателей равным 300 должна быть на первом месте.
     Ограничьте вывод данных до 3 строк.*/
select c.name
      ,c.amount_of_students 
  from course c
order by
      case when c.amount_of_students = 300 then -1 else c.amount_of_students end 
limit 3;
  
/*i. Напишите DML запрос который создает новый offline курс со следующими характеристиками:
- id = 60
- название курса = Machine Learning
- количество студентов = 17
- курс проводится в том же университете что и курс Data Mining  */
insert into course (id, name, amount_of_students, college_id)
select 60 id
      ,'Machine Learning' name
      ,17 amount_of_students 
      ,c.college_id 
  from course c 
 where c.name = 'Data Mining';
 
select *
  from course c ;
  
/*j. Напишите SQL скрипт который подсчитывает симметрическую разницу множеств A и B.
     (A \ B) ⋃ (B \ A)
     где A - таблица course,
     B - таблица student_on_course,
     "\" - это разница множеств,
     "⋃" - объединение множеств.
     Необходимо подсчитать на основании атрибута id из обеих таблиц.
     Результат отсортируйте по 1 столбцу.*/
with 
    a as (select c.id from course c )
   ,b as (select soc.id from student_on_course soc) 
select id
  from (
        (select id from a
        except
        select id from b)
        union
        (select id from b
        except
        select id from a)) x
order by 1;

/*k. Напишите SQL запрос который вернет имена студентов, курс на котором они учатся, 
     названия их родных университетов (в которых они официально учатся) и соответствующий рейтинг по курсу.
     С условием что рассматриваемый рейтинг студента должен быть строго больше (>) 50 баллов
     и размер соответствующего ВУЗа должен быть строго больше (>) 5000 студентов.
     Результат необходимо отсортировать по первым двум столбцам.*/
select s.name student_name
      ,cr.name course_na
      ,cl.name  student_college
      ,soc.student_rating 
  from student s
  join student_on_course soc on
       soc.student_id = s.id 
  join course cr on
       cr.id = soc.course_id 
  join college cl on
       cl.id = s.college_id 
 where soc.student_rating > 50
   and cl.size > 5000
order by 1, 2;


/*l. Выведите уникальные семантические пары студентов, родной город которых один и тот же.
     Результат необходимо отсортировать по первому столбцу.
     Семантически эквивалентная пара является пара студентов например (Иванов, Петров) = (Петров, Иванов),
     в этом случае должна быть выведена одна из пар.*/
select x.student_1
      ,x.student_2
      ,x.city
  from (
        select s.name student_1
              ,first_value(s.name) over (partition by s.city order by s.name) student_2
              ,row_number() over (partition by s.city order by s.name) rn
              ,s.city 
          from student s) x
 where x.rn > 1
 order by 1;
 
 /*m. Напишите SQL запрос который возвращает количество студентов, сгруппированных по их оценке.
      Результат отсортируйте по названию оценки студента.
      Формула выставления оценки представлена ниже как псевдокод.
      ЕСЛИ оценка < 30 ТОГДА неудовлетворительно
      ЕСЛИ оценка >= 30 И оценка < 60 ТОГДА удовлетворительно
      ЕСЛИ оценка >= 60 И оценка < 85 ТОГДА хорошо
      В ОСТАЛЬНЫХ СЛУЧАЯХ отлично*/
select case
        when soc.student_rating < 30 then 'неудовлетворительно'
        when soc.student_rating >= 30 and soc.student_rating < 60  then 'удовлетворительно'
        when soc.student_rating >= 60 and soc.student_rating < 85  then 'хорошо'
       else 'отлично' end "оценка"
      ,count(1) "количество студентов"
  from student_on_course soc 
group by 1
order by "оценка";

/*n. Дополните SQL запрос из задания a), с указанием вывода имени курса и количество оценок внутри курса.
     Результат отсортируйте по названию курса и оценки студента.*/
select c.name "курс"
      ,case
        when soc.student_rating < 30 then 'неудовлетворительно'
        when soc.student_rating >= 30 and soc.student_rating < 60  then 'удовлетворительно'
        when soc.student_rating >= 60 and soc.student_rating < 85  then 'хорошо'
       else 'отлично' end "оценка"
      ,count(1) "количество студентов"
  from student_on_course soc 
  join course c on
       c.id = soc.course_id 
group by 1, 2
order by "курс", "оценка";