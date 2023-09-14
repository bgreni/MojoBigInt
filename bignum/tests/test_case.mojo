from bignum.bigint import BigInt
from testing import assert_true, assert_false

struct NumericTestCase:
    @staticmethod
    fn do(
        actual: BigInt,
        expected: BigInt,
        test: String
    ):
        var errorMsg = "\n" + test
        errorMsg += ":\nexpected: " + \ 
            expected.to_string() + \ 
            "\nactual:   " + actual.to_string() + "\n"
        let result = actual == expected
        _ = assert_true(result, errorMsg)
        