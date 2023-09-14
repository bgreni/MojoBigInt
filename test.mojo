from bignum.bigint import BigInt
from testing import assert_true, assert_false
from bignum.tests import *


fn run_tests():
    ArithmeticTests.run()
    CompareTests.run()

fn main():
    print("Running tests\n")
    run_tests()