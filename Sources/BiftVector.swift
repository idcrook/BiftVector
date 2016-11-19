
// API
//
// Constructor
//  - BiftVector(size: 0)
//  - BiftVector(bitlist: [1,0,1,0,0,1,0,1,0,0,1,0,1,0,0,1])
//  - BiftVector(bitlist: "1010010100101001")
//  - BiftVector(intVal: 8675309)
//  - BiftVector(intVal: 8675309, size: 24)
//  - BiftVector(textString: "hello")
//  - BiftVector(hexString: "decafBAD")
//  - bv2 = b1.copy()  // Copy constructor
//
//
// Display
//  - print(bv)
//  - let d = bv.description
//  - led dd = bv.debugDescription
//  - let i = Int(bv)  // may return an array of Ints
//
// Accessing and setting bits / slices
//  - let bit_1_or_0 = bv[M]
//  - let sliceBv = bv[M:N]
//  - for bit in biftvec { print ("\(bit)") }
//
// Logical opertions
//  - bvr = bv1 ^ bv2     // Bitwise Logical XOR
//  - bvr = bv1 & bv2     // Bitwise Logical AND
//  - bvr = bv1 | bv2     // Bitwise Logical OR
//  - bvr = ~bv1          // Bitwise negation
//
// BiftVector comparisons
//  - bv1 == bv2
//  - bv1 != bv2
//  - bv1 <  bv2
//  - bv1 <= bv2
//  - bv1 >  bv2
//  - bv1 >= bv2
//
// // Add advance operations tier 2
//


struct BiftVector {

    var _bv: [Int]?
    var size: Int = 0
    
    init? (size: Int) {
        guard size >= 0 else {
            // Error:
            return
        }
        _bv = [Int]()
        
    }
    
    
}

extension BiftVector : CustomStringConvertible {
    
    var description: String {
        guard size >= 0 else {
            return "Error: BiftVector size less than zero."
        }
        return "FIXME"
    }
}
