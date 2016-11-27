;;;;;;;;;;; Consider a matrix as a list of lists ;;;;;;;;;;;
;;;;;;;;;;; and an array as a list ;;;;;;;;;;;

;;;;;;;;;;; internal product of two arrays ;;;;;;;;;;;
(define (product ls1 ls2)
    (letrec
        (
            (product-rec
                (lambda (l1 l2)
                    (if (null? l1)
                        0
                        (+ (* (car l1) (car l2)) (product-rec (cdr l1) (cdr l2)))
                    )
                )
            )
        )
        (if (and (list? ls1) (list? ls2))
            (if (= (length ls1) (length ls2))
                (product-rec ls1 ls2)
                `different-size-error
            )
            `type-error
        )
    )
)

;;;;;;;;;;; vectorial product of two arrays ;;;;;;;;;;;

;;;;;;;;;;; cross matrix ;;;;;;;;;;;

;;;;;;;;;;; determinant of a matrix ;;;;;;;;;;;

;;;;;;;;;;; multiplication of matrix ;;;;;;;;;;;

;;;;;;;;;;; implement to any iterable object ;;;;;;;;;;;