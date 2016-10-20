; calcular o valor absoluto
(define (absolute x)
    (if (number? x)
        (if (< x 0)
            (* x -1)
            x
        )
        `type-error
    )
)

; calcular o n-esimo numero de fibonacci
(define (fibonacci n)
    (if (and (number? n) (>= n 0))
        (if (equal? n 0)
            0
            (if (equal? n 1)
                1
                (+ (fibonacci (- n 1)) (fibonacci (- n 2)))
            )
        )
        `type-error
    )
)

; calcular o fatorial
(define (fat n)
    (if (and (number? n) (>= n 0))
        (if (equal? n 0)
            1
            (* n (fat (- n 1)))
        )
        `type-error
    )
)