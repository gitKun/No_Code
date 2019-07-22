

// MARK: # 1
/*
 * 每个单词的类型都是 SubString，这正是 String 所关联的 SubSequence 类型。
 * 当你想要分割一个集合类型时，split 方法往往是最适合的工具。
 * 不过，它有一个缺点：这个方法将会热心地为你计算出整个数组。
 * 如果你的字符串非常大，而且你只需要前几个词的话，这么做是相当低效的。
 */
let splitArray1 = Array("coding make me happily".split(separator: " ").reversed()).joined(separator: " ")
print(splitArray1)


// MARK: # 2 面试指导!!!

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
    for i in 0 ... end  {
        if i == end || _isWordBoundary(chars[i + 1]){
            _reverse(&chars, start, i)
            start = i + 2
        }
    }
    
    return String(chars)
}

func _isWordBoundary(_ char: Character) -> Bool {
    let punctuationSet: Set<Character> = [" ", ",", ".", "!", ";"]
    return punctuationSet.contains(char)
}

reverseWords(s: "coding make me happily")

// MARK: # 3

let str3 = "coding make me happily"

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

let words = Words(str3)
let wordsSlice = words[words.startIndex...]
print(Array(wordsSlice))

// 将 Words 本身作为 Slice<Words> 来使用
extension Words {
    subscript(range: Range<WordsIndex>) -> Words {
        let start = range.lowerBound.range.lowerBound
        let end = range.upperBound.range.upperBound
        return Words(string[start..<end])
    }
}



