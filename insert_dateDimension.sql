DROP SEQUENCE date_seq;
CREATE SEQUENCE date_seq 
START WITH 100001
INCREMENT BY 1;

DECLARE
   every_date               DATE;
   end_date                 DATE;
   v_day_of_week            NUMBER(1);
   v_day_of_month           NUMBER(2);
   v_day_of_year            NUMBER(3);
   last_day_month_ind       CHAR(1);
   v_week_end_date          DATE;
   v_week_in_year           NUMBER(2);
   v_month_name             VARCHAR(9);
   v_month_no               NUMBER(2);
   v_year_month             CHAR(7);
   v_quarter                CHAR(2);
   v_year_quarter           CHAR(6); 
   v_year                   NUMBER(4);
   v_holiday_ind            CHAR(1);
   v_weekday_ind            CHAR(1);

BEGIN
   every_date     := TO_DATE('01/01/2016','dd/mm/yyyy');
   end_date       := TO_DATE('31/12/2023','dd/mm/yyyy');
   v_holiday_ind  :='N';

   WHILE (every_date <= end_date) LOOP
      v_day_of_week    := TO_CHAR(every_date,'D');
      v_day_of_month   := TO_CHAR(every_date,'DD');
      v_day_of_year    := TO_CHAR(every_date,'DDD');

      IF every_date = Last_Day(every_date) THEN
        last_day_month_ind := 'Y';
      END IF;

      v_week_end_date  := every_date + (7 - (TO_CHAR(every_date,'d')));
  
      v_week_in_year   := TO_CHAR(every_date,'IW');
      v_month_name     := TO_CHAR(every_date,'MONTH');
      v_month_no       := EXTRACT(MONTH FROM every_date);
      v_year_month     := TO_CHAR(every_date,'YYYY-MM');

      IF (v_month_no <= 3) THEN
        v_quarter := 'Q1';
      ELSIF (v_month_no <= 6) THEN
        v_quarter := 'Q2';
      ELSIF (v_month_no <= 9) THEN
        v_quarter := 'Q3';
      ELSE
        v_quarter := 'Q4';
      END IF;

      v_year          := EXTRACT(YEAR FROM every_date);
      v_year_quarter  := v_year||v_quarter;

      IF (v_day_of_week BETWEEN 2 AND 6) THEN
        v_weekday_ind := 'Y';
      ELSE
        v_weekday_ind := 'N';
      END IF;
      
      INSERT INTO Date_Dimension VALUES(date_seq.nextval,
                                  every_date,
                                  v_day_of_week,
                                  v_day_of_month,
                                  v_day_of_year,
                                  last_day_month_ind,
                                  v_week_end_date,
                                  v_week_in_year,
                                  v_month_name,
                                  v_month_no,
                                  v_year_month,
                                  v_quarter,
                                  v_year_quarter, 
                                  v_year,
                                  v_holiday_ind,
                                  v_weekday_ind
                                 );
      every_date := every_date + 1;
   END LOOP;
END;
/