;; The singleton empty list.
(def nil ())

;; Tests if a value is the empty list.
(def nil? ())

;; Prepends an element to a list.
(def cons pair)

;; The first element in a list.
(def car left)

;; The rest of the elements in a list.
(def cdr right)

;; The rest of the rest of the list.
(def cddr (compose cdr cdr))

;; The second element in a list.
(def cadr (compose car cdr))

;; The third element in a list.
(def caddr (compose car cddr))

;; The fourth element in a list.
(def cadddr (compose car (compose cdr cddr)))

;; Appends [elem] to [list].
(def append
  (lambda list
    (lambda elem
      (if (nil? list)
        (cons elem list)
        (cons (car list) (append (cdr list) elem))))))

;; Concatenates [list1] and [list2].
(def concat
  (lambda list1
    (lambda list2
      (if (nil? list1)
        list2
        (cons (car list1) (concat (cdr list1) list2))))))

;; Maps [list] with a function [f].
(def map
  (lambda list
    (lambda f
      (if (nil? list)
        nil
        (cons (f (car list)) (map (cdr list) f))))))

;; Flat maps [list] with a function [f].
(def flat-map
  (lambda list
    (lambda f
      (if (nil? list)
        nil
        (append (f (car list)) (flat-map (cdr list) f))))))

;; Folds [list] with an accumulator [acc] function [f].
(def fold
  (lambda list
    (lambda acc
      (lambda f
        (if (nil? list)
          acc
          (fold (cdr list) (f acc (car list)) f))))))

;; Implementation of reverse.
(def reverse'
  (lambda list
    (lambda acc
      (if (nil? list)
        acc
        (reverse'
          (cdr list)
          (cons (car list) acc))))))

;; Reverses [list].
(def reverse
  (lambda list
    (reverse' list ())))

;; Tests if [list1] and [list2] are equal given a function [f].
(def list.=
  (lambda f
    (lambda list1
      (lambda list2
        (if (nil? list1)
          (nil? list2)
          (if (nil? list2)
            false
            (and (f (car list1) (car list2))
                 (lambda "" (list.= f (cdr list1) (cdr list2))))))))))