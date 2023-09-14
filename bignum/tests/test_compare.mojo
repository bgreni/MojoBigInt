from testing import assert_true, assert_false
from bignum.bigint import BigInt

struct CompareTests:
    @staticmethod
    fn run():
        CompareTests.lt()
        CompareTests.gt()
        CompareTests.le()
        CompareTests.ge()
        CompareTests.ne()

    @staticmethod
    fn lt():
        _ = assert_true(BigInt(100) < BigInt(200), "lt test1 failed")
        _ = assert_false(BigInt(120) < BigInt(100), "lt test2 failed")
        _ = assert_false(BigInt(100) < BigInt(100), "lt test3 failed")
        _ = assert_false(BigInt(10000) < BigInt(10), "lt test4 failed")
        _ = assert_true(BigInt(100) < BigInt(100980), "lt test5 failed")
        _ = assert_true(BigInt(-2) < BigInt(5), "lt test6 failed")

    @staticmethod
    fn gt():
        _ = assert_true(BigInt(200) > BigInt(100), "gt test1 failed")
        _ = assert_false(BigInt(100) > BigInt(200), "gt test2 failed")
        _ = assert_false(BigInt(100) > BigInt(100), "gt test3 failed")
        _ = assert_false(BigInt(10) > BigInt(1000), "gt test4 failed")
        _ = assert_true(BigInt(100980) > BigInt(100), "gt test5 failed")

    @staticmethod
    fn le():
        _ = assert_true(BigInt(100) <= BigInt(200), "le test1 failed")
        _ = assert_false(BigInt(200) <= BigInt(100), "le test2 failed")
        _ = assert_true(BigInt(100) <= BigInt(100), "le test3 failed")
        _ = assert_false(BigInt(10000) <= BigInt(10), "le test4 failed")
        _ = assert_true(BigInt(100) <= BigInt(100980), "le test5 failed")

    @staticmethod
    fn ge():
        _ = assert_true(BigInt(200) >= BigInt(100), "ge test1 failed")
        _ = assert_false(BigInt(100) >= BigInt(200), "ge test2 failed")
        _ = assert_true(BigInt(100) >= BigInt(100), "ge test3 failed")
        _ = assert_false(BigInt(10) >= BigInt(1000), "ge test4 failed")
        _ = assert_true(BigInt(100980) >= BigInt(100), "ge test5 failed")

    @staticmethod
    fn ne():
        _ = assert_true(BigInt(200) != BigInt(40), "ne test1 failed")
        _ = assert_false(BigInt(200) != BigInt(200), "ne test1 failed")