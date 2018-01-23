# 函数

### 函数
#### 最简函数
```
func sayHello() {
    print("hello world!")
}

sayHello() //调用函数
```
func 声明是函数
sayHello 函数名
() 无参数
{} 函数体

print() 系统函数

sayHello 的类型：() -> () 
Void 表示无放回值等价于(), 也可以写成  () -> Void

#### 有参数函数
```
func sayHello(name: String) {
    print("hello \(name)")
}

sayHello(name: "swift")
```
name 参数名
: String 参数类型
"\(name)"  取出name的值

sayHello 的类型：(String) -> Void 
```
func getSayHello(_ name: String, to other: String) {
    let result = "\(name) say hello to \(other) "
}

getSayHello("xiaohe", to: "swift")
```
to 外参
other 内参
_ 忽略外参

getSayHello 的类型：(String, String) -> Void 
#### 有返回值函数

```
func getHello(name: String) -> String {
    let result = "hello \(name)"
    return result
}

-> 有返回值
String 返回值类型

getHello 的类型：(String) -> String
```
#### 可变参数
```
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
// 返回 3.0, 是这 5 个数的平均数。
arithmeticMean(3, 8.25, 18.75)
// 返回 10.0, 是这 3 个数的平均数。
```
#### 输入输出参数函数

```
//输入输出参数
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}


var x = 1
var y = 5
swapTwoInts(&x, &y)
print("x 现在的值 \(x), y 现在的值 \(y)")

swapTwoInts 类型为 (inout Int, inout Int) -> Void 
```

#### 函数类型可以作为参数类型
```
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)
// 打印 "Result: 8"
```
####函数类型可以作为返回类型
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    //嵌套函数
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// -4...
// -3...
// -2...
// -1...
// zero!


### 闭包
Swift中的闭包有很多优化的地方:

根据上下文推断参数和返回值类型
从单行表达式闭包中隐式返回（也就是闭包体只有一行代码，可以省略return）
可以使用简化参数名，如$0, $1(从0开始，表示第i个参数...)
提供了尾随闭包语法(Trailing closure syntax)
语法
```
{(parameters) -> return type in
   statements
}
```
```
{ 
    print("hello")
}

//执行闭包
{
    print("hello")
}()

//定义一个无参数 无返回值的闭包
let sayHello: () -> Void = {
    print("hello")
}

//调用
sayHello()

let add: (Int, Int) -> Int = {
    a, b in
    return a + b
}

let value = add(2, 5) // 7
print(value)
//类型推断
let divide = {(val1: Int, val2: Int) -> Int in
   return val1 / val2
}
let result = divide(200, 20)
print (result)
```


#### 闭包表达式
##### sorted 方法
Swift 标准库 提供了sorted(by:) 的方法
sorted(by:)方法需要传入两个参数：

1 数组
2 排序函数（闭包）：如何进行排序

##### 值捕获
闭包可以在其被定义的上下文中捕获常量或变量。即使定义这些常量和变量的原作用域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值。

Swift 中，可以捕获值的闭包的最简单形式是嵌套函数，也就是定义在其他函数的函数体内的函数。嵌套函数可以捕获其外部函数所有的参数以及定义的常量和变量。
```
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)

incrementByTen()
// 返回的值为10
incrementByTen()
// 返回的值为20
incrementByTen()
// 返回的值为30
```
##### 闭包是引用类型
```
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()
// 返回的值为40



```

##### 逃逸闭包
关键字 @escaping
闭包需要在函数返回之后被调用


##### 使用闭包可能引起的循环强引用

[Swift中闭包的简单使用](https://www.jianshu.com/p/7c599b96815b)

## 使用闭包可能引起的循环强引用

Swift中不当的使用闭包可能会引起**循环强引用**，之所以称之为“强”引用，是因为它会将实例保持住，只要强引用还在，实例是不允许被销毁的。循环强引用会一直阻止类实例的释放，这就在你的应用程序中造成了**内存泄漏**。
举个例子：

```
import UIKit
class ThirdViewController: UIViewController {
    var callBack: ((String) -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        printString { (text) in
            print(text)
            //闭包中捕获了self
            self.view.backgroundColor = UIColor.red
        }
    }
    func printString(callBack:@escaping (String) -> ()) {
        callBack("这个闭包返回一段文字")
        //控制器强引用于着callBack
        self.callBack = callBack
    }
    deinit {
        print("ThirdViewController---释放了")
    }
}

```

![img](http://upload-images.jianshu.io/upload_images/2474121-53053db8b30b8932.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

当你在定义printString这个方法时执行self.callBack = callBack代码实际上是self对callBack闭包进行了强引用，到这里其实并没有产生循环引用，但是当你在调用printString方法的闭包里面又访问了self.view.backgroundColor属性，此时强引用就发生了，即self引用了callBack,而callBack内部又引用着self,谁都不愿意松手，我们就说这两者之间产生了循环强引用。

**使用闭包何时会出现循环强引用** ：

当你把一个闭包分配给类实例属性的时候，并且这个闭包中又捕获了这个实例。捕获可能发生于这个闭包函数体中访问了实例的某个属性，比如 `self.someProperty` ，或者这个闭包调用了一个实例的方法，例如 `self.someMethod()` 。这两种情况都导致了闭包**捕获**了`self` ，从而产生了循环强引用。

**闭包循环引用的本质是：**
闭包中循环强引用的产生，是因为闭包和类相似（还有一种两个类实例之间的循环强引用），都是引用类型。当你把闭包赋值给了一个属性，你实际上是把一个引用赋值给了这个闭包。两个强引用让彼此一直有效。

**如何解决闭包的循环强引用：**

- 方式一：类似于Objective-C中使用`__weak`解决block的循环引用，Swift中支持使用`weak`关键字将类实例声明为**弱引用类型**（注意，弱引用类型总是可选类型），打破类实例对闭包的强引用，当对象销毁之后会自动置为`nil`，对`nil`进行任何操作不会有反应。

```
import UIKit
class ThirdViewController: UIViewController {
    var callBack: ((String) -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        //将self申明为弱引用类型，打破循环引用
        weak var weakSelf = self
        printString { (text) in
            print(text)
            //闭包中铺捕获了self
            weakSelf?.view.backgroundColor = UIColor.red
        }
    }
    func printString(callBack:@escaping (String) -> ()) {
        callBack("这个闭包返回一段文字")
        //控制器强引用于着callBack
        self.callBack = callBack
    }
    deinit {
        print("ThirdViewController---释放了")
    }
}

```

- 方式二：作为第一种方式的简化操作，我们可以在闭包的第一个大括号后面紧接着插入这段代码`[weak self]`，后面的代码直接使用`self？`也能解决循环引用的问题。

```
import UIKit
class ThirdViewController: UIViewController {
    var callBack: ((String) -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        printString {[weak self]  (text) in
            print(text)
            self?.view.backgroundColor = UIColor.red
        }
    }
    func printString(callBack:@escaping (String) -> ()) {
        callBack("这个闭包返回一段文字")
        //控制器强引用于着callBack
        self.callBack = callBack
    }
    deinit {
        print("ThirdViewController---释放了")
    }
}

```

- 方式三：在闭包和捕获的实例总是互相引用并且总是同时释放时，可以将闭包内的捕获定义为无主引用`unowned`。

```
import UIKit
class ThirdViewController: UIViewController {
    var callBack: ((String) -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        printString {[unowned self]  (text) in
            print(text)
            self?.view.backgroundColor = UIColor.red
        }
    }
    func printString(callBack:@escaping (String) -> ()) {
        callBack("这个闭包返回一段文字")
        //控制器强引用于着callBack
        self.callBack = callBack
    }
    deinit {
        print("ThirdViewController---释放了")
    }
}

```

**注意：**`unowned`是Swift中另外一种解决循环引用的申明无主引用类型的关键字，类似于Objective-C中的`__unsafe_unretained`；大家都知道`__weak`和`__unsafe_unretained`的相同点是可以将该关键字修饰的对象变成弱引用解决可能存在的循环引用。不同点在于前者修饰的对象如果发现被销毁，那么指向该对象的指针会立即指向`nil`，而`__unsafe_unretained`修饰的对象如果发现被销毁，指向该对象的指针依然指向原来的内存地址，如果此时继续访问该对象很容易产生坏内存访问/野指针/僵尸对象访问。

**说明：**同样的道理**Swift**中也是一样的。和弱引用类似，无主引用不会牢牢保持住引用的实例。但是不像弱引用，总之，无主引用假定是永远有值的。因此，**无主引用总是被定义为非可选类型**。你可以在声明属性或者变量时，在前面加上关键字`unowned` 表示这是一个无主引用。由于无主引用是非可选类型，你不需要在使用它的时候将它展开。无主引用总是可以直接访问。不过** ARC** 无法在实例被释放后将无主引用设为 `nil` ，因为非可选类型的变量不允许被赋值为 `nil` 。**如果此时继续访问已经被释放实例很容易产生坏内存访问/野指针/僵尸对象访问。**所以**Swift**建议我们如果被捕获的引用永远不为 `nil` ，应该用`unowned`而不是`weak`，相反，如果你不确定闭包中捕获的引用是不是存在为`nil`的可能，你应该使用`weak`。

