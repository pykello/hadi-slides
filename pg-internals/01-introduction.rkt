#lang slideshow

(require "../common/templates.rkt")

;;(introduce `("Introduction to " "Query Planning" "") "Hadi Moshayedi")

(slide
 #:title "Motivation"
 (codeblock
  "postgres=# CREATE TABLE users(id int, firstname text, lastname text);"
  "postgres=# INSERT INTO users VALUES (1, 'SomeName', 'SomeLastName'),"
  "                                    (2, 'Person2', 'AbCdEfGh');"
  "postgres=# CREATE INDEX ON users USING BTREE(id);"
  "postgres=# SELECT count(*) FROM users;"
  " count "
  "-------"
  "     1"
  "(1 row)")
 (item "How is data stored?")
 (item "How are queries executed?")
 (item "How is concurrency handled?")
 (item "How does it recover from crashes?")
 (item "..."))

(slide
 #:title "How to Say Hello"
 (item "If you want to create an example, you"
       "can always do something with" (bt "Hello World!"))
 (item "It's a bit silly, but a follow-up example"
       "could be" (bt "Goodbye Dlrow!")))

