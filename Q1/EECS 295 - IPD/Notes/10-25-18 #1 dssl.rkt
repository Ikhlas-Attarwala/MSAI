#lang dssl2


# this is a comment
#
# Old data definition
#
# A binary-search-tree is
#   #false
#   (make-node number? binary-search-tree binary-search-tree)
# INVARIANT:
#   the number is greater than all of the numbers in the left subtree
#   the number is less than all of the numbers in the right subtree
#
#
#     4
#    / \
#   2   100
#  / \
# 1   50
#
#
# (define-struct node (num left right))

let binary_search_tree = OrC(False,node?) # "a binary search tree is" = let

struct node:
    let num: num?
    let left: binary_search_tree
    let right: binary_search_tree

# INVARIANT:
#   the number is greater than all of the numbers in the left subtree
#   the number is less than all of the numbers in the right subtree

let t1: binary_search_tree = node(1, node (0, False, False),
                                     node (2, False, False))

# To find if the number `n` is in `bst` or not
# Strategy: structural decomposition
# Template
#def lookup(bst: binary_search_tree, n: num?) -> bool?: # without using -> it is the same as saying ... -> AnyC:
#    if bst == False:
#        ...
#    else :         #node definition = 3 things
#        bst.num
#        lookup(bst.left, n)   #two references
#        lookup(bst.right, n)

def lookup(bst: binary_search_tree, n: num?) -> bool?: # without using -> it is the same as saying ... -> AnyC:
    if bst == False:
        False
    else :         #node definition = 3 things
        if n == bst.num:
            True
        elif n < bst.num:
            lookup(bst.left, n)   #two references
        else:
            lookup(bst.right, n)


# examples as tests
test 'lookup tests':
    assert_eq lookup(False,0), False
    assert_eq lookup(t1,-1), False #assert_eq = test case, and be sure two things we're writing are equal
    assert_eq lookup(t1,0), True
    assert_eq lookup(t1,2), True


# try typing: lookup('a', False)
