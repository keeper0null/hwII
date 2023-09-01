import psycopg2

try:
    conn = psycopg2.connect("dbname='demo' user='postgres' host='localhost' password='ic2database'")
except:
    print("Нет подключения к БД")

with conn.cursor() as curs:

    try:
        curs.execute("""
select f.flight_id 
      ,f.flight_no 
      ,f.scheduled_departure 
      ,f.scheduled_arrival 
  from v_on_time_board f""")
        many_rows = curs.fetchmany(11)
        print(*many_rows, sep = "\n")

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)