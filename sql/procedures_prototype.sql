-- CREATE PROCEDURE create_conference
--     @name VARCHAR(64),
--     @description VARCHAR(255),
--     @start_date DATETIME2,
--     @end_date DATETIME2,
--     @basic_price SMALLMONEY,
--     @student_discount FLOAT,
--     @max_attendees INT
--   insert conference and create conference days

-- CREATE PROCEDURE create_conference_discount
--     @conference_id INT,
--     @due_date      DATETIME2,
--     @discount      FLOAT
--   -- insert discount

-- CREATE PROCEDURE create_workshop
--     @name          VARCHAR(64),
--     @max_attendees INT
-- -- insert workshop

-- CREATE PROCEDURE create_workshop_day
--     @workshop_id   INT,
--     @conference_id INT,
--     @date          DATE,
--     @start_time    DATETIME2,
--     @end_time      DATETIME2,
--     @price         SMALLMONEY,
--     @max_attendees INT
--   -- find conference day and insert workshop day

-- CREATE PROCEDURE create_company_customer
--     @phone_number VARCHAR(32),
--     @company_name         VARCHAR(255),
--     @nip          VARCHAR(32)
--   -- insert customer, then insert company

-- CREATE PROCEDURE create_individual_customer
--     @phone_number VARCHAR(32),
--     @first_name   VARCHAR(255),
--     @second_name  VARCHAR(255)

-- CREATE PROCEDURE pay_for_reservation
  -- insert current date to payment_date