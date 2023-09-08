from bignum.bigint import BigInt
from testing import assert_true

fn test_add_op():
    let n1 = BigInt("100")
    let n2 = BigInt("200")
    _ = assert_true(n1 + n2 == BigInt("300"), "Add failed")

    let n3 = BigInt("9") + BigInt("9")
    _ = assert_true(n3 == BigInt("18"), "Overflow add failed")

fn test_add_method():
    var n1 = BigInt("100")
    n1.add(BigInt("100"))
    _ = assert_true(n1 == BigInt("200"), "Add method failed")

fn run_tests():
    test_add_op()


fn main():
    print("Running tests")
    run_tests()