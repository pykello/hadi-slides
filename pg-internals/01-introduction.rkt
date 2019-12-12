#lang slideshow

(require "../common/templates.rkt")

(introduce `("Postgres Internals" "1. Introduction" "") "Hadi Moshayedi")

(attention "Motivation: How does PostgreSQL work?")

(slide
 (t "How is data stored?")
 'alts
 (left-aligned
  (codeblock
   "postgres=# CREATE TABLE users(id int, firstname text, lastname text);")
  'next
  (codeblock
   "postgres=# INSERT INTO users VALUES (1, 'SomeName', 'SomeLastName'),"
   "                                    (2, 'Person2', 'AbCdEfGh');")
  'next
  (codeblock "postgres=# CREATE INDEX ON users USING BTREE(id);")))

(slide
 (t "How are queries processed?")
 'alts
 (list
  (list (codeblock "SELECT
	sum(l_extendedprice * l_discount) as revenue
FROM
	lineitem
WHERE
	l_shipdate >= date '1994-01-01'
	and l_shipdate < date '1994-01-01' + interval '1 year'
	and l_discount between 0.06 - 0.01 and 0.06 + 0.01
	and l_quantity < 24;"))
  (list (codeblock
  "select     s_i_id, sum(s_order_cnt) as ordercount
from       stock, supplier, nation
where      mod((s_w_id * s_i_id),10000) = s_suppkey
       and s_nationkey = n_nationkey
       and n_name = 'GERMANY'
group by s_i_id
having  sum(s_order_cnt) >  (select   sum(s_order_cnt) * .005
                             from     stock, supplier, nation
                             where    mod((s_w_id * s_i_id),10000) = s_suppkey
                                  and s_nationkey = n_nationkey
                                  and n_name = 'GERMANY')
order by ordercount desc;
"))))

