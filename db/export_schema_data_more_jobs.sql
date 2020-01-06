--
-- File generated with SQLiteStudio v3.2.1 on pon. sty 6 22:49:57 2020
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

INSERT INTO cities (
                       city_id,
                       city_name
                   )
                   VALUES (
                       2035,
                       'Poznań'
                   );

INSERT INTO cities (
                       city_id,
                       city_name
                   )
                   VALUES (
                       2125,
                       'Szczecin'
                   );

INSERT INTO cities (
                       city_id,
                       city_name
                   )
                   VALUES (
                       8728,
                       'Rzeszów'
                   );

INSERT INTO cities (
                       city_id,
                       city_name
                   )
                   VALUES (
                       1765,
                       'Wrocław'
                   );

INSERT INTO cities (
                       city_id,
                       city_name
                   )
                   VALUES (
                       25731,
                       'Białystok'
                   );

INSERT INTO cities (
                       city_id,
                       city_name
                   )
                   VALUES (
                       7568,
                       'Warszawa'
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
    id         INTEGER        PRIMARY KEY AUTOINCREMENT,
    request_id INT,
    successful TINYINT,
    time       DATETIME,
    details    VARCHAR (1000),
    FOREIGN KEY (
        request_id
    )
    REFERENCES requests (request_id) 
);


-- Table: inserts_logs
CREATE TABLE inserts_logs (
    id          INTEGER      PRIMARY KEY AUTOINCREMENT,
    type        VARCHAR (30),
    inserted_id INT,
    time_added  DATETIME
);

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             1,
                             'job',
                             1,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             2,
                             'job',
                             2,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             3,
                             'job',
                             3,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             4,
                             'job',
                             6,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             5,
                             'job',
                             7,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             6,
                             'job',
                             8,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             7,
                             'request',
                             1,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             8,
                             'request',
                             2,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             9,
                             'request',
                             3,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             10,
                             'request',
                             4,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             11,
                             'request',
                             5,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             12,
                             'request',
                             6,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             13,
                             'request',
                             7,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             14,
                             'request',
                             8,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             15,
                             'request',
                             9,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             16,
                             'request',
                             10,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             17,
                             'request',
                             11,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             18,
                             'request',
                             12,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             19,
                             'request',
                             13,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             20,
                             'request',
                             14,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             21,
                             'request',
                             15,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             22,
                             'request',
                             16,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             23,
                             'request',
                             17,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             24,
                             'request',
                             18,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             25,
                             'request',
                             19,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             26,
                             'request',
                             20,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             27,
                             'request',
                             21,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             28,
                             'request',
                             22,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             29,
                             'request',
                             23,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             30,
                             'request',
                             24,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             31,
                             'request',
                             25,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             32,
                             'request',
                             26,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             33,
                             'request',
                             27,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             34,
                             'request',
                             28,
                             '2020-01-06 21:23:32'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             35,
                             'job',
                             9,
                             '2020-01-06 21:31:45'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             36,
                             'request',
                             29,
                             '2020-01-06 21:42:40'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             37,
                             'request',
                             30,
                             '2020-01-06 21:42:40'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             38,
                             'request',
                             31,
                             '2020-01-06 21:42:40'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             39,
                             'request',
                             32,
                             '2020-01-06 21:42:40'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             40,
                             'request',
                             33,
                             '2020-01-06 21:42:40'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             41,
                             'request',
                             34,
                             '2020-01-06 21:42:40'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             42,
                             'request',
                             35,
                             '2020-01-06 21:42:40'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             43,
                             'request',
                             36,
                             '2020-01-06 21:42:40'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             44,
                             'request',
                             37,
                             '2020-01-06 21:42:40'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             45,
                             'request',
                             38,
                             '2020-01-06 21:42:40'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             46,
                             'request',
                             39,
                             '2020-01-06 21:42:40'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             47,
                             'request',
                             40,
                             '2020-01-06 21:42:40'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             48,
                             'request',
                             41,
                             '2020-01-06 21:42:40'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             49,
                             'request',
                             42,
                             '2020-01-06 21:42:40'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             50,
                             'request',
                             43,
                             '2020-01-06 21:42:40'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             51,
                             'request',
                             44,
                             '2020-01-06 21:42:40'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             52,
                             'request',
                             45,
                             '2020-01-06 21:42:40'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             53,
                             'request',
                             46,
                             '2020-01-06 21:42:40'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             54,
                             'request',
                             47,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             55,
                             'request',
                             48,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             56,
                             'request',
                             49,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             57,
                             'request',
                             50,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             58,
                             'request',
                             51,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             59,
                             'request',
                             52,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             60,
                             'request',
                             53,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             61,
                             'request',
                             54,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             62,
                             'request',
                             55,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             63,
                             'request',
                             56,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             64,
                             'request',
                             57,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             65,
                             'request',
                             58,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             66,
                             'request',
                             59,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             67,
                             'request',
                             60,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             68,
                             'request',
                             61,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             69,
                             'request',
                             62,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             70,
                             'request',
                             63,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             71,
                             'request',
                             64,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             72,
                             'request',
                             65,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             73,
                             'request',
                             66,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             74,
                             'request',
                             67,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             75,
                             'request',
                             68,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             76,
                             'request',
                             69,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             77,
                             'request',
                             70,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             78,
                             'request',
                             71,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             79,
                             'request',
                             72,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             80,
                             'request',
                             73,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             81,
                             'request',
                             74,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             82,
                             'request',
                             75,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             83,
                             'request',
                             76,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             84,
                             'request',
                             77,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             85,
                             'request',
                             78,
                             '2020-01-06 21:42:41'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             86,
                             'request',
                             79,
                             '2020-01-06 21:48:04'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             87,
                             'request',
                             80,
                             '2020-01-06 21:48:04'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             88,
                             'request',
                             81,
                             '2020-01-06 21:48:04'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             89,
                             'request',
                             82,
                             '2020-01-06 21:48:04'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             90,
                             'request',
                             83,
                             '2020-01-06 21:48:04'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             91,
                             'request',
                             84,
                             '2020-01-06 21:48:04'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             92,
                             'request',
                             85,
                             '2020-01-06 21:48:04'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             93,
                             'request',
                             86,
                             '2020-01-06 21:48:04'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             94,
                             'request',
                             87,
                             '2020-01-06 21:48:04'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             95,
                             'request',
                             88,
                             '2020-01-06 21:48:04'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             96,
                             'request',
                             89,
                             '2020-01-06 21:48:04'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             97,
                             'request',
                             90,
                             '2020-01-06 21:48:04'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             98,
                             'request',
                             91,
                             '2020-01-06 21:48:04'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             99,
                             'request',
                             92,
                             '2020-01-06 21:48:04'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             100,
                             'request',
                             93,
                             '2020-01-06 21:48:04'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             101,
                             'request',
                             94,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             102,
                             'request',
                             95,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             103,
                             'request',
                             96,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             104,
                             'request',
                             97,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             105,
                             'request',
                             98,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             106,
                             'request',
                             99,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             107,
                             'request',
                             100,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             108,
                             'request',
                             101,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             109,
                             'request',
                             102,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             110,
                             'request',
                             103,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             111,
                             'request',
                             104,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             112,
                             'request',
                             105,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             113,
                             'request',
                             106,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             114,
                             'request',
                             107,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             115,
                             'request',
                             108,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             116,
                             'request',
                             109,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             117,
                             'request',
                             110,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             118,
                             'request',
                             111,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             119,
                             'request',
                             112,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             120,
                             'request',
                             113,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             121,
                             'request',
                             114,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             122,
                             'request',
                             115,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             123,
                             'request',
                             116,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             124,
                             'request',
                             117,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             125,
                             'request',
                             118,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             126,
                             'request',
                             119,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             127,
                             'request',
                             120,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             128,
                             'request',
                             121,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             129,
                             'request',
                             122,
                             '2020-01-06 21:48:05'
                         );

INSERT INTO inserts_logs (
                             id,
                             type,
                             inserted_id,
                             time_added
                         )
                         VALUES (
                             130,
                             'request',
                             123,
                             '2020-01-06 21:48:05'
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

INSERT INTO jobs (
                     job_id,
                     user_created,
                     active,
                     time_created,
                     last_run,
                     job_name
                 )
                 VALUES (
                     9,
                     2,
                     1,
                     '2020-01-02 20:01:20',
                     NULL,
                     'Polish cities'
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
                         '2020-02-05'
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
                         '2020-02-03'
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
                         '2020-02-04'
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
                         '2020-02-02'
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
                         '2020-02-20'
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

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         29,
                         9,
                         2035,
                         2125,
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
                         30,
                         9,
                         2035,
                         8728,
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
                         31,
                         9,
                         2035,
                         1765,
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
                         32,
                         9,
                         2035,
                         2125,
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
                         33,
                         9,
                         2035,
                         8728,
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
                         34,
                         9,
                         2035,
                         1765,
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
                         35,
                         9,
                         2035,
                         2125,
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
                         36,
                         9,
                         2035,
                         8728,
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
                         37,
                         9,
                         2035,
                         1765,
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
                         38,
                         9,
                         2035,
                         2125,
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
                         39,
                         9,
                         2035,
                         8728,
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
                         40,
                         9,
                         2035,
                         1765,
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
                         41,
                         9,
                         2035,
                         2125,
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
                         42,
                         9,
                         2035,
                         8728,
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
                         43,
                         9,
                         2035,
                         1765,
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
                         44,
                         9,
                         2035,
                         2125,
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
                         45,
                         9,
                         2035,
                         8728,
                         '2020-02-02'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         46,
                         9,
                         2035,
                         1765,
                         '2020-02-03'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         47,
                         9,
                         2035,
                         2125,
                         '2020-02-04'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         48,
                         9,
                         2035,
                         2125,
                         '2020-02-05'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         49,
                         9,
                         2035,
                         8728,
                         '2020-02-06'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         50,
                         9,
                         2035,
                         1765,
                         '2020-02-07'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         51,
                         9,
                         2035,
                         2125,
                         '2020-02-08'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         52,
                         9,
                         2035,
                         8728,
                         '2020-02-09'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         53,
                         9,
                         2035,
                         1765,
                         '2020-02-10'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         54,
                         9,
                         2035,
                         2125,
                         '2020-02-11'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         55,
                         9,
                         2035,
                         8728,
                         '2020-02-12'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         56,
                         9,
                         2035,
                         1765,
                         '2020-02-13'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         57,
                         9,
                         2035,
                         2125,
                         '2020-02-14'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         58,
                         9,
                         2035,
                         8728,
                         '2020-02-15'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         59,
                         9,
                         2035,
                         1765,
                         '2020-02-16'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         60,
                         9,
                         2035,
                         2125,
                         '2020-02-17'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         61,
                         9,
                         2035,
                         8728,
                         '2020-02-18'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         62,
                         9,
                         2035,
                         1765,
                         '2020-02-19'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         63,
                         9,
                         2035,
                         2125,
                         '2020-02-20'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         64,
                         9,
                         2035,
                         8728,
                         '2020-02-21'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         65,
                         9,
                         2035,
                         1765,
                         '2020-02-22'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         66,
                         9,
                         2035,
                         2125,
                         '2020-02-23'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         67,
                         9,
                         2035,
                         2125,
                         '2020-02-24'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         68,
                         9,
                         2035,
                         8728,
                         '2020-02-25'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         69,
                         9,
                         2035,
                         1765,
                         '2020-02-26'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         70,
                         9,
                         2035,
                         2125,
                         '2020-02-27'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         71,
                         9,
                         2035,
                         8728,
                         '2020-02-28'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         72,
                         9,
                         2035,
                         1765,
                         '2020-02-29'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         73,
                         9,
                         2035,
                         2125,
                         '2020-03-01'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         74,
                         9,
                         2035,
                         8728,
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
                         75,
                         9,
                         2035,
                         1765,
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
                         76,
                         9,
                         2035,
                         2125,
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
                         77,
                         9,
                         2035,
                         8728,
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
                         78,
                         9,
                         2035,
                         1765,
                         '2020-03-06'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         79,
                         9,
                         2035,
                         2125,
                         '2020-03-07'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         80,
                         9,
                         2035,
                         8728,
                         '2020-03-08'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         81,
                         9,
                         2035,
                         1765,
                         '2020-03-09'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         82,
                         9,
                         2035,
                         2125,
                         '2020-03-10'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         83,
                         9,
                         2035,
                         8728,
                         '2020-03-11'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         84,
                         9,
                         2035,
                         1765,
                         '2020-03-12'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         85,
                         9,
                         2035,
                         2125,
                         '2020-03-13'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         86,
                         9,
                         2035,
                         2125,
                         '2020-03-14'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         87,
                         9,
                         2035,
                         8728,
                         '2020-03-15'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         88,
                         9,
                         2035,
                         1765,
                         '2020-03-16'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         89,
                         9,
                         2035,
                         2125,
                         '2020-03-17'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         90,
                         9,
                         2035,
                         8728,
                         '2020-03-18'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         91,
                         9,
                         2035,
                         1765,
                         '2020-03-19'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         92,
                         9,
                         2035,
                         2125,
                         '2020-03-20'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         93,
                         9,
                         2035,
                         8728,
                         '2020-03-21'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         94,
                         9,
                         2035,
                         1765,
                         '2020-03-22'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         95,
                         9,
                         2035,
                         2125,
                         '2020-03-23'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         96,
                         9,
                         2035,
                         8728,
                         '2020-03-24'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         97,
                         9,
                         2035,
                         1765,
                         '2020-03-25'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         98,
                         9,
                         2035,
                         2125,
                         '2020-03-26'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         99,
                         9,
                         2035,
                         8728,
                         '2020-03-27'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         100,
                         9,
                         2035,
                         1765,
                         '2020-03-28'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         101,
                         9,
                         2035,
                         2125,
                         '2020-03-29'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         102,
                         9,
                         2035,
                         8728,
                         '2020-03-30'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         103,
                         9,
                         2035,
                         1765,
                         '2020-03-31'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         104,
                         9,
                         2035,
                         2125,
                         '2020-04-01'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         105,
                         9,
                         2035,
                         2125,
                         '2020-04-02'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         106,
                         9,
                         2035,
                         8728,
                         '2020-04-03'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         107,
                         9,
                         2035,
                         1765,
                         '2020-04-04'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         108,
                         9,
                         2035,
                         2125,
                         '2020-04-05'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         109,
                         9,
                         2035,
                         8728,
                         '2020-04-06'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         110,
                         9,
                         2035,
                         1765,
                         '2020-04-07'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         111,
                         9,
                         2035,
                         2125,
                         '2020-04-08'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         112,
                         9,
                         2035,
                         8728,
                         '2020-04-09'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         113,
                         9,
                         2035,
                         1765,
                         '2020-04-10'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         114,
                         9,
                         2035,
                         2125,
                         '2020-04-11'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         115,
                         9,
                         2035,
                         8728,
                         '2020-04-12'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         116,
                         9,
                         2035,
                         1765,
                         '2020-04-13'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         117,
                         9,
                         2035,
                         2125,
                         '2020-04-14'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         118,
                         9,
                         2035,
                         8728,
                         '2020-04-15'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         119,
                         9,
                         2035,
                         1765,
                         '2020-04-16'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         120,
                         9,
                         2035,
                         2125,
                         '2020-04-17'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         121,
                         9,
                         2035,
                         8728,
                         '2020-04-18'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         122,
                         9,
                         2035,
                         1765,
                         '2020-04-19'
                     );

INSERT INTO requests (
                         request_id,
                         job_id,
                         start_city,
                         end_city,
                         date
                     )
                     VALUES (
                         123,
                         9,
                         2035,
                         2125,
                         '2020-04-20'
                     );


-- Table: results
CREATE TABLE results (
    result_id          INTEGER  PRIMARY KEY AUTOINCREMENT,
    request_id         INT      NOT NULL,
    time_created       DATETIME NOT NULL,
    departure_city     INT,
    arrival_city       INT,
    departure_station  INT,
    arrival_station    INT,
    departure_datetime DATETIME,
    arrival_datetime   DATETIME,
    price              DOUBLE,
    changes_number     INT,
    fully_booked       INT,-- PRIMARY KEY (
    /* result_id */FOREIGN KEY (
        request_id
    )
    REFERENCES requests (request_id),
    FOREIGN KEY (
        departure_city
    )
    REFERENCES cities (city_id),
    FOREIGN KEY (
        arrival_city
    )
    REFERENCES cities (city_id) 
);
-- ),

-- Table: stations
CREATE TABLE stations (
    station_id   INTEGER      PRIMARY KEY AUTOINCREMENT,
    station_name VARCHAR (50),
    UNIQUE (
        station_name
    )
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


-- Trigger: log_new_job
CREATE TRIGGER log_new_job
         AFTER INSERT
            ON jobs
BEGIN
    INSERT INTO inserts_logs (
                                 type,
                                 inserted_id,
                                 time_added
                             )
                             VALUES (
                                 "job",
                                 new.job_id,
                                 datetime('now') 
                             );
END;


-- Trigger: log_new_request
CREATE TRIGGER log_new_request
         AFTER INSERT
            ON requests
BEGIN
    INSERT INTO inserts_logs (
                                 type,
                                 inserted_id,
                                 time_added
                             )
                             VALUES (
                                 "request",
                                 new.request_id,
                                 datetime('now') 
                             );
END;


-- Trigger: set_job_last_run_time
CREATE TRIGGER set_job_last_run_time
        INSERT
            ON results
BEGIN
    UPDATE jobs
       SET last_run = datetime("now") 
     WHERE jobs.job_id = (
                             SELECT t1.job_id AS job_id
                               FROM jobs t1
                                    LEFT JOIN
                                    requests t2 ON t1.job_id = t2.job_id
                              WHERE t2.request_id = new.request_id
                         );
END;


-- View: active_requests
CREATE VIEW active_requests AS
    SELECT t2.request_id,
           strftime("%d.%m.%Y", t2.date) AS rideDate,
           t2.start_city AS departureCity,
           t2.end_city AS arrivalCity
      FROM jobs AS t1
           LEFT JOIN
           requests AS t2 ON t1.job_id = t2.job_id
     WHERE t1.active = 1;


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
