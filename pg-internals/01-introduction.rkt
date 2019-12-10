#lang slideshow

(require "../common/templates.rkt")

;;(introduce `("Introduction to " "Query Planning" "") "Hadi Moshayedi")

(define cb1 (codeblock
             `("SELECT"
               "  a, b"
               "FROM t != x;")))
(define cb2 (codeblock `("abc")))


(slide
 #:title "Sample code"
 (para 
 (cols cb1 cb2)))

(slide
 #:title "How to Say Hello"
 (item "If you want to create an example, you"
       "can always do something with" (bt "Hello World!"))
 (item "It's a bit silly, but a follow-up example"
       "could be" (bt "Goodbye Dlrow!")))

