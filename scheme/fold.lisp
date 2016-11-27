;;;;;;;;;;;;;;; fold ;;;;;;;;;;;;;;;
(define (fold ls initial func)
    (letrec
        (
            (fold-rec
                (lambda (l ini fun)
                    (if (null? l)
                        ini
                        (fold-rec (cdr l) (fun ini (car l)) fun)
                    )
                )
            )
        )
        (if (and (list? ls) (procedure? func))
            (fold-rec ls initial func)
            `type-error
        )
    )
)

;;;;;;;;;;;;;;; largest element ;;;;;;;;;;;;;;;
; (largest `(1 2 4 20 5 1))
(define maior
    (lambda (acc x)
        (if (> x acc)
            x
            acc
        )
    )
)

(define (largest ls)
    (fold 
        maior 0 ls
    )
)


;;;;;;;;;;;;;;; largest element and its index ;;;;;;;;;;;;;;;
; (largest-index `(1 4 2 20 5 1))
; (largest-index `(1 4 5 20 5 1))
(define (largest-index ls)
    (cdr
        (fold ls `(0 -1 0)
            (lambda (acc x)
                (let
                    (
                        (curr (car acc))
                        (index (cadr acc))
                        (largest (caddr acc))
                    )
                    (if (> x largest)
                        (list (+ curr 1) curr x)
                        (list (+ curr 1) index largest)
                    )
                )
            )
        )
    )
)

;;;;;;;;;;;;;;; replace ;;;;;;;;;;;;;;;
; (replace `(1 2 3 4) 2 5)
(define (replace ls index value)
    (reverse
        (cadr
            (fold ls (list index `())
                (lambda (acc x)
                    (let
                        (
                            (i (car acc))
                            (l (cadr acc))
                        )
                        (if (= i 0)
                            (list (- i 1) (cons value l))
                            (list (- i 1) (cons x l))
                        )
                    )
                )
            )
        )
    )
)

;;;;;;;;;;;;;;; map ;;;;;;;;;;;;;;;
; (mapfold `(1 2 3 4) (lambda (x) (* x x)))
(define (mapfold ls func)
    (reverse
        (fold ls `()
            (lambda (acc x)
                (cons (func x) acc)
            )
        )
    )
)

;;;;;;;;;;;;;;; filter ;;;;;;;;;;;;;;;
; (filter `(1 2 3 4 5) (lambda (x) (> x 3)))
(define (filter ls func)
    (reverse
        (fold ls `()
            (lambda (acc x)
                (if (func x)
                    (cons x acc)
                    acc
                )
            )
        )
    )
)

;implement list reverse using fold
; (rev `(1 2 3 4 5))
(define (rev ls)
    (fold ls `()
        (lambda (acc x)
            (cons x acc)
        )
    )
)