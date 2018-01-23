#!/usr/bin/swift
//import Foundation

func checkType<T>(_ checkType: T) {
    let typeStr = type(of:checkType)
    print(typeStr)
}

checkType(1)


let add: (Int, Int) -> Int = {
    a, b in
    return a + b
}
checkType(add)

print(add(1, 2))

func swapTwoInts(_ a: inout Int, _ b: inout Int) -> Void {
    let temporaryA = a
    a = b
    b = temporaryA
}

checkType(swapTwoInts)

func calcDecrement(forDecrement total: Int) -> () -> Int {
    var overallDecrement = 0
    func decrementer() -> Int {
        overallDecrement -= total
        return overallDecrement
    }
    return decrementer
}

checkType(calcDecrement)
