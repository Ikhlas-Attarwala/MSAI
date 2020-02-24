;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |10-18-18 #1|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|

Priority Queues
~~~~~~~~~~~~~~~

ADT (?)

================
SEQUENCES:

- empty-heap : PQ
- (is-empty?  h) : ---- determines if anythign's in there
- (insert     h k) : -- adds something to a PQ (note that we'll always use a number for k)

- (find-min   h) ------ returns the smallest element in the PQ
- (remove-min h) ------ removes the smallest element in the PQ,
                        giving you a new PQ

================
LAWS:
{} -- empty PQ
{1 2 3 4} -- PQ with 1-4 in it
{1 3 2} ---- WRONG
Write example PQs as sorted sequences of numbers in curley braces

empty-heap = {}

(is-empty? {}) = #true
(is-empty? {x1 x2 ...}) = #false

(insert {x1 ... x2 ...} x3) = {x1 ... x3 x2 ...}
    where all the x1's are less than x3 and the x2' are greater

(find-min {x1 x2 x3 ...}) = x1

(remove-min {x1 x2 x3 ...}) = {x2 x3 ...}

================

;; a PQ is either:
;; - empty or '()
;; - (cons Number PQ)

is the same as saying: ^^
;; a PQ is:
;; - [List-of Number]
;; INVARIANT: the list is sorted

TIME-COMPLEXITIES:                   TIME-COMPLEXITIES IF NO INVARIANT comment ^^:
is-empty?  : O(1)                    : O(1)
insert     : O(n) = O(|h|)           : O(1)
find-min   : O(1)                    : O(n)
remove-min : O(1)                    : O(n)

================
;; a PQ is:
;; - BinomialHeap

TIME-COMPLEXITIES:
is-empty?  : O(1)
insert     : O(log(n))
find-min   : O(log(n))
remove-min : O(log(n))

================
================
Binomial Trres:
 - Have a rank
 - Rank 0: (1 node)
     *
 - Rank 1:
       *
       |
       |
       *
 - Rank 2:
       *
       |
      --
     | |
     | |
     * *
     |
     |
     *
 - Rank 3:
       *
       |
    ----
   | | |
   | | |
   * * *
   | |
  -- |
 | | |
 | | |
 * * *
 |
 |
 *


|#