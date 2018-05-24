CREATE TABLE conferences (
  id                        INT   IDENTITY,
  name                      VARCHAR(64)  NOT NULL,
  description               VARCHAR(255) NOT NULL,
  start_date                DATETIME2(0) NOT NULL,
  end_date                  DATETIME2(0) NOT NULL,
  basic_price               SMALLMONEY   NOT NULL,
  student_discount          FLOAT CONSTRAINT df_conferences_student_discount DEFAULT NULL,
  maximum_attendee_capacity INT          NOT NULL,

  CONSTRAINT pk_conferences PRIMARY KEY (id),
  CONSTRAINT ck_conferences_start_date CHECK (start_date > CURRENT_TIMESTAMP),
  CONSTRAINT ck_conferences_end_date CHECK (end_date > start_date),
  CONSTRAINT ck_conferences_student_discount CHECK (student_discount > 0 AND student_discount <= 1),
);

CREATE TABLE conference_discounts
(
  id            INT IDENTITY,
  conference_id INT          NOT NULL,
  due_date      DATETIME2(0) NOT NULL,
  discount      FLOAT        NOT NULL,

  CONSTRAINT pk_conference_discounts PRIMARY KEY (id),
  CONSTRAINT fk_conference_discounts_conference FOREIGN KEY (conference_id) REFERENCES conferences,
  CONSTRAINT ck_conference_discounts_discount CHECK (discount > 0 AND discount <= 1),
  CONSTRAINT ck_conference_discounts_due_date CHECK (due_date > CURRENT_TIMESTAMP),
  CONSTRAINT uq_conference_discounts_due_date UNIQUE (conference_id, due_date)
);
CREATE TRIGGER conference_discounts_due_date_earlier_than_conference_start_date
  ON conference_discounts
  AFTER INSERT, UPDATE AS IF (SELECT due_date
                              from inserted) > (SELECT c.start_date
                                                FROM inserted
                                                  JOIN conferences c ON inserted.conference_id = c.id)
  BEGIN
    RAISERROR ('Discount due date must be earlier than conference start date.', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN
  END;

CREATE TABLE conference_days
(
  id            INT IDENTITY,
  conference_id INT  NOT NULL,
  date          DATE NOT NULL,

  CONSTRAINT pk_conference_days PRIMARY KEY (id),
  CONSTRAINT fk_conference_days_conference FOREIGN KEY (conference_id) REFERENCES conferences,
  -- TODO: date musi się mieścić w przedziale conferences.start_date -> conferences.end_date
);