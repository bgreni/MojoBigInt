from math import max, min
from memory import memcpy, memset_zero, memcmp

alias InternalType = UInt8
alias Type = DType.uint8
alias Data = DTypePointer[Type]
alias BASE = UInt8(10)

struct BigInt:
    var data: Data
    var capacity: Int
    var sign: Bool
    var size: Int

    fn __init__(inout self):
        self.sign = False
        self.size = 1
        self.capacity = 4
        self.data = self.allocate(self.capacity)
        self.store(0, 0)

    fn __init(inout self, init_val: Int):
        var val = init_val
        self.sign = init_val > 0
        self.size = 0
        self.capacity = 4
        self.data = self.allocate(self.capacity)
        while val != 0:
            let temp = init_val % 10
            self.push_digit(temp)
            val /= 10

    fn __init__(inout self, init_val: String):
        self.sign = False
        self.size = len(init_val)
        self.capacity = self.size * 2
        self.data = self.allocate(self.capacity)
        for i in range(self.size):
            try:
                self.store(self.size - 1 - i, atol(init_val[i]))
            except:
                pass

    fn __del__(owned self):
        self.data.free()

    @always_inline
    @staticmethod
    fn allocate(size: Int) -> Data:
        return Data.alloc(size)

    @always_inline
    fn load(self, ind: Int) -> InternalType:
        return self.data.load(ind)

    @always_inline
    fn store(self, ind: Int, val: InternalType):
        self.data.store(ind, val)

    fn push_digit(inout self, digit: InternalType):
        if self.size == self.capacity:
            self.grow()
        self.store(self.size, digit)
        self.size += 1
    
    fn pop_digit(inout self):
        self.store(self.size -1, 0)
        self.size -= 1
    
    @always_inline
    fn __getitem__(self, ind: Int) -> InternalType:
        return self.load(ind)
    
    @always_inline
    fn __setitem__(self, ind: Int, val: InternalType):
        self.store(ind, val)

    fn __copyinit__(inout self, other: Self):
        self.sign = other.sign
        self.capacity = other.capacity
        self.size = other.size
        self.data = self.allocate(self.capacity)
        memcpy(self.data, other.data, self.size)

    # TODO: handle negative values
    fn add(inout self, other: BigInt):
        var carry: InternalType = 0 
        for i in range(self.size):
            let temp = self[i] + other[i] + carry
            self[i] = temp % BASE
            carry = temp / BASE

        if carry != 0:
            self.push_digit(carry)

    fn __add__(self, other: BigInt) -> Self:
        var carry: InternalType = 0 
        var out = self if self.size > other.size else other
        let size = max(self.size, other.size)
        for i in range(self.size):
            let temp = self[i] + other[i] + carry
            out[i] = temp % BASE
            carry = temp / BASE

        if carry != 0:
            out.push_digit(carry)

        return out

    fn grow(inout self, size: Int = 0):
        let new_size = self.capacity * 2 if size == 0 else size
        let new_data = self.allocate(new_size)
        memcpy(new_data, self.data, self.size)
        self.data.free()
        self.data = new_data
        self.capacity = new_size

    fn shrink(inout self):
        let new_data = self.allocate(self.size)
        memcpy(new_data, self.data, self.size)
        self.data.free()
        self.data = new_data
    
    @always_inline
    fn __len__(self) -> Int:
        return self.size
    
    fn print(self):
        var s = String()
        for i in range(self.size - 1, -1, -1):
            let v = self.load(i)
            s += v
        print(s)

    fn __eq__(self, other: BigInt) -> Bool:
        if self.size != other.size:
            return False
        return memcmp[Type](self.data, other.data, self.size) == 0
    
    fn __lt__(self, other: BigInt) -> Bool:
        if self.size < other.size:
            return True
        if self.size > other.size:
            return False
        
        for i in range(self.size - 1, -1, -1):
            let n1 = self.load(i)
            let n2 = other.load(i)
            if n1 < n2:
                return True
            elif n2 < n1:
                return False
        return False

    fn __gt__(self, other: BigInt) -> Bool:
        if self.size > other.size:
            return True
        if self.size < other.size:
            return False
        
        for i in range(self.size - 1, -1, -1):
            let n1 = self.load(i)
            let n2 = other.load(i)
            if n1 > n2:
                return True
            elif n2 > n1:
                return False
        return False
    
    fn __le__(self, other: BigInt) -> Bool:
        if self.size < other.size:
            return True
        if self.size > other.size:
            return False
        
        for i in range(self.size - 1, -1, -1):
            let n1 = self.load(i)
            let n2 = other.load(i)
            if n1 < n2:
                return True
            elif n2 < n1:
                return False
        return True

    fn __ge__(self, other: BigInt) -> Bool:
        if self.size > other.size:
            return True
        if self.size < other.size:
            return False
        
        for i in range(self.size - 1, -1, -1):
            let n1 = self.load(i)
            let n2 = other.load(i)
            if n1 > n2:
                return True
            elif n2 > n1:
                return False
        return True