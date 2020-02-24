#lang dssl2

struct count:
    let num: int?

# determine if the num fields have the same number
def extensionally_equal?(c1: count?, c2: count?) -> bool?:
    True

# determine if the hat thingies are the same
# strategy: structural decomposition on both
# 1 case for count
# 1 case for count
# multiply: 1 x 1 = 1, therefore no cond!
def intentionally_equal?(c1: count?, c2: count?) -> bool?:
    let old_val = c1.num
    let n = max(c1.num, c2.num)+1
    c1.num = n
    let ret = c2.num == n
    c1.num = old_val
    ret

test 'intentional equality tests':
    assert_eq intentionally_equal?(count(0), count(1)), False
    assert_eq intentionally_equal?(count(0), count(0)), False
    assert_eq intentionally_equal?(count(2), count(2)), False
    let x = count(0)
    assert_eq intentionally_equal?(x, x), True
    assert_eq x.num, 0

# try typing in: count(0) is count(0)