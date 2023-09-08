from bignum.bigint import BigInt
from testing import assert_true, assert_false

fn test_add_op():
    let n1 = BigInt(100)
    let n2 = BigInt(200)
    _ = assert_true(n1 + n2 == BigInt(300), "Add failed")

    let n3 = BigInt(9) + BigInt(9)
    _ = assert_true(n3 == BigInt(18), "Overflow add failed")

fn test_add_method():
    var n1 = BigInt(100)
    n1.add(BigInt(100))
    _ = assert_true(n1 == BigInt(200), "Add method failed")

fn test_lt():
    _ = assert_true(BigInt(100) < BigInt(200), "lt test1 failed")
    _ = assert_false(BigInt(120) < BigInt(100), "lt test2 failed")
    _ = assert_false(BigInt(100) < BigInt(100), "lt test3 failed")
    _ = assert_false(BigInt(10000) < BigInt(10), "lt test4 failed")
    _ = assert_true(BigInt(100) < BigInt(100980), "lt test5 failed")

fn test_gt():
    _ = assert_true(BigInt(200) > BigInt(100), "gt test1 failed")
    _ = assert_false(BigInt(100) > BigInt(200), "gt test2 failed")
    _ = assert_false(BigInt(100) > BigInt(100), "gt test3 failed")
    _ = assert_false(BigInt(10) > BigInt(1000), "gt test4 failed")
    _ = assert_true(BigInt(100980) > BigInt(100), "gt test5 failed")

fn test_le():
    _ = assert_true(BigInt(100) <= BigInt(200), "le test1 failed")
    _ = assert_false(BigInt(200) <= BigInt(100), "le test2 failed")
    _ = assert_true(BigInt(100) <= BigInt(100), "le test3 failed")
    _ = assert_false(BigInt(10000) <= BigInt(10), "le test4 failed")
    _ = assert_true(BigInt(100) <= BigInt(100980), "le test5 failed")

fn test_ge():
    _ = assert_true(BigInt(200) >= BigInt(100), "ge test1 failed")
    _ = assert_false(BigInt(100) >= BigInt(200), "ge test2 failed")
    _ = assert_true(BigInt(100) >= BigInt(100), "ge test3 failed")
    _ = assert_false(BigInt(10) >= BigInt(1000), "ge test4 failed")
    _ = assert_true(BigInt(100980) >= BigInt(100), "ge test5 failed")

fn run_tests():
    test_add_op()
    test_lt()
    test_gt()
    test_le()
    test_ge()

fn main():
    print("Running tests")
    run_tests()