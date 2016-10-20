; adicionar no início
(define (add-first l x)
    (if (list? l)
        (cons x l)
        `type-error
    )
)

; adicionar no fim
(define (add-last l x)
    (if (list? l)
        (if (null? l)
            (cons x `())
            (cons (car l) (add-last (cdr l) x))
        )
        `type-error
    )
)

; adicionar em um indice especifico
(define (add l i x)
    (if (list? l)
        (if (= i 0)
            (cons x l)
            (cons (car l) (add (cdr l) (- i 1) x))
        )
        `type-error
    )
)

; adicionar em ordem
(define (add-sorted l x)
    (if (list? l)
        (if (null? l)
            (cons x `())
            (if (<= x (car l))
                (cons x l)
                (cons (car l) (add-sorted (cdr l) x))
            )
        )
        `type-error
    )
)

; remover do inicio
(define (remove-first l)
    (if (list? l)
        (if (null? l)
            `()
            (cdr l)
        )
        `type-error
    )
)

; remover do fim
(define (remove-last l)
    (if (list? l)
        (if (<= (length l) 1)
            `()
            (cons (car l) (remove-last (cdr l)))
        )
        `type-error
    )
)

; remover de um indice
(define (remove l i)
    (if (and (list? l) (number? i))
        (if (null? l)
            `()
            (if (= i 0)
                (cdr l)
                (cons (car l) (remove (cdr l) (- i 1)))
            )
        )
        `type-error
    )
)

; remover a primeira ocorrencia de x
(define (remove-first l x)
    (if (list? l)
        (if (null? l)
            `()
            (if (= x (car l))
                (cdr l)
                (cons (car l) (remove-first (cdr l) x))
            )
        )
        `type-error
    )
)

; remover a ultima ocorrencia de x
;(define (remove-last element listA)
;    (letrec
;        (
;            (remove-last-aux 
;                (lambda (e l)
;                    ()
;                )
;            )
;        )
;    )
;)

; remover todas as ocorrencias de x

; verificar se a lista possui x
(define (contains l x)
    (if (list? l)
        (if (null? l)
            #f
            (if (= x (car l))
                #t
                (contains (cdr l) x)
            )
        )
        `type-error
    )
)

; acessar o elemento de indice i
(define (at l i)
    (if (list? l)
        (if (null? l)
            `does-not-exist
            (if (= i 0)
                (car l)
                (at (cdr l) (- i 1))
            )
        )
        `type-error
    )
)

; primeira ocorrencia de determinado elemento
(define (index-of l x)
    (if (list? l)
        (if (null? l)
            #f
            (if (equal? (car l) x)
                0
                (+ 1 (index-of (cdr l) x))
            )
        )
        `type-error
    )
)

; map
(define (map l func)
    (if (and (list? l) (procedure? func))
        (if (null? l)
            `()
            (cons (func (car l)) (map (cdr l) func))
        )
        `type-error
    )
)

; filter
(define (filter l func)
    (if (and (list? l) (procedure? func))
        (if (null? l)
            `()
            (if (func (car l))
                (cons (car l) (filter (cdr l) func))
                (filter (cdr l) func)
            )
        )
        `type-error
    )
)

; soma de duas listas
(define (sum l1 l2)
    (if (and (list? l1) (list? l2))
        (if (equal? (length l1) (length l2))
            (if (null? l1) ; both are null, because they have the same size
                `()
                (cons (+ (car l1) (car l2)) (sum (cdr l1) (cdr l2)))
            )
            `different-size-error
        )
        `type-error
    )
)

; produto vetorial
(define (prod-vec l1 l2)
    (letrec 
        (
            (prod-vec-aux
                (lambda (lista1 lista2)
                    (if (null? lista1) ; entao lista2 tbm eh vazio
                        0
                        (+ (* (car lista1) (car lista2)) (prod-vec-aux (cdr lista1) (cdr lista2)))
                    )
                )
            )
        )

        (if (and (list? l1) (list? l2))
            (if (equal? (length l1) (length l2))
                (prod-vec-aux l1 l2)
                `different-size-error
            )
            `type-error
        )
    )
)

; inverter a lista
(define (reverse ls)
    (letrec
        (
            (reverse-aux
                (lambda (li, lo)
                    (if (null? li)
                        lo
                        (reverse-aux (cdr li) (cons (car li) lo))
                    )
                )
            )
        )
        (if (list? ls)
            (reverse-aux ls `())
            `type-error
        )
    )
)

; concatenar
(define (concat ls1 ls2)
    (letrec
        (
            (concat-aux
                (lambda (l1 l2)
                    (if (null? l1)
                        l2
                        (cons (car l1) (concat-aux (cdr l1) l2))
                    )
                )
            )
        )
        (if (and (list? ls1) (list? ls2))
            (concat-aux ls1 ls2)
            `type-error
        )
    )
)

;;; intercalar
(define (intercalate ls1 ls2)
    (letrec
        (
            (intercalar-aux
                (lambda (l1 l2)
                    (if (null? l1)
                        l2
                        (cons (car l1) (cons (car l2) (intercalar-aux (cdr l1) (cdr l2))))
                    )
                )
            )
        )
        (if (and (list? ls1) (list? ls2))
            (intercalar-aux ls1 ls2)
            `type-error
        )
    )
)

(define (intercalate ls1 ls2)
    (letrec
        (
            (intercalar-aux
                (lambda (l1 l2 lo)
                    (if (null? l1)
                        (if (null? l2)
                            lo
                            (intercalar-aux l1 (cdr l2) (cons (car l2) lo))
                        )
                        (if (null? l2)
                            (intercalar-aux (cdr l1) l2 (cons (car l1) lo))
                            (intercalar-aux (cdr l1) (cdr l2) (cons (car l2) (cons (car l1) lo)))
                        )
                    )
                )
            )
        )
        (if (and (list? ls1) (list? ls2))
            (reverse (intercalar-aux ls1 ls2 `()))
            `type-error
        )
    )
)

;;; flatten
; `(1 2 (3 4 (5 6)) 7)
(define (flatten ls)
    (letrec
        (
            (flatten-aux
                (lambda (l)
                    (if (null? l)
                        `()
                        (let
                            (
                                (head (car l))
                                (tail (cdr l))
                            )
                            (if (list? head)
                                (append (flatten-aux head) (flatten-aux tail))
                                (cons head (flatten-aux tail))
                            )
                        )
                    )
                )
            )
        )
        (if (list? ls)
            (flatten-aux ls)
            `type-error
        )
    )
)

;;; reduce
(define (my-reduce ls initial function)
    (letrec
        (
            (reduce-aux
                (lambda (l ini func)
                    (if (null? l)
                        ini
                        (func (car l) (reduce-aux (cdr l) ini func))
                    )
                )
            )
        )
        (if (list? ls)
            (reduce-aux ls initial function)
            `type-error
        )
    )
)

; caudal
(define (my-reduce ls initial function)
    (letrec
        (
            (reduce-aux
                (lambda (l ini func)
                    (if (null? l)
                        ini
                        (reduce-aux (cdr l) (func ini (car l)) func)
                    )
                )
            )
        )
        (if (list? ls)
            (reduce-aux ls initial function)
            `type-error
        )
    )
)

;;; calcule o tamanho da lista de entrada
(define (my-length ls)
    (letrec
        ((length-aux
            (lambda (l)
                (if (null? l)
                    0
                    (+ 1 (length-aux (cdr l)))
                )
            )
        ))
        (if (list? ls)
            (length-aux ls)
            `type-error
        )
    )
)

; caudal
(define (my-length ls)
    (letrec
        ((length-aux
            (lambda (l acc)
                (if (null? l)
                    acc
                    (length-aux (cdr l) (+ acc 1))
                )
            )
        ))
        (if (list? ls)
            (length-aux ls 0)
            `type-error
        )
    )
)
