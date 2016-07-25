DELIMITER //

DROP PROCEDURE IF EXISTS datedimbuild;
CREATE PROCEDURE datedimbuild (p_start_date DATE, p_end_date DATE)
BEGIN
    DECLARE v_full_date DATE;

    DELETE FROM date;

    SET v_full_date = p_start_date;
    WHILE v_full_date < p_end_date DO

        INSERT INTO date (
            date,
            calenderMonth,
            calenderMonthNo,
            calenderQuarter,
            calenderYear
        ) VALUES (
            v_full_date,
			MONTHNAME(v_full_date),
            MONTH(v_full_date),
            QUARTER(v_full_date),
            YEAR(v_full_date)
        );

        SET v_full_date = DATE_ADD(v_full_date, INTERVAL 1 DAY);
    END WHILE;
END //
DELIMITER ;