from testing import assert_true, assert_false
from bignum.bigint import BigInt
from .test_case import NumericTestCase
from memory.unsafe import Pointer

alias Test = NumericTestCase

struct ArithmeticTests:
    @staticmethod
    fn run():
        ArithmeticTests.add_op()
        ArithmeticTests.sub_op()
        ArithmeticTests.other_op()
        ArithmeticTests.test_compound()

    @staticmethod
    fn test_compound():
        Test.do(
            BigInt(20) - BigInt(30) + BigInt(25) - -BigInt(20),
            BigInt(35),
            "compound1"
        )

    @staticmethod
    fn add_op():
        Test.do(
            BigInt(100) + BigInt(200),
            BigInt(300),
            "Simple add"
        )

        Test.do(
            BigInt(2000000) + BigInt(200),
            BigInt(2000200),
            "Simple add 2"
        )

        Test.do(
            BigInt(-3) + BigInt(4),
            BigInt(1),
            "single neg add"
        )

        Test.do(
            BigInt(6) + BigInt(-17),
            BigInt(-11),
            "single neg add2"
        )

        Test.do(
            BigInt(-3) + BigInt(-4),
            BigInt(-7),
            "double neg add"
        )

        Test.do(
            BigInt(9) + BigInt(9),
            BigInt(18),
            "Overflow add"
        )

        Test.do(
            BigInt("341345612345623462346234562346234") + BigInt("234513461346134613465234578535623456218245"),
            BigInt("234513461687480225810858040881858018564479"),
            "Big add small lhs"
        )

        Test.do(
            BigInt("234513461346134613465234578535623456218245") + BigInt("341345612345623462346234562346234"),
            BigInt("234513461687480225810858040881858018564479"),
            "Big add small rhs"
        )

        var n1 = BigInt(100)
        n1.add(BigInt(100))
        Test.do(n1, BigInt(200), "Simple add method")
        n1 += BigInt(100)
        Test.do(n1, BigInt(300), "Simple iadd method")

        var n2 = BigInt("234513461346134613465234578535623456218245")
        n2.add(BigInt("341345612345623462346234562346234"))
        Test.do(
            n2,
            BigInt("234513461687480225810858040881858018564479"),
            "big add method")

    @staticmethod
    fn sub_op():
        var n1 = BigInt(5)
        n1.sub(BigInt(3))
        Test.do(
            n1,
            BigInt(2),
            "simple sub"
        )

        var n2 = BigInt(200)
        n2 -= BigInt(100)
        Test.do(n2, BigInt(100), "Simple isub method")

        Test.do(
            BigInt(5) - -BigInt(3),
            BigInt(8),
            "sub3"
        )

        Test.do(
            BigInt(5) - BigInt(10),
            BigInt(-5),
            "sub to negative"
        )

        Test.do(
            BigInt(5) - BigInt(7),
            BigInt(-2),
            "sub to negative"
        )

        Test.do(
            BigInt(-3) - BigInt(4),
            BigInt(-7),
            "single neg sub"
        )

        Test.do(
            BigInt(-3) - BigInt(-4),
            BigInt(1),
            "double neg sub"
        )

        Test.do(
            BigInt(18) - BigInt(9),
            BigInt(9),
            "Digit loss sub"
        )

        Test.do(
            BigInt("1000000000000000000000") - BigInt("999999999999999999999"),
            BigInt(1),
            "Digit loss sub2"
        )
        
    @staticmethod
    fn other_op():
        Test.do(
            -BigInt(10),
            BigInt(-10),
            "Negate operator"
        )
        var n = BigInt(10)
        n.neg()
        Test.do(
            n,
            BigInt(-10),
            "neg method"
        )

        # Test.do(
        #     ~BigInt(234),
        #     BigInt(-235),
        #     "invert op"
        # )

        fn func1() -> Bool:
            if BigInt(1):
                return True
            return False

        fn func2() -> Bool:
            if not BigInt(0):
                return True
            return False

        _ = assert_true(func1(), "bool True failed")
        _ = assert_true(func2(), "bool False failed")