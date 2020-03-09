import UIKit



var longStr = "start "

for i in 0..<1000 {
    longStr += "\(i % 3 + 1)aws "
}
longStr += "end"

// MARK: # 1
/*
 * 每个单词的类型都是 SubString，这正是 String 所关联的 SubSequence 类型。
 * 当你想要分割一个集合类型时，split 方法往往是最适合的工具。
 * 不过，它有一个缺点：这个方法将会热心地为你计算出整个数组。
 * 如果你的字符串非常大，而且你只需要前几个词的话，这么做是相当低效的。(split 方法可以传入 maxSplits 来制定分割的次数)
 */

/**
 * 2020.02.26 打印结果显示耗时上 1 完胜 3, 3 完胜 2
 * 所以说效率低下是指内存上? 还是说有同 1 一样的懒加形式的实现?
 */

let splitArray1 = Array("coding make me happily".split(separator: " ").reversed()).joined(separator: " ")
//print(splitArray1)

let startTime0 = CFAbsoluteTimeGetCurrent()
let splitArray2 = Array(longStr.split(separator: " ").reversed()).joined(separator: " ")
print(CFAbsoluteTimeGetCurrent() - startTime0)


// MARK: # 2 面试指导!!! ( 时间复杂度并不是 O(n), 循环里面嵌套循环,内循环为单词的长度,内循环总次数为去除 " " 后的字符个数, 总时间复杂度应为 O(n2) )

func _reverse<T>(_ chars: inout [T], _ start: Int, _ end: Int) {
    var start = start, end = end
    
    while start < end {
        _swap(&chars, start, end)
        start += 1
        end -= 1
    }
}
func _swap<T>(_ chars: inout [T], _ p: Int, _ q: Int) {
    (chars[p], chars[q]) = (chars[q], chars[p])
}

func reverseWords(s: String?) -> String? {
    guard let s = s else {
        return nil
    }
    var chars = s.map({ $0 }), start = 0
    let end = chars.count - 1
    // 先整体翻转
    _reverse(&chars, start, end)
    // 翻转空格前的字符 (这里可以替换为 set 集合)
//    for i in 0 ... end  {
//        if i == end || chars[i + 1] == " " {
//            _reverse(&chars, start, i)
//            start = i + 2
//        }
//    }
    // 翻转包含 指定分割符的 方法
    for i in 0...end  {
        if i == end || _isWordBoundary(chars[i + 1]){
            _reverse(&chars, start, i)
            start = i + 2
        }
    }
    
    return String(chars)
}

//public let punctuationSet: Set<Character> = [" ", ",", ".", "!", ";"]
func _isWordBoundary(_ char: Character) -> Bool {
//    return punctuationSet.contains(char)
    return char == " "
}

//reverseWords(s: "coding make me happily")

let startTime = CFAbsoluteTimeGetCurrent()
reverseWords(s: longStr)
let endTime = CFAbsoluteTimeGetCurrent()
print(endTime - startTime)


// MARK: # 3

extension Substring {
    // 寻找第一个单词的范围
    var nextWordRange: Range<Index> {
        let start = drop(while: { $0 == " " })
        let end = start.firstIndex(where: { char in _isWordBoundary(char) }) ?? endIndex
        return start.startIndex..<end
    }
}

struct WordsIndex: Comparable {
    fileprivate let range: Range<Substring.Index>
    fileprivate init(_ value: Range<Substring.Index>) {
        range = value
    }
    
    static func <(lhs: WordsIndex, rhs: WordsIndex) -> Bool {
        return lhs.range.lowerBound < rhs.range.lowerBound
    }
    
    static func ==(lhs: WordsIndex, rhs: WordsIndex) -> Bool {
        return lhs.range == rhs.range
    }
}

struct Words: Collection {
    let string: Substring
    let startIndex: WordsIndex
    
    init(_ s: String) {
        self.init(s[...])
    }
    
    private init(_ s: Substring) {
        self.string = s
        self.startIndex = WordsIndex(string.nextWordRange)
    }
    
    // collection 协议
    var endIndex: WordsIndex {
        let e = string.endIndex
        return WordsIndex(e..<e)
    }
}

extension Words {
    // collection 协议
    subscript(index: WordsIndex) -> Substring {
        return string[index.range]
    }
    // collection 协议
    func index(after i: WordsIndex) -> WordsIndex {
        guard i.range.upperBound < string.endIndex else {
            return endIndex
        }
        let remainder = string[i.range.upperBound...]
        return WordsIndex(remainder.nextWordRange)
    }
}

//let str3 = "coding make me happily"
//let words = Words(str3)
//let wordsSlice = words[words.startIndex...]
//print(Array(wordsSlice.reversed()))

let startTime2 = CFAbsoluteTimeGetCurrent()
let words = Words(longStr)
let wordsSlice = words[words.startIndex...]
wordsSlice.reversed().joined(separator: " ")
let endTime2 = CFAbsoluteTimeGetCurrent()
print(endTime2 - startTime2)



// 将 Words 本身作为 Slice<Words> 来使用
extension Words {
    subscript(range: Range<WordsIndex>) -> Words {
        let start = range.lowerBound.range.lowerBound
        let end = range.upperBound.range.upperBound
        return Words(string[start..<end])
    }
}



