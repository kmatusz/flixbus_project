--
-- File generated with SQLiteStudio v3.2.1 on czw. sty 2 22:11:42 2020
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: cities
CREATE TABLE cities (
    city_id   INT PRIMARY KEY,
    city_name INT
);

INSERT INTO cities (
                       city_id,
                       city_name
                   )
                   VALUES (
                       1915,
                       'Kraków'
                   );

INSERT INTO cities (
                       city_id,
                       city_name
                   )
                   VALUES (
                       1815,
                       'Gdańsk'
                   );

INSERT INTO cities (
                       city_id,
                       city_name
                   )
                   VALUES (
                       7588,
                       'Łódź'
                   );


-- Table: distances
CREATE TABLE distances (
    start_city INT NOT NULL,
    end_city   INT NOT NULL,
    distance   INT,
    PRIMARY KEY (
        start_city,
        end_city
    ),
    FOREIGN KEY (
        start_city
    )
    REFERENCES cities (city_id) 
);

INSERT INTO distances (
                          start_city,
                          end_city,
                          distance
                      )
                      VALUES (
                          1915,
                          1815,
                          150
                      );

INSERT INTO distances (
                          start_city,
                          end_city,
                          distance
                      )
                      VALUES (
                          1915,
                          7588,
                          250
                      );

INSERT INTO distances (
                          start_city,
                          end_city,
                          distance
                      )
                      VALUES (
                          1815,
                          1915,
                          150
                      );

INSERT INTO distances (
                          start_city,
                          end_city,
                          distance
                      )
                      VALUES (
                          7588,
                          1915,
                          250
                      );


-- Table: execution_logs
CREATE TABLE execution_logs (
    id         INT            PRIMARY KEY,
    request_id INT,
    successful TINYINT,
    time       DATETIME,
    details    VARCHAR (1000),
    FOREIGN KEY (
        request_id
    )
    REFERENCES requests (request_id) 
);


-- Table: jobs
CREATE TABLE jobs (
    job_id       INTEGER      PRIMARY KEY AUTOINCREMENT,
    user_created INT,
    active       TINYINT      DEFAULT 1,
    time_created DATETIME,
    last_run     DATETIME,
    job_name     VARCHAR (20),
    FOREIGN KEY (
        user_created
    )
    REFERENCES users (user_id) 
);

INSERT INTO jobs (
                     job_id,
                     user_created,
                     active,
                     time_created,
                     last_run,
                     job_name
                 )
                 VALUES (
                     1,
                     1,
                     1,
                     '2019-10-10',
                     NULL,
                     'test_job'
                 );

INSERT INTO jobs (
                     job_id,
                     user_created,
                     active,
                     time_created,
                     last_run,
                     job_name
                 )
                 VALUES (
                     2,
                     1,
                     1,
                     '2019-10-11',
                     NULL,
                     'test2_job'
                 );

INSERT INTO jobs (
                     job_id,
                     user_created,
                     active,
                     time_created,
                     last_run,
                     job_name
                 )
                 VALUES (
                     3,
                     1,
                     1,
                     '2020-01-02 20:01:20',
                     NULL,
                     'trip to Cracow'
                 );

INSERT INTO jobs (
                     job_id,
                     user_created,
                     active,
                     time_created,
                     last_run,
                     job_name
                 )
                 VALUES (
                     6,
                     2,
                     1,
                     '2020-01-02 21:20:48',
                     NULL,
                     'Trip to the sea in March'
                 );

INSERT INTO jobs (
                     job_id,
                     user_created,
                     active,
                     time_created,
                     last_run,
                     job_name
                 )
                 VALUES (
                     7,
                     2,
                     1,
                     '2020-01-02 21:24:43',
                     NULL,
                     'City break in January'
                 );

INSERT INTO jobs (
                     job_id,
                     user_created,
                     active,
                     time_created,
                     last_run,
                     job_name
                 )
                 VALUES (
                     8,
                     1,
                     1,
                     '2020-01-02 21:30:42',
                     NULL,
                     'Trip between Gdansk and Lodz'
                 );


-- Table: requests
CREATE TABLE requests (
    request_id INTEGER PRIMARY KEY AUTOINCREMENT,
    job_id     INT,
    start_city INT,
    end_city   INT,
    date       DATE,
    FOREIGN KEY (
        job_id
    )
    REFERENCES jobs (job_id),
    FOREIGN KEY (
        start_city
    )
    REFERENCES cities (city_id),
    FOREIGN KEY (
        end_city
    )
    REFERENCES cities (city_id) 
);

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         1,
                         1,
                         1915,
                         7588,
                         '2020-01-02'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         2,
                         1,
                         1915,
                         7588,
                         '2020-01-03'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         3,
                         1,
                         1915,
                         7588,
                         '2020-01-04'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         4,
                         2,
                         1915,
                         1815,
                         '2020-01-02'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         5,
                         3,
                         7588,
                         1915,
                         '2020-01-20'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         6,
                         3,
                         7588,
                         1915,
                         '2020-01-21'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         7,
                         3,
                         7588,
                         1915,
                         '2020-01-22'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         8,
                         3,
                         7588,
                         1915,
                         '2020-01-23'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         9,
                         3,
                         7588,
                         1915,
                         '2020-01-24'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         10,
                         3,
                         7588,
                         1915,
                         '2020-01-25'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         11,
                         3,
                         7588,
                         1915,
                         '2020-01-26'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         12,
                         3,
                         7588,
                         1915,
                         '2020-01-27'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         13,
                         3,
                         7588,
                         1915,
                         '2020-01-28'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         14,
                         3,
                         7588,
                         1915,
                         '2020-01-29'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         15,
                         3,
                         7588,
                         1915,
                         '2020-01-30'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         16,
                         3,
                         7588,
                         1915,
                         '2020-01-31'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         17,
                         3,
                         7588,
                         1915,
                         '2020-02-01'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         18,
                         6,
                         7588,
                         1815,
                         '2020-03-02'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         19,
                         6,
                         7588,
                         1815,
                         '2020-03-03'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         20,
                         6,
                         7588,
                         1815,
                         '2020-03-04'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         21,
                         6,
                         7588,
                         1815,
                         '2020-03-05'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         22,
                         7,
                         7588,
                         1915,
                         '2020-01-18'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         23,
                         8,
                         1815,
                         7588,
                         '2020-01-15'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         24,
                         8,
                         1815,
                         7588,
                         '2020-01-16'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         25,
                         8,
                         1815,
                         7588,
                         '2020-01-17'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         26,
                         8,
                         1815,
                         7588,
                         '2020-01-18'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         27,
                         8,
                         1815,
                         7588,
                         '2020-01-19'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         28,
                         8,
                         1815,
                         7588,
                         '2020-01-20'
                     );


-- Table: results
CREATE TABLE results (
    result_id      [INT AUTO INCREMENT],
    request_id     INT                  NOT NULL,
    time_created   DATETIME             NOT NULL,
    start_city     INT,
    end_city       INT,
    time           INT,
    date           DATE,
    price          DOUBLE,
    changes_number INT,
    PRIMARY KEY (
        result_id
    ),
    FOREIGN KEY (
        request_id
    )
    REFERENCES requests (request_id),
    FOREIGN KEY (
        start_city
    )
    REFERENCES cities (city_id),
    FOREIGN KEY (
        end_city
    )
    REFERENCES cities (city_id),
    FOREIGN KEY (
        date
    )
    REFERENCES working_days (date) 
);

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        1,
                        1,
                        1577728921,
                        1915,
                        7588,
                        '00:30',
                        '02.01.2020',
                        69.99,
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        2,
                        1,
                        1577728980,
                        1915,
                        7588,
                        '07:05',
                        '02.01.2020',
                        69.99,
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        3,
                        1,
                        1577729000,
                        1915,
                        7588,
                        '12:00',
                        '02.01.2020',
                        69.99,
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        4,
                        1,
                        1577729242,
                        1915,
                        7588,
                        '15:10',
                        '02.01.2020',
                        69.99,
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        5,
                        1,
                        1577729540,
                        1915,
                        7588,
                        '19:15',
                        '02.01.2020',
                        69.99,
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        6,
                        1,
                        1577730200,
                        1915,
                        7588,
                        '23:59',
                        '02.01.2020',
                        39.99,
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        7,
                        2,
                        1577730280,
                        1915,
                        7588,
                        '00:30',
                        '03.01.2019',
                        69.99,
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        8,
                        2,
                        1577730350,
                        1915,
                        7588,
                        '07:05',
                        '03.01.2019',
                        55.99,
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        9,
                        2,
                        1577730700,
                        1915,
                        7588,
                        '12:00',
                        '03.01.2019',
                        59.99,
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        10,
                        2,
                        1577730956,
                        1915,
                        7588,
                        '15:10',
                        '03.01.2019',
                        69.99,
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        11,
                        2,
                        1577731201,
                        1915,
                        7588,
                        '19:15',
                        '03.01.2019',
                        69.99,
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        12,
                        2,
                        1577731400,
                        1915,
                        7588,
                        '23:59',
                        '03.01.2019',
                        45.99,
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        13,
                        3,
                        1577731470,
                        1915,
                        7588,
                        '00:30',
                        '04.01.2019',
                        55.99,
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        14,
                        3,
                        1577731620,
                        1915,
                        7588,
                        '07:05',
                        '04.01.2019',
                        49.99,
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        15,
                        3,
                        1577731840,
                        1915,
                        7588,
                        '12:00',
                        '04.01.2019',
                        49.99,
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        16,
                        3,
                        1577732100,
                        1915,
                        7588,
                        '15:10',
                        '04.01.2019',
                        59.99,
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        17,
                        3,
                        1577732200,
                        1915,
                        7588,
                        '19:15',
                        '04.01.2019',
                        69.99,
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        18,
                        3,
                        1577732300,
                        1915,
                        7588,
                        '23:59',
                        '04.01.2019',
                        45.99,
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        19,
                        4,
                        1577732400,
                        1915,
                        1815,
                        '07:05',
                        '02.01.2020',
                        129.99,
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        20,
                        4,
                        1577732500,
                        1915,
                        1815,
                        '11:50',
                        '02.01.2020',
                        95.98,
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        21,
                        4,
                        1577732600,
                        1915,
                        1815,
                        '12:00',
                        '02.01.2020',
                        'NULL',
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        22,
                        4,
                        1577732700,
                        1915,
                        1815,
                        '16:40',
                        '02.01.2020',
                        105.98,
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        23,
                        4,
                        1577732800,
                        1915,
                        1815,
                        '17:50',
                        '02.01.2020',
                        128.0,
                        0
                    );

INSERT INTO results (
                        result_id,
                        request_id,
                        time_created,
                        start_city,
                        end_city,
                        time,
                        date,
                        price,
                        changes_number
                    )
                    VALUES (
                        24,
                        4,
                        1577732900,
                        1915,
                        1815,
                        '21:10',
                        '02.01.2020',
                        119.98,
                        0
                    );


-- Table: users
CREATE TABLE users (
    user_id      INT          PRIMARY KEY,
    name         VARCHAR (30),
    password     VARCHAR (30),
    admin        TINYINT      NOT NULL
                              DEFAULT 0,
    active       TINYINT      NOT NULL
                              DEFAULT 1,
    time_created DATE,
    UNIQUE (
        name
    )
);

INSERT INTO users (
                      user_id,
                      name,
                      password,
                      admin,
                      active,
                      time_created
                  )
                  VALUES (
                      1,
                      'adam',
                      'pass1',
                      0,
                      1,
                      '10.10.2019'
                  );

INSERT INTO users (
                      user_id,
                      name,
                      password,
                      admin,
                      active,
                      time_created
                  )
                  VALUES (
                      2,
                      'tom',
                      'pass2',
                      0,
                      1,
                      '10.10.2019'
                  );

INSERT INTO users (
                      user_id,
                      name,
                      password,
                      admin,
                      active,
                      time_created
                  )
                  VALUES (
                      3,
                      'admin',
                      'admin',
                      1,
                      1,
                      '10.10.2019'
                  );


-- Table: working_days
CREATE TABLE working_days (
    date    INT     PRIMARY KEY,
    weekday INT,
    working TINYINT
);

INSERT INTO working_days (
                             date,
                             weekday,
                             working
                         )
                         VALUES (
                             '02.01.2020',
                             4,
                             1
                         );

INSERT INTO working_days (
                             date,
                             weekday,
                             working
                         )
                         VALUES (
                             '03.01.2019',
                             5,
                             1
                         );

INSERT INTO working_days (
                             date,
                             weekday,
                             working
                         )
                         VALUES (
                             '04.01.2019',
                             6,
                             0
                         );


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
