//: Playground - noun: a place where people can play

//import Foundation

var str = "Hello, world"
print(str)

let a: Int = 1
//a = 2 //error
var b: Int = 2
b = 3 //success

let c1 = 1
print(c1)

let c: Int = 3
let d: Double = 4

//print(c > d)// binary operator '>' cannot be applied to operands of type 'Int' and 'Double'
//let cd = c * d //error


class Persion {
    var name: String = ""
}

class Student: Persion {
    var studentId: String = ""
}

func printName(persion: Persion) {
    print(persion.name)
}

func printStudentName(student: Student) {
    print(persion.name)
}

let persion: Persion = Persion()
persion.name = "xiaohe"
printName(persion: persion)
//printStudentName(student: persion as! Student)

let student: Student = Student()
student.name = "xueshen"
printName(persion: student)
printStudentName(student: student)


