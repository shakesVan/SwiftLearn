//: Playground - noun: a place where people can play

//结构体
struct SomeStructure {
    // 在这里定义结构体
}

struct Persion {
    //属性
    var name: String
}

//方法自动生成
let persion = Persion(name: "xiaohe")
print(persion.name)
//persion.name = "xiaoming" //error let对象 的属性无法改变
print(persion.name)
var otherPersion = persion
otherPersion.name = "zhangliang"
print(otherPersion.name)
print(persion.name)


// warring 一般创建对象时需要设置默认值
struct Resolution {
    var width = 0
    var height = 0
}

let someResolution = Resolution()
let someResolution1 = Resolution(width: 1, height: 1)
print(someResolution.height)
print(someResolution1.height)

//class 定义
class SomeClass {
    
}

class Car {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

let car = Car(name: "bmw")
print(car.name)
car.name = "benci"
print(car.name)
var myCar = car
myCar.name = "ofo"
print(myCar.name)
print(car.name)

print(car === myCar)




