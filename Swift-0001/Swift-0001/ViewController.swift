//
//  ViewController.swift
//  Swift-0001
//
//  Created by AlanYen on 2016/11/24.
//  Copyright © 2016年 Alan-App. All rights reserved.
//

import UIKit

protocol ExampleProtocol {
    
    var simpleDescription: String {
        get
    }
    mutating func adjust()
}

extension Int: ExampleProtocol {

    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}


class ViewController: UIViewController {

    @IBOutlet weak var myVariableLabel: UILabel?
    @IBOutlet weak var myConstantLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Swift 初見
        // http://c.biancheng.net/cpp/html/2424.html
        //
        demo01()
        demo02()
        demo03()
        demo04()
        demo05()
        demo06()
        demo07()
        demo08()
        demo09()
        demo10()
        demo11()
        demo12()
        demo13()
        demo14()
        demo15()
        demo16()
        demo17()
        demo18()
        demo19()
        demo20()
        demo21()
        demo22()
        demo23()
        demo24()
        demo25()
        demo26()
        
        // If need rebase
        // http://zerodie.github.io/blog/2012/01/19/git-rebase-i/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    // MARK: demo01
    //
    
    func demo01() {
        
        /*
         簡單值:
         使用let來聲明常量，使用var來聲明變量。一個常量的值在編譯時並不需要獲取，但是你只能為它賦值一次。
         也就是說你可以用常量來表示這樣一個值：你只需要決定一次，但是需要使用很多次。
         
         var myVariable = 42
         myVariable = 50
         let myConstant = 42
         
         常量或者變量的類型必須和你賦給它們的值一樣。然而，聲明時類型是可選的，聲明的同時賦值的話，編譯器會自動推斷類型。
         在上面的例子中，編譯器推斷出myVariable是一個整數（integer）因為它的初始值是整數。
         */
        
        var myVariable = 42
        myVariable = 50
        
        // Int => String 轉換
        myVariableLabel?.text = "var:  " + String(myVariable)
        // \() 表示法
        // myVariableLabel?.text = "var:  \(myVariable)"
        
        let myConstant = 42
        // Int => String 轉換
        myConstantLabel?.text = "let:  " + String(myConstant)
        // \() 表示法
        // myConstantLabel?.text = "let:  \(myConstant)"
    }
    
    //
    // MARK: demo02
    //
    
    func demo02() {
        
        /*
         如果初始值沒有提供足夠的信息（或者沒有初始值），那你需要在變量後面聲明類型，用冒號分割。
         */
        
        // 輸出：Int
        let implicitInteger = 70
        print(type(of: implicitInteger))
        
        // 輸出：Double
        let implicitDouble = 70.0
        print(type(of: implicitDouble))
        
        // 輸出：Double
        let explicitDouble: Double = 70
        print(type(of: explicitDouble))
        
        // 輸出：String
        let testString = "Hello"
        print(type(of: testString))
        
        // 輸出：UIView
        let view = UIView()
        print(type(of: view))
        
        // 輸出：UIImage
        let image = UIImage()
        print(type(of: image))
    }
    
    //
    // MARK: demo03
    //
    
    func demo03() {
        
        /*
         var literalArray = [0,1,1,2,3,5,8,13,21]
         var emptyArray = [Int]()
         var defaultValueArray = [Int](count: 5, repeatedValue: 0)
         第三行也是通過構造函數初始化創建,只不過創建了一個包含5個都為0的元素數組。
         [Int]形式創建數組實際上是Array<T>的簡單寫法,Array<T>這種方式並沒有在上面表格中列出,由於[Int]易讀性強,Apple鼓勵使用這種簡單方式創建數組。
         */
        
        let emptyStrings = [String]()
        print(emptyStrings)
        
        let emptyDoubles: [Double] = []
        print(emptyDoubles)
        
        let emptyFloats: Array<Float> = Array()
        print(emptyFloats)
        
        let shoppingLists = ["catfish", "water", "tulips", "blue paint"]
        print(shoppingLists)
        
        /*
         使用方括號[]來創建數組和字典，並使用下標或者鍵（key）來訪問元素。
         */
        
        var shoppingList = ["catfish", "water", "tulips", "blue paint"]
        print(shoppingList)
        
        // Replace
        shoppingList[1] = "bottle of water"
        print(shoppingList)
        
        // Insert
        var occupations = ["Malcolm": "Captain", "Kaylee": "Mechanic"]
        print(occupations)
        occupations["Jayne"] = "Public Relations"
        print(occupations)
        
        // Delete
        occupations.removeValue(forKey: "Jayne")
        print(occupations)
    }
    
    //
    // MARK: demo04
    //
    
    func demo04() {
        
        /*
         控制流
         使用if和switch來進行條件操作，使用for-in、for、while和do-while來進行循環。
         包裹條件和循環變量括號可以省略，但是語句體的大括號是必須的。
         */
        
        let individualScores = [75, 43, 103, 87, 12]
        var teamScore = 0
        for score in individualScores {
            print(score)
            if score > 50 {
                teamScore += 3
            }
            else {
                teamScore += 1
            }
        }
        print(teamScore)
    }
    
    //
    // MARK: demo05
    //
    
    func demo05() {
        
        let optionalName: String? = "John Appleseed"
        //let optionalName: String? = nil
        var greeting = "Hello!"
        
        if let name = optionalName {
            greeting = "Hello, \(name)"
        }
        print(greeting)
    }
    
    //
    // MARK: demo06
    //
    
    func demo06() {
        
        /*
         switch支持任意類型的數據以及各種比較操作——不僅僅是整數以及測試相等。
         */
        
        let vegetable = "red pepper"
        
        switch vegetable {
            case "celery":
                let vegetableComment = "Add some raisins and make ants on a log."
                print(vegetableComment)
            
            case "cucumber", "watercress":
                let vegetableComment = "That would make a good tea sandwich."
                print(vegetableComment)
            
            case let x where x.hasPrefix("red"):
                let vegetableComment = x
                print(vegetableComment)
            
            case let x where x.hasSuffix("pepper"):
                let vegetableComment = x
                print(vegetableComment)
        
            default:
                let vegetableComment = "Everything tastes good in soup."
                print(vegetableComment)
        }
    }
    
    //
    // MARK: demo07
    //
    
    func demo07() {
        
        /*
         你可以使用for-in來遍歷字典，需要兩個變量來表示每個鍵值對。
         */
        
        let interestingNumbers = [
                "Prime": [2, 3, 5, 7, 11, 13],
                "Fibonacci": [1, 1, 2, 3, 5, 8],
                "Square": [1, 4, 9, 16, 25],
            ]
        
        var largestKind: String? = nil
        var largest = 0
        for (kind, numbers) in interestingNumbers {
            for number in numbers {
                if number > largest {
                    largest = number
                    largestKind = kind
                }
            }
        }
        
        if let kind = largestKind {
            print(kind + String(largest))
        }
        else {
            print("Can't find largestKind")
        }
    }
    
    //
    // MARK: demo08
    //
    
    func demo08() {

        /*
         你可以在循環中使用 ... 來表示範圍
         */
        
        var firstForLoop = 0
        for i in 0...3 {
            print(i)
            firstForLoop += i
        }
        print(firstForLoop)
        
        /*
         你可以在循環中使用 ..< 來表示範圍
         */
        
        var secondForLoop = 0
        for i in 0..<3 {
            print(i)
            secondForLoop += i
        }
        print(secondForLoop)
    }
    
    //
    // MARK: demo09
    //
    
    func demo09() {
        
        /*
         使用func來聲明一個函數，使用名字和參數來調用函數。使用->來指定函數返回值。
         */
        
        func greet(name: String, day: String) -> String {
            return "Hello \(name), today is \(day)."
        }
        let resultString = greet(name: "Bob", day: "Tuesday")
        print(resultString)
        
        
        func add(first: Int, second: Int) -> Int {
            let result = first + second
            return result
        }
        let resultInt = add(first: 101, second: 202)
        print(resultInt)
    }
    
    //
    // MARK: demo10
    //
    
    func demo10() {

        /*
         使用一個元組來返回多個值。
         */
        
        func getGasPrices() -> (Double, Double, Double) {
            return (3.59, 3.69, 3.79)
        }
        let resultTuples = getGasPrices()
        print(type(of: resultTuples))
        print(resultTuples)
    }
    
    //
    // MARK: demo11
    //
    
    func demo11() {
        
        /*
         函數的參數數量是可變的，用一個數組來獲取它們：
         */
        
        func sumOf(numbers: Int...) -> Int {
            var sum = 0
            for number in numbers {
                print(number)
                sum += number
            }
            return sum
        } 
        var resultInt = sumOf()
        print(resultInt)
        
        resultInt = sumOf(numbers: 10, 11, 12)
        print(resultInt)
    }
    
    //
    // MARK: demo12
    //
    
    func demo12() {

        /*
         函數可以嵌套。被嵌套的函數可以訪問外側函數的變量，你可以使用嵌套函數來重構一個太長或者太複雜的函數。
         */
        
        func returnFifteen() -> Int {
            var y = 10
            func add() {
                y += 5
            }
            add()
            return y
        }
        
        let result = returnFifteen()
        print(result)
    }
    
    //
    // MARK: demo13
    //
    
    func demo13() {
        
        /*
         函數是一等公民，這意味著函數可以作為另一個函數的返回值。
         */
        
        func makeIncrementer() -> ((Int, Int) -> Int) {
            func addOne(number: Int, number2: Int) -> Int {
                return number + number2 + 1
            }
            return addOne
        }
        
        let increment = makeIncrementer()
        let result = increment(1, 2)
        print(result)
    }
    
    //
    // MARK: demo14
    //
    
    func demo14() {
        
        /*
         函數也可以當做參數傳入另一個函數。
         */
        
        func hasAnyMatches(list: [Int], condition: ((Int) -> Bool)) -> Bool {
            for item in list {
                if condition(item) {
                    return true
                }
            }
            return false
        }
        
        func lessThanTen(number: Int) -> Bool {
            return number < 10
        }
        
        let numbers = [20, 19, 7, 12]
        let result = hasAnyMatches(list: numbers, condition: lessThanTen)
        print(result)
    }
    
    //
    // MARK: demo15
    //
    
    func demo15() {

        /*
         函數實際上是一種特殊的閉包，你可以使用{}來創建一個匿名閉包。使用in來分割參數並返回類型。
         */
        
        let numbers = [20, 19, 7, 12]
        let mapNumbers = numbers.map({
            (number: Int) -> Int in
            let result = 3 * number
            return result
        })
        
        print(type(of: mapNumbers))
        print(mapNumbers)
        
        
        let names = ["John", "Bill", "David", "Tom"]
        let mapNames = names.map({
            (name: String) -> String in
            let result = "Hello, I am " + name;
            return result
        })
        
        print(type(of: mapNames))
        print(mapNames)
    }

    //
    // MARK: demo16
    //
    
    func demo16() {
        
        /*
         對象和類
         使用class和類名來創建一個類。類中屬性的聲明和常量、變量聲明一樣，唯一的區別就是它們的上下文是類。同樣，方法和函數聲明也一樣。
         */
        
        class Shape {
            
            var numberOfSides = 0
            
            func simpleDescription() -> String {
                return "A shape with \(numberOfSides) sides."
            } 
        }
        
        let shapeClass = Shape()
        shapeClass.numberOfSides = 100
        print(shapeClass.simpleDescription())
        
        shapeClass.numberOfSides = 200
        print(shapeClass.simpleDescription())
        
        // 注意 self 被用來區別實例變量。當你創建實例的時候，像傳入函數參數一樣給類傳入構造器的參數。
        // 每個屬性都需要賦值——無論是通過聲明（就像numberOfSides）還是通過構造器（就像name）。

        class NamedShape {
            
            var numberOfSides: Int = 0
            var name: String
            
            init(name: String, numberOfSides: Int) {
                self.name = name
                self.numberOfSides = numberOfSides
            }
            
            func simpleDescription() -> String {
                return "\(name) shape with \(numberOfSides) sides."
            }
        }
        
        let namedShapeClass = NamedShape(name: "SwiftNamedShape", numberOfSides: 101)
        print(namedShapeClass.simpleDescription())
    }
    
    //
    // MARK: demo17
    //
    
    func demo17() {
        
        /*
         子類的定義方法是在它們的類名後面加上父類的名字，用冒號分割。創建類的時候並不需要一個標準的根類，所以你可以忽略父類。
         
         子類如果要重寫父類的方法的話，需要用override標記——如果沒有添加override就重寫父類方法的話編譯器會報錯。編譯器同樣會檢測override標記的方法是否確實在父類中。
         */
        
        class NamedShape {
            
            var numberOfSides: Int = 0
            var name: String
            
            init(name: String) {
                self.name = name
            }
            
            func simpleDescription() -> String {
                return "\(name) shape with \(numberOfSides) sides."
            }
        }
        
        class Square: NamedShape {
            
            var sideLength: Double
            
            init(sideLength: Double, name: String) {

                self.sideLength = sideLength
                super.init(name: name)
                numberOfSides = 4
            }
            
            func area() -> Double {
                return sideLength * sideLength
            }

            override func simpleDescription() -> String {
                return "A square with sides of length \(sideLength)."
            }
        }
        
        let test = Square(sideLength: 5.2, name: "my test square")
        print(test.area())
        print(test.simpleDescription())
    }
    
    //
    // MARK: demo18
    //
    
    func demo18() {
    
        /*
         屬性可以有 getter 和 setter 。
         */
        
        class NamedShape {
            
            var numberOfSides: Int = 0
            var name: String
            
            init(name: String) {
                self.name = name
            }
            
            func simpleDescription() -> String {
                return "\(name) shape with \(numberOfSides) sides."
            }
        }
        
        class EquilateralTriangle: NamedShape {
            
            var sideLength: Double = 0.0
            init(sideLength: Double, name: String) {
                self.sideLength = sideLength
                super.init(name: name)
                numberOfSides = 3
            }
            
            var perimeter: Double {
                get {
                    return 3.0 * sideLength
                }
                set {
                    sideLength = newValue / 3.0
                }
            }
            
            var output: Double {
                get {
                    print("getter")
                    return 123;
                }
                set {
                    print("setter newValue :" + String(newValue))
                }
            }
            
            override func simpleDescription() -> String {
                return "An equilateral triagle with sides of length \(sideLength)."
            }
        }
        
        let triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
        print(triangle.perimeter)
        triangle.perimeter = 9.9
        print(triangle.sideLength)
        
        print(triangle.output)
        triangle.output = 9.9
    }
    
    //
    // MARK: demo19
    //
    
    func demo19() {
        
        class NamedShape {
            
            var numberOfSides: Int = 0
            var name: String
            
            init(name: String) {
                self.name = name
            }
            
            func simpleDescription() -> String {
                return "\(name) shape with \(numberOfSides) sides."
            }
        }
        
        class Square: NamedShape {
            
            var sideLength: Double
            
            init(sideLength: Double, name: String) {
                
                self.sideLength = sideLength
                super.init(name: name)
                numberOfSides = 4
            }
            
            func area() -> Double {
                return sideLength * sideLength
            }
            
            override func simpleDescription() -> String {
                return "A square with sides of length \(sideLength)."
            }
        }
        
        class EquilateralTriangle: NamedShape {
            
            var sideLength: Double = 0.0
            init(sideLength: Double, name: String) {
                self.sideLength = sideLength
                super.init(name: name)
                numberOfSides = 3
            }
            
            var perimeter: Double {
                get {
                    return 3.0 * sideLength
                }
                set {
                    sideLength = newValue / 3.0
                }
            }
            
            var output: Double {
                get {
                    print("getter")
                    return 123;
                }
                set {
                    print("setter newValue :" + String(newValue))
                }
            }
            
            override func simpleDescription() -> String {
                return "An equilateral triagle with sides of length \(sideLength)."
            }
        }
        
        class TriangleAndSquare {
            
            var triangle: EquilateralTriangle {
                willSet {
                    square.sideLength = newValue.sideLength
                }
            }
            
            var square: Square {
                willSet {
                    triangle.sideLength = newValue.sideLength
                }
            }
            
            init(size: Double, name: String) {
                square = Square(sideLength: size, name: name)
                triangle = EquilateralTriangle(sideLength: size, name: name)
            }
        }
        
        let triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
        print(triangleAndSquare.square.sideLength)
        triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
    }
    
    //
    // MARK: demo20
    //
    
    func demo20() {
        
        /*
         類中的方法和一般的函數有一個重要的區別，函數的參數名只在函數內部使用，但是方法的參數名需要在調用的時候顯式說明（除了第一個參數）。默認情況下，方法的參數名和它在方法內部的名字一樣，不過你也可以定義第二個名字，這個名字被用在方法內部。
         */
        
        class Counter {
            var count: Int = 0
            func incrementBy(amount unit: Int, numberOfTimes times: Int) {
                count += unit * times
            }
        }

        let counter = Counter()
        counter.incrementBy(amount: 2, numberOfTimes: 7)
    }
    
    //
    // MARK: demo21
    //
    
    func demo21() {
        
        /*
         枚舉和結構體
         使用enum來創建一個枚舉。就像類和其他所有命名類型一樣，枚舉可以包含方法。
         */
        
        enum Rank: Int {
            
            case Ace = 1
            case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
            case Jack, Queen, King
            
            func simpleDescription() -> String {
                
                switch self {
                case .Ace:
                    return "ace"
                case .Jack:
                    return "jack"
                case .Queen:
                    return "queen"
                case .King:
                    return "king"
                default:
                    return String(self.rawValue)
                }
            }
        }
        
        // 1
        print(Rank.Ace.rawValue)
        
        // 2
        print(Rank.Two.rawValue)
        
        // 11
        print(Rank.Jack.rawValue)

        // Ace
        if let aceRawValue = Rank(rawValue: 1) {
            print(aceRawValue)
        }
        
        // Two
        if let aceRawValue = Rank(rawValue: 2) {
            print(aceRawValue)
        }
        
        // Three
        if let aceRawValue = Rank(rawValue: 3) {
            print(aceRawValue)
        }
        
        // Enum method
        let king = Rank.King
        print(king.simpleDescription())
    }
    
    //
    // MARK: demo22
    //

    func demo22() {

        /*
         使用struct來創建一個結構體。結構體和類有很多相同的地方，比如方法和構造器。它們結構體之間最大的一個區別就是 結構體是傳值，類是傳引用。
         */
        
        enum Rank: Int {
            
            case Ace = 1
            case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
            case Jack, Queen, King
            
            func simpleDescription() -> String {
                
                switch self {
                case .Ace:
                    return "ace"
                case .Jack:
                    return "jack"
                case .Queen:
                    return "queen"
                case .King:
                    return "king"
                default:
                    return String(self.rawValue)
                }
            }
        }
        
        enum Suit {
            
            case Spades, Hearts, Diamonds, Clubs
            
            func simpleDescription() -> String {
                
                switch self {
                case .Spades:
                    return "spades"
                case .Hearts:
                    return "hearts"
                case .Diamonds:
                    return "diamonds"
                case .Clubs:
                    return "clubs"
                }
            }
        }
        
        struct Card {
            
            var rank: Rank
            var suit: Suit

            func simpleDescription() -> String {
                return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
            }
        }
        
        let threeOfSpades = Card(rank: .Three, suit: .Spades)
        let threeOfSpadesDescription = threeOfSpades.simpleDescription()
        print(threeOfSpadesDescription)
    }
    
    //
    // MARK: demo23
    //
    
    func demo23() {
        
        /*
         一個枚舉成員的實例可以有實例值。相同枚舉成員的實例可以有不同的值。創建實例的時候傳入值即可。實例值和原始值是不同的：枚舉成員的原始值對於所有實例都是相同的，而且你是在定義枚舉的時候設置原始值。
         
         例如，考慮從服務器獲取日出和日落的時間。服務器會返回正常結果或者錯誤信息。
        */
        
        enum ServerResponse {
            case Result(String, String)
            case Error(String)
        }

        let success = ServerResponse.Result("6:00 am", "8:09 pm")
        
        // if case let 指令
        switch success {
            case let .Result(sunrise, sunset):
                let serverResponse = "Sunrise is at \(sunrise) and sunset is at \(sunset)."
                print(serverResponse)
            default: ()
        }
        
        // if case let 指令
        if case let .Result(sunrise, sunset) = success {
            let serverResponse = "Sunrise is at \(sunrise) and sunset is at \(sunset)."
            print(serverResponse)
        }
        
        // if case 指令
        if case .Result = success {
            print("Result")
        }
        
        // 其他
    }
    
    //
    // MARK: demo24
    //
   
    func demo24() {
        
        /*
         接口和擴展
         使用protocol來聲明一個接口。
 
         protocol ExampleProtocol {
             var simpleDescription: String
             mutating func adjust()
         }
         */
        
        /*
         類、枚舉和結構體都可以實現接口。
         */

        class SimpleClass: ExampleProtocol {
        
            var simpleDescription: String = "A very simple class."
            var anotherProperty: Int = 69105
            
            func adjust() {
                simpleDescription += " Now 100% adjusted."
            }
        }
        
        let a = SimpleClass()
        a.adjust()
        
        a.simpleDescription = "b"
        let aDescription = a.simpleDescription
        print(aDescription)
        
        struct SimpleStructure: ExampleProtocol {
            var simpleDescription: String = "A simple structure"
            mutating func adjust() {
                simpleDescription += " (adjusted)"
            }
        }
        
        var b = SimpleStructure()
        b.adjust()
        
        let bDescription = b.simpleDescription
        print(bDescription)
    }
    
    //
    // MARK: demo25
    //
    
    func demo25() {
        
        /*
         泛型
         在尖括號裡寫一個名字來創建一個泛型函數或者類型。
         */
        
        func repeatFunc<ItemType>(item: ItemType, times: Int) -> [ItemType] {
            
            var result = [ItemType]()
            for _ in 0...times {
                result.append(item)
            }
            return result
        }
        
        let stringResult = repeatFunc(item: "knock", times: 4)
        print(type(of: stringResult))
        print(stringResult)
        
        let intResult = repeatFunc(item: 100, times: 10)
        print(intResult)
        
        /*
         你也可以創建泛型類、枚舉和結構體。
         */
        
        // Reimplement the Swift standard library's optional type
        enum OptionalValue<T> {
            case None
            case Some(T)
        }

        var possibleInteger: OptionalValue<Int> = .None
        print(possibleInteger)
        
        possibleInteger = .Some(100)
        print(possibleInteger)

        /*
         在類型名後面使用where來指定一個需求列表——例如，要限定實現一個協議的類型，需要限定兩個類型要相同，或者限定一個類必須有一個特定的父類。
         */
        
        func anyCommonElements <T, U> (lhs: T, rhs: U) -> Bool
            where T: Sequence, U: Sequence, T.Iterator.Element: Equatable, T.Iterator.Element == U.Iterator.Element {
            
                for lhsItem in lhs {
                    for rhsItem in rhs {
                        if lhsItem == rhsItem {
                            return true
                        }
                    }
                }
                return false
        }
        
        let result = anyCommonElements(lhs: [1, 2, 3], rhs: [3])
        print(result)
    }
    
    //
    // MARK: demo26
    //
    
    func demo26() {
        
        /*
         使用extension來為現有的類型添加功能，比如添加一個計算屬性的方法。你可以使用擴展來給任意類型添加協議，甚至是你從外部庫或者框架中導入的類型。
         */
        let result = 7.simpleDescription
        print(result)
        
        /*
         你可以像使用其他命名類型一樣使用接口名——例如，創建一個有不同類型但是都實現一個接口的對象集合。當你處理類型是接口的值時，接口外定義的方法不可用。
         */
        
        // let protocolValue: ExampleProtocol  // protocolValue.anotherProperty
        // protocolValue.simpleDescription  // Uncomment to see the error
        
        /*
         即使protocolValue變量運行時的類型是simpleClass，編譯器會把它的類型當做ExampleProtocol。這表示你不能調用類在它實現的接口之外實現的方法或者屬性。
         */
    }
}
