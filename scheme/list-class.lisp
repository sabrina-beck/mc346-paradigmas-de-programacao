(define (remove-first l) (cdr l))

(define (remove-last l)
    (if (or (null? l) (equal? (length l) 1))
        `()
        (cons (car l) (remove-last (cdr l)))
    )
)

(define (my-reverse l) 
    (if (list? l)
        (if (null? l)
            `()
            (add-last (reverse (cdr l)) (car l))
        )
        `error
    )
)

(define (rev-aux i o)
    (if (and (list? i) (list? o))
        (if (null? i)
            o
            (rev-aux (cdr i) (cons (car i) o))
        )
        `error
    )
)

(define (rev l) (rev-aux l `())) 

(define (add-last l x) 
    (if (list? l)
        (if (null? l)
            (cons x `())
            (cons (car l) (add-last (cdr l) x))
        )
        `error
    )
)

(define (append2 l1 l2)
    (if (and (list? l1) (list? l2))
        (if (null? l2)
            l1
            (append2
                (add-last l1 (car l2))
                (cdr l2)
            )
        )
        `error
    )
)


descobrir o q é letrec

