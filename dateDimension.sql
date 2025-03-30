CREATE TABLE Date_Dimension(
	dateKey				NUMBER 		NOT NULL,
 	calendarDate		DATE, 
 	dayOfWeek			NUMBER(1), 
 	dayNumCalMonth     	NUMBER(2), 
 	dayNumCalYear     	NUMBER(3), 
 	lastDayInMonthInd 	CHAR(1),   
 	calWeekEndDate     	DATE,      
 	calWeekInYear      	NUMBER(2), 
 	calMonthName        VARCHAR(9),
 	calMonthNoInYear  	NUMBER(2), 
 	calYearMonth        CHAR(7),   
 	calQuarter          CHAR(2),   
 	calYearQuarter      CHAR(6),   
 	calYear             NUMBER(4), 
 	holidayInd          CHAR(1),  
 	weekdayInd          CHAR(1),   
	PRIMARY KEY(dateKey)
);
