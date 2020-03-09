import Foundation

//class MyClass: Equatable {
//    static func == (lhs: MyClass, rhs: MyClass) -> Bool{
//        print("进行了MyClass的equal判断!")
//        return lhs === rhs
//    }
//}
//let cls1 = MyClass()
//let cls2 = cls1
//
//infix operator |||
//func |||(_ left: @autoclosure () -> Bool, _ right: @autoclosure () -> Bool) -> Bool {
//    if left() {
//        return true
//    } else {
//        return right()
//    }
//}
//
//print("\(true ||| (cls1 == cls2))")
//
//infix operator ||||
//func ||||(_ left: Bool, _ right: Bool) -> Bool {
//    if left {
//        return true
//    } else {
//        return right
//    }
//}
//
//print("\(true |||| (cls1 == cls2))")
//
///// 正确理解Swift中的值捕获
//
//var outNum = 1
//
//var closure1 =  {
//    outNum += 1
//    print("closure1: num = \(outNum)")
//}
//outNum += 1
//var closure2 = { [outNum] in
//    // outNum += 1 // 报错: 不能修改let变量
//    print("closure2: num = \(outNum)")
//}
//outNum += 1
//print("outNum = \(outNum)")
//
//closure1()
//closure2()
//
///// 柯里化
//func add(_ num: Int) -> (Int) -> Int {
//    return {value in
//        return num + value
//    }
//}
//add(2)(3)
//// 等同于
//let addTwo = add(2) // let addTwo: (Int) -> Int
//addTwo(3)


/*
 实现一个函数,返回指定数字间为偶数并且切好是其他数字平方的数字
 */

//func evenSquareNums1(from: Int, to: Int) -> [Int] {
//    guard from <= to else {
//        return [Int]()
//    }
//    let low = Int(ceil(Double(from).squareRoot()))
//    let heigh = Int(floor(Double(to).squareRoot()))
//    let result = (low...heigh).map { $0 * $0 }.filter { $0 % 2 == 0 }
//    return result
//
//}
//print("evenSquareNums1 rssult: \(evenSquareNums1(from: 10, to: 99))")
//
//// 非函数式过程
//func evenSquareNums2(from: Int, to: Int) -> [Int] {
//    var res = [Int]()
//    guard from <= to else {
//        return res
//    }
//    for num in from...to where num % 2 == 0 && isSquare(num)  {
//        res.append(num)
//    }
//    return res
//}
//fileprivate func isSquare(_ num: Int) -> Bool {
//    let squareRootValue = Double(num).squareRoot()
//    let low = ceil(squareRootValue)
//    return low == squareRootValue
////    let heigh = floor(squareRootValue)
////    return low == heigh
//}
//
//print("evenSquareNums2 rssult: \(evenSquareNums2(from: 10, to: 99))")



protocol SomeProtocol: class {
    func doSomething()
}

class SomeClass {
    weak var delegate: SomeProtocol?
}
