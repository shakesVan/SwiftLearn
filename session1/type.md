# 类型系统

###万物皆类型

常量，变量，类，结构体，函数，方法

### 基本类型

Int: 1 2 3

Double: 1.0 2.5

Float (精度没Double高，基本被Double取代)

Bool: true false

String: "hello"  "你好"

//nil any 可选类型
### 集合类型

#### 数组

```
var someArray = [SomeType]()
var someBools: Array<SomeType> = [] 
var someBools: [SomeType] = []  //推荐

var someInts = [10, 20, 30]

print(someInts[0])//取 
someInts[1] = 25//改
someInts.append(40)//增
//遍历
for item in someInts {
   print(item)
}

//元素个数
 someInts.count
//isEmpty 属性
someInts.isEmpty = someInts.count == 0
```

#### 字典

```
var someDict =  [KeyType: ValueType]()
var someDict = [Int: String]()
var someDict: [Int: String] = [1: "One", 2: "Two", 3: "Three"]

let someVar = someDict[3] //取
//let someVar1 = someDict[4] //取
print(someVar)
someDict[1] = "One 新的值" //修改
someDict[2] = nil //删除

//遍历
for (key, value) in someDict {
   print("字典 key \(key) -  字典 value \(value)")
}

//元素个数
 someDict.count
 
//isEmpty 属性
someInts.isEmpty = someInts.count == 0
```



###类型别名

```
typealias Feet = Int
```

定义了 Int 的类型别名为 Feet

```
var distance: Feet = 100
print(distance)
```

定了类型别名，类型未发生改变 Feet 和Int 是同一类型



### 类型推断

```
let meaningOfLife = 42
// meaningOfLife 会被推测为 Int 类型
let pi = 3.14159
// pi 会被推测为 Double 类型
let anotherPi = 3 + 0.14159
// anotherPi 会被推测为 Double 类型
```

### 类型安全（代码）

Swift 是一个类型安全（type safe）的语言。

由于 Swift 是类型安全的，所以它会在编译你的代码时进行类型检查（type checks），并把不匹配的类型标记为错误。这可以让你在开发的时候尽早发现并修复错误。

```
var varA = 42
varA = "This is hello"
print(varA)
```

```
error: cannot assign value of type 'String' to type 'Int'
varA = "This is hello"
```

意思为不能将 'String' 字符串赋值给 'Int' 变量。



（markdown编辑文件 typora）
