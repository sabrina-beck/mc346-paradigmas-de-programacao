;;;;;;;;;;;;;;; add in the beginning ;;;;;;;;;;;;;;;
(define (add-first ls element)
    (if (list? ls)
        (cons element ls)
        `type-error
    )
)

;;;;;;;;;;;;;;; add at the end ;;;;;;;;;;;;;;;
(define (snoc element ls)
    (letrec
        (
            (snoc-rec
                (lambda (e l)
                    (if (null? l)
                        (cons e `())
                        (cons (car l) (snoc-rec e (cdr l)))
                    )
                )
            )
        )
        (if (list? ls)
            (snoc-rec element ls)
            `type-error
        )
    )
)

;caudal
(define (add-last ls element)
    (letrec
        (
            (add-rev-rec
                (lambda (l e lo)
                    (if (null? l)
                        (cons e lo)
                        (add-rev-rec (cdr l) e (cons (car l) lo))
                    )
                )
            )
        )
        (if (list? ls)
            (reverse (add-rev-rec ls element `()))
            `type-error
        )
    )
)

;;;;;;;;;;;;;;; add in an index ;;;;;;;;;;;;;;;
(define (add-position ls index element)
    (letrec
        (
            (add-rec
                (lambda (l i e)
                    (if (= i 0)
                        (cons e l)
                        (if (null? l)
                            `index-out-of-bounds
                            (cons (car l) (add-rec (cdr l) (- i 1) e))
                        )
                    )
                )
            )
        )
        (if (and (list? ls) (integer? index))
            (add-rec ls index element)
            `type-error
        )
    )
)

;;;;;;;;;;;;;;; add in order ;;;;;;;;;;;;;;;
(define (add-sorted ls element)
    (letrec
        (
            (add-rec
                (lambda (l e)
                    (if (null? l)
                        (cons e `())
                        (if (< (car l) e)
                            (cons (car l) (add-rec (cdr l) e))
                            (cons e l)
                        )
                    )
                )
            )
        )
        (if (list? ls)
            (add-rec ls element)
            `type-error
        )
    )
)

;;;;;;;;;;;;;;; remove first element ;;;;;;;;;;;;;;;
(define (remove-first l)
    (if (list? l)
        (if (null? l)
            `()
            (cdr l)
        )
        `type-error
    )
)

;;;;;;;;;;;;;;; remove last element ;;;;;;;;;;;;;;;
(define (remove-last ls)
    (letrec
        (
            (remove-rec
                (lambda (l)
                    (if (or (null? l) (= (length l) 1))
                        `()
                        (cons (car l) (remove-rec (cdr l)))
                    )
                )
            )
        )
        (if (list? ls)
            (remove-rec ls)
            `type-error
        )
    )
)

;;;;;;;;;;;;;;; remove element from index ;;;;;;;;;;;;;;;
(define (remove-position ls index)
    (letrec
        (
            (remove-rec
                (lambda (l i)
                    (if (null? l)
                        `()
                        (if (= i 0)
                            (cdr l)
                            (cons (car l) (remove-rec (cdr l) (- i 1)))
                        )
                    )
                )
            )
        )
        (if (and (list? ls) (integer? index))
            (remove-rec ls index)
            `type-error
        )
    )
)

;;;;;;;;;;;;;;; remove first ocurrence of element ;;;;;;;;;;;;;;;
(define (remove-first ls element)
    (letrec
        (
            (remove-rec
                (lambda (l e)
                    (if (null? l)
                        `()
                        (if (= (car l) e)
                            (cdr l)
                            (cons (car l) (remove-rec (cdr l) e))
                        )
                    )
                )
            )
        )
        (if (list? ls)
            (remove-rec ls element)
            `type-error
        )
    )
)

;;;;;;;;;;;;;;; remove last ocurrence of element ;;;;;;;;;;;;;;;
; think about a better solution
(define (remove-last ls element)
    (if (list? ls)
        (reverse (remove-first (reverse ls) element))
        `type-error
    )
)

;;;;;;;;;;;;;;; remove all ocurrences of element ;;;;;;;;;;;;;;;
(define (removeall ls element)
    (letrec
        (
            (removeall-rec
                (lambda (l e)
                    (if (null? l)
                        `()
                        (if (= (car l) e)
                            (removeall-rec (cdr l) e)
                            (cons (car l) (removeall-rec (cdr l) e))
                        )
                    )
                )
            )
        )
        (if (list? ls)
            (removeall-rec ls element)
            `type-error
        )
    )
)

; caudal
(define (removeall ls element)
    (letrec
        (
            (removeall-rev-rec
                (lambda (l e lo)
                    (if (null? l)
                        lo
                        (if (= e (car l))
                            (removeall-rev-rec (cdr l) e lo)
                            (removeall-rev-rec (cdr l) e (cons (car l) lo))
                        )
                    )
                )
            )
        )
        (if (list? ls)
            (reverse (removeall-rev-rec ls element `()))
            `type-error
        )
    )
)

;;;;;;;;;;;;;;; check if list contains element ;;;;;;;;;;;;;;;
(define (contains ls element)
    (letrec
        (
            (contains-rec
                (lambda (l e)
                    (if (null? l)
                        #f
                        (if (= e (car l))
                            #t
                            (contains-rec (cdr l) e)
                        )
                    )
                )
            )
        )
        (if (list? ls)
            (contains-rec ls element)
            `type-error
        )
    )
)

;;;;;;;;;;;;;;; get element by index ;;;;;;;;;;;;;;;
(define (at ls index)
    (letrec
        (
            (at-rec
                (lambda (l i)
                    (if (null? l)
                        #f
                        (if (= i 0)
                            (car l)
                            (at-rec (cdr l) (- i 1))
                        )
                    )
                )
            )
        )
        (if (and (list? ls) (integer? index))
            (at-rec ls index)
            `type-error
        )
    )
)

;;;;;;;;;;;;;;; first ocurrence of element ;;;;;;;;;;;;;;;
(define (index-of ls element)
    (letrec
        (
            (index-of-rec
                (lambda (l e)
                    (if (null? l)
                        -1
                        (if (= e (car l))
                            0
                            (+ 1 (index-of-rec (cdr l) e))
                        )
                    )
                )
            )
        )
        (if (list? ls)
            (index-of-rec ls element)
            `type-error
        )
    )
)

;;;;;;;;;;;;;;; sum lists ;;;;;;;;;;;;;;;
(define (sum ls1 ls2)
    (letrec
        (
            (sum-rec
                (lambda (l1 l2)
                    (if (null? l1)
                        l2
                        (cons (+ (car l1) (car l2)) (sum-rec (cdr l1) (cdr l2)))
                    )
                )
            )
        )
        (if (and (list? ls1) (list? ls2))
            (if (= (length ls1) (length ls2))
                (sum-rec ls1 ls2)
                `error
            )
            `type-error
        )
    )
)

;;;;;;;;;;;;;;; internal product ;;;;;;;;;;;;;;;
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

;caudal
(define (cross-product ls1 ls2)
    (letrec
        (
            (cross-product-rec
                (lambda (l1 l2 acc)
                    (if (null? l1)
                        acc
                        (cross-product-rec (cdr l1) (cdr l2)
                            (+ (* (car l1) (car l2)) acc)
                        )
                    )
                )
            )
        )
        (if (and (list? ls1) (list? ls2))
            (if (= (length ls1) (length ls2))
                (cross-product-rec ls1 ls2 0)
                `different-size-error
            )
            `type-error
        )
    )
)

;;;;;;;;;;;;;;; reverse ;;;;;;;;;;;;;;;
(define (rev ls)
    (letrec
        (
            (rev-rec
                (lambda (l)
                    (if (null? l)
                        `()
                        (snoc (car l) (rev-rec (cdr l)))
                    )
                )
            )
        )
        (if (list? ls)
            (rev-rec ls)
            `type-error
        )
    )
)

;caudal
(define (rev ls)
    (letrec
        (
            (rev-rec
                (lambda (l lo)
                    (if (null? l)
                        lo
                        (rev-rec (cdr l) (cons (car l) lo))
                    )
                )
            )
        )
        (if (list? ls)
            (rev-rec ls `())
            `type-error
        )
    )
)

;;;;;;;;;;;;;;; length ;;;;;;;;;;;;;;;
(define (size ls)
    (letrec
        (
            (size-rec
                (lambda (l)
                    (if (null? l)
                        0
                        (+ 1 (size-rec (cdr l)))
                    )
                )
            )
        )
        (if (list? ls)
            (size-rec ls)
            `type-error
        )
    )
)

;caudal
(define (size ls)
    (letrec
        (
            (size-rec
                (lambda (l acc)
                    (if (null? l)
                        acc
                        (size-rec (cdr l) (+ 1 acc))
                    )
                )
            )
        )
        (if (list? ls)
            (size-rec ls 0)
            `type-error
        )
    )
)

;;;;;;;;;;;;;;; concat ;;;;;;;;;;;;;;;
(define (concat ls1 ls2)
    (letrec
        (
            (concat-rec
                (lambda (l1 l2)
                    (if (null? l1)
                        l2
                        (cons (car l1) (concat-rec (cdr l1) l2))
                    )
                )
            )
        )
        (if (and (list? ls1) (list? ls2))
            (concat-rec ls1 ls2)
            `type-error
        )
    )
)

;caudal
(define (concat ls1 ls2)
    (letrec
        (
            (concat-rec
                (lambda (l1 l2 lo)
                    (if (and (null? l1) (null? l2))
                        lo
                        (if (null? l1)
                            (concat-rec `() (cdr l2) (cons (car l2) lo))
                            (concat-rec (cdr l1) l2 (cons (car l1) lo))
                        )
                    )
                )
            )
        )
        (if (and (list? ls1) (list? ls2))
            (reverse
                (concat-rec ls1 ls2 `())
            )
            `type-error
        )
    )
)

;;;;;;;;;;;;;;; intercalate ;;;;;;;;;;;;;;;
(define (intercalate ls1 ls2)
    (letrec
        (
            (intercalate-rec
                (lambda (l1 l2)
                    (if (null? l1)
                        l2
                        (if (null? l2)
                            l1
                            (cons (car l1)
                                (cons (car l2)
                                    (intercalate-rec (cdr l1) (cdr l2))
                                )
                            )
                        )
                    )
                )
            )
        )
        (if (and (list? ls1) (list? ls2))
            (intercalate-rec ls1 ls2)
            `type-error
        )
    )
)

;caudal
(define (intercalate ls1 ls2)
    (letrec
        (
            (intercalate-rec
                (lambda (l1 l2 lo)
                    (if (and (null? l1) (null? l2))
                        lo
                        (if (null? l1)
                            (intercalate-rec `() (cdr l2) (cons (car l2) lo))
                            (if (null? l2)
                                (intercalate-rec (cdr l1) `() (cons (car l1) lo))
                                (intercalate-rec (cdr l1) (cdr l2)
                                    (cons (car l2)
                                        (cons (car l1) lo)
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
        (if (and (list? ls1) (list? ls2))
            (reverse
                (intercalate-rec ls1 ls2 `())
            )
            `type-error
        )
    )
)

;;;;;;;;;;;;;;; flatten ;;;;;;;;;;;;;;;
; (flatten `(1 2 (3 4 (5 6)) 7))
(define (flatten ls)
    (letrec
        (
            (flatten-rec
                (lambda (l)
                    (if (null? l)
                        `()
                        (let
                            (
                                (head (car l))
                                (tail (cdr l))
                            )
                            (if (list? head)
                                (append (flatten-rec head) (flatten-rec tail))
                                (cons head (flatten-rec tail))
                            )
                        )
                    )
                )
            )
        )
        (if (list? ls)
            (flatten-rec ls)
            `type-error
        )
    )
)

;caudal
(define (flatten ls)
    (letrec
        (
            (flatten-rec
                (lambda (l lo)
                    (if (null? l)
                        lo
                        (let
                            (
                                (head (car l))
                                (tail (cdr l))
                            )
                            (if (list? head)
                                (flatten-rec tail (flatten-rec head lo))
                                (flatten-rec tail (cons (car l) lo))
                            )
                        )
                    )
                )
            )
        )
        (if (list? ls)
            (reverse (flatten-rec ls `()))
            `type-error
        )
    )
)

;non caudal with snoc
(define (flatten ls)
    (letrec
        (
            (flatten-rec
                (lambda (l lo)
                    (if (null? l)
                        lo
                        (if (list? (car l))
                            (flatten-rec (cdr l) (flatten-rec (car l) lo))
                            (flatten-rec (cdr l) (snoc (car l) lo))
                        )
                    )
                )
            )
        )
        (if (list? ls)
            (flatten-rec ls `())
            `type-error
        )
    )
)

;;;;;;;;;;;;;;; map ;;;;;;;;;;;;;;;
;(map `(1 2 3 4 5 6)
;    (lambda (element) (* element element))
;)
;`(1 2 3 4 5 6) ==> `(1 4 9 16 25 36)
(define (map ls func)
    (letrec
        (
            (map-rec
                (lambda (l fun)
                    (if (null? l)
                        `()
                        (cons (fun (car l)) (map-rec (cdr l) fun))
                    )
                )
            )
        )
        (if (and (list? ls) (procedure? func))
            (map-rec ls func)
            `type-error
        )
    )
)

;caudal
(define (map ls func)
    (letrec
        (
            (map-rec
                (lambda (l fun lo)
                    (if (null? l)
                        lo
                        (map-rec (cdr l) fun (cons (fun (car l)) lo))
                    )
                )
            )
        )
        (if (and (list? ls) (procedure? func))
            (reverse (map-rec ls func `()))
            `type-error
        )
    )
)

;;;;;;;;;;;;;;; filter ;;;;;;;;;;;;;;;
;(filter `(1 2 3 4 5 6)
;    (lambda (element) (> element 3))
;)
;`(1 2 3 4 5 6) ==> `(4 5 6)

(define (filter ls func)
    (letrec
        (
            (filter-rec
                (lambda (l fun)
                    (if (null? l)
                        `()
                        (if (func (car l))
                            (cons (car l) (filter-rec (cdr l) fun))
                            (filter-rec (cdr l) fun)
                        )
                    )
                )
            )
        )
        (if (and (list? ls) (procedure? func))
            (filter-rec ls func)
            `type-error
        )
    )
)

;caudal
(define (filter ls func)
    (letrec
        (
            (filter-rec
                (lambda (l fun lo)
                    (if (null? l)
                        lo
                        (if (func (car l))
                            (filter-rec (cdr l) fun (cons (car l) lo))
                            (filter-rec (cdr l) fun lo)
                        )
                    )
                )
            )
        )
        (if (and (list? ls) (procedure? func))
            (reverse (filter-rec ls func `()))
            `type-error
        )
    )
)

;;;;;;;;;;;;;;; fold ;;;;;;;;;;;;;;;
;(fold `(1 2 3 4 5) 0
;    (lambda (acc element) (+ acc element))
;)
;`(1 2 3 4 5) ==> 15

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

;;;;;;;;;;;;;;; encode ;;;;;;;;;;;;;;;
;(a a a a b c c c a) => ((4 a) (1 b) (3 c) (1 a))
;(encode `(a a a a b c c c a))
(define (encode ls)
    (letrec
        (
            (encode-rec
                (lambda (l last count)
                    (if (null? l)
                        (list (list count last))
                        (if (equal? (car l) last)
                            (encode-rec (cdr l) last (+ 1 count))
                            (append
                                (list (list count last))
                                (encode-rec (cdr l) (car l) 1)
                            )
                        )
                    )
                )
            )
        )
        (if (list? ls)
            (if (null? ls)
                `()
                (encode-rec (cdr ls) (car ls) 1)
            )
            `type-error
        )
    )
)

;fold
;(encode `(a a a a b c c c a))
(define (encode ls)
    (if (null? ls)
        `()
        (reverse
            (fold (cdr ls) (list (list (car ls) 1))
                (lambda (acc element)
                    (let*
                        (
                            (current (car acc))
                            (last (car current))
                            (count (cadr current))
                        )
                        (if (equal? last element)
                            (cons (list (+ 1 count) last) (cdr acc))
                            (cons (list 1 element) acc)
                        )
                    )
                )
            )
        )
    )
)