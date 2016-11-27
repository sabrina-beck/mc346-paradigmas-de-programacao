; curry for two-argument functions
(define (curry2 f)
    (lambda (x)
        (lambda (y)
            (f x y)
        )
    )
)

; sum
(define add
    (curry2 +)
)

((add 1) 2)
((add 0) 2)

; sum 2
(define add2
    (add 2)
)

(add2 5)
(add2 4)

; double
(define double
    ((curry2 *) 2)
)

(double 2)
(double 4)

; curry for 3-argument function
(define (curry3 f)
    (lambda (x)
        (lambda (y)
            (lambda (z)
                (f x y z)
            )
        )
    )
)

; vararg
(define (addnumto n . args)
    (apply + (cons n args))
)

; generic curry
(define (curry f . args)
    (lambda (x)
        (apply f (append args x))
    )
)

(define double
    (curry * 2)
)

(double 5)

; transpose of matrix
(define (transpose mat)
  (apply (curry map list) mat))

(transpose `((1 2 3 4) (2 4 6 8) (3 6 9 12)) )