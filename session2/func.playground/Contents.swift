//: Playground - noun: a place where people can play

import Foundation

func checkType<T>(_ checkType: T) {
    let typeStr = type(of:checkType)
    print(typeStr)
}

checkType(1)




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


let add: (Int, Int) -> Int = {
    a, b in
    return a + b
}
checkType(add)

print(add(1, 2))

let divide = {(val1: Int, val2: Int) -> Int in
    return val1 / val2
}
let result = divide(200, 20)
print (result)


//sorted 方法
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)

//闭包表达式语法
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
//一行代码
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )
//根据上下文推断类型
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
//单表达式闭包隐式返回
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
//参数名称缩写
reversedNames = names.sorted(by: { $0 > $1 } )
//运算符方法
reversedNames = names.sorted(by: > )
//尾随闭包
reversedNames = names.sorted() { $0 > $1 }
//如果闭包表达式是函数或方法的唯一参数，则当你使用尾随闭包时，你甚至可以把 () 省略掉：
reversedNames = names.sorted { $0 > $1 }

