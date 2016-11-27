;;;;;;;;;;; check if tree is empty ;;;;;;;;;;;
(define (bst-empty? bst) (null? bst))

;;;;;;;;;;; get root value ;;;;;;;;;;;
;(bst-root-value `(5 (4 () ()) (6 () ())))
(define (bst-root-value bst)
    (if (not (bst-empty? bst))
        (car bst)
        `()
    )
)

;;;;;;;;;;; get left subtree ;;;;;;;;;;;
;(bst-left-tree `(5 (4 () ()) (6 () ())))
(define (bst-left-tree bst)
    (if (not (bst-empty? bst))
        (cadr bst)
        `()
    )
)

;;;;;;;;;;; get right subtree ;;;;;;;;;;;
;(bst-right-tree `(5 (4 () ()) (6 () ())))
(define (bst-right-tree bst)
    (if (not (bst-empty? bst))
        (caddr bst)
        `()
    )
)

;;;;;;;;;;; check if tree root is a leaf ;;;;;;;;;;;
;(bst-leaf? `(1 () ()))
;(bst-leaf? `(1 (0 () ()) (2 () ())))
;(bst-leaf? `(1 (0 () ()) ()))
;(bst-leaf? `(1 () (2 () ())))
(define (bst-leaf? bst)
    (if (not (bst-empty? bst))
        (and (bst-empty? (bst-left-tree bst))
             (bst-empty? (bst-right-tree bst)))
        #f
    )
)

;;;;;;;;;;; empty bst constructor ;;;;;;;;;;;
;(bst-create-empty)
(define (bst-create-empty)
    `()
)

;;;;;;;;;;; bst constructor ;;;;;;;;;;;
;(bst-create 5 `() `())
(define (bst-create value left right)
    (list value left right)
)

;;;;;;;;;;; bst leaf constructor ;;;;;;;;;;;
;(bst-create-leaf 5)
(define (bst-create-leaf value)
    (bst-create value (bst-create-empty) (bst-create-empty))
)

;;;;;;;;;;; insert new node in bst ;;;;;;;;;;;
;(bst-insert `() 1)
;(bst-insert `(1 () ()) 2)
;(bst-insert `(1 () (2 () ())) 0)
;(bst-insert `(1 (0 () ()) (2 () ())) 3)
;
;(bst-insert 
; (bst-insert 
;  (bst-insert 
;   (bst-insert 
;    (bst-insert 
;     (bst-insert
;      (bst-insert 
;       (bst-create-empty) 5) 3) 4) 7) 6) 8) 8)

(define (bst-insert bst value)
    (if (bst-empty? bst)
        (bst-create-leaf value)
        (if (< value (bst-root-value bst))
            (bst-create (bst-root-value bst)
                        (bst-insert (bst-left-tree bst) value)
                        (bst-right-tree bst))
            (if (> value (bst-root-value bst))
                (bst-create (bst-root-value bst)
                            (bst-left-tree bst)
                            (bst-insert (bst-right-tree bst) value))
                bst
            )
        )
    )
)

;;;;;;;;;;; transverse in order ;;;;;;;;;;;
;(bst-transverse-inorder `(5 (3 () (4 () ())) (7 (6 () ()) (8 () ()))) )
;
;(bst-transverse-inorder
; (bst-insert 
; (bst-insert 
;  (bst-insert 
;   (bst-insert 
;    (bst-insert 
;     (bst-insert
;      (bst-insert 
;       (bst-create-empty) 5) 3) 4) 7) 6) 8) 8))

(define (bst-transverse-inorder bst)
    (if (bst-empty? bst)
        `()
        (append
            (bst-transverse-inorder (bst-left-tree bst))
            (list (bst-root-value bst))
            (bst-transverse-inorder (bst-right-tree bst))
        )
    )
)

;;;;;;;;;;; transverse pre order ;;;;;;;;;;;
;(bst-transverse-preorder `(5 (3 () (4 () ())) (7 (6 () ()) (8 () ()))) )
(define (bst-transverse-preorder bst)
    (if (bst-empty? bst)
        `()
        (append
            (list (bst-root-value bst))
            (bst-transverse-preorder (bst-left-tree bst))
            (bst-transverse-preorder (bst-right-tree bst))
        )
    )
)

;;;;;;;;;;; transverse pos order ;;;;;;;;;;;
;(bst-transverse-posorder `(5 (3 () (4 () ())) (7 (6 () ()) (8 () ()))) )
(define (bst-transverse-posorder bst)
    (if (bst-empty? bst)
        `()
        (append
            (bst-transverse-posorder (bst-left-tree bst))
            (bst-transverse-posorder (bst-right-tree bst))
            (list (bst-root-value bst))
        )
    )
)

;;;;;;;;;;; return max value of a bst ;;;;;;;;;;;
;(bst-max `(1 (2 () ()) (3 () ()) ) )
(define (bst-max bst)
    (if (bst-empty? bst)
        `()
        (if (bst-empty? (bst-right-tree bst))
            (bst-root-value bst)
            (bst-max (bst-right-tree bst))
        )
    )
)

;;;;;;;;;;; return max value of a binary tree ;;;;;;;;;;;
;(bt-max `(1 (2 () ()) (3 () ())))
(define (bt-max binarytree)
    (letrec
        (
            (bt-max-rec
                (lambda (bt)
                    (if (bst-empty? bt)
                        `()
                        (if (bst-leaf? bt)
                            (list (bst-root-value bt))
                            (list
                                (apply max 
                                    (append 
                                        (list (bst-root-value bt))
                                        (bt-max-rec (bst-left-tree bt))
                                        (bt-max-rec (bst-right-tree bt))
                                    )
                                )    
                            )
                        )
                    )
                )
            )
        )
        (let
            ((maximum (bt-max-rec binarytree)))
            (if (null? maximum)
                #f
                (car maximum)
            )
        )
    )
)

;;;;;;;;;;; remove an element ;;;;;;;;;;;
(define (remove root-tree element)
    (letrec
        (
            (remove-rec
                (lambda (root e)
                    (if (null? root)
                        `()
                        (let
                            (
                                (root-value (car root))
                                (left-child (cadr root))
                                (right-child (caddr root))
                            )
                            (if (= e root-value)
                                ;;;;;;;;;;;;;;;;
                            )
                        )
                    )
                )
            )
        )
    )
)

;;;;;;;;;;; check if BST is valid ;;;;;;;;;;;
;(bst-valid? `())
;(bst-valid? `(1 () ()))
;(bst-valid? `(1 (0 () ()) (2 () (1 () ()))))
;(bst-valid? `(1 (0 () ()) (2 () (3 () ()))))
;(bst-valid? `(1 (0 (5 () ()) ()) (2 () ())))
(define (bst-valid? bst)
    (if (bst-empty? bst)
        #t
        (if (and (bst-empty? (bst-left-tree bst))
                 (bst-empty? (bst-right-tree bst)))
            #t
            (if (bst-empty? (bst-left-tree bst))
                (if (> (bst-root-value (bst-right-tree bst))
                       (bst-root-value bst))
                    (bst-valid? (bst-right-tree bst))
                    #f
                )
                (if (bst-empty? (bst-right-tree bst))
                    (if (< (bst-root-value (bst-left-tree bst))
                           (bst-root-value bst))
                        (bst-valid? (bst-right-tree bst))
                        #f
                    )
                    (if (and (< (bst-root-value (bst-left-tree bst)) (bst-root-value bst))
                             (> (bst-root-value (bst-right-tree bst)) (bst-root-value bst)))
                        (and (bst-valid? (bst-left-tree bst)) (bst-valid? (bst-right-tree bst)))
                        #f
                    )
                )
            )
        )
    )
)

; other option
(define (isvalid tree)
    (letrec
        (
            (isvalid-rec
                (lambda (root)
                    (if (null? root)
                        #t
                        (let
                            (
                                (root-value (car root))
                                (left (cadr root))
                                (right (caddr root))
                            )
                            (if (and (null? left) (null? right))
                                #t
                                (if (null? left)
                                    (if (< root-value (car right))
                                        (isvalid-rec right)
                                        #f
                                    )
                                    (if (null? right)
                                        (if (> root-value (car left))
                                            (isvalid-rec left)
                                            #f
                                        )
                                        (if (and (> root-value (car left)) (< root-value (car right)))
                                            (and (isvalid-rec left) (isvalid-rec right))
                                            #f
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
        (if (list? tree)
            (isvalid-rec tree)
            `type-error
        )
    )
)

;;;;;;;;;;; tree depth ;;;;;;;;;;;
;(bst-depth `())
;(bst-depth `(1 () ()))
;(bst-depth `(1 (0 () ()) (2 () (3 () ()))))
(define (bst-depth bst)
    (if (bst-empty? bst)
        0
        (let
            (
                (left-depth (bst-depth (bst-left-tree bst)))
                (right-depth (bst-depth (bst-right-tree bst)))
            )
            (if (> left-depth right-depth)
                (+ 1 left-depth)
                (+ 1 right-depth)
            )
        )
    )
)

;;;;;;;;;;; check if the tree balanced ;;;;;;;;;;;
;(bst-balanced? `())
;(bst-balanced? `(1 () ()))
;(bst-balanced? `(1 (0 () ()) (2 () ())))
;(bst-balanced? `(1 (0 (-1 () ()) ()) ()))
(define (bst-balanced? bst)
    (if (bst-empty? bst)
        #t
        (let
            (
                (left-depth (bst-depth (bst-left-tree bst)))
                (right-depth (bst-depth (bst-right-tree bst)))
            )
            (if (> (abs (- left-depth right-depth)) 1)
                #f
                #t
            )
        )
    )
)