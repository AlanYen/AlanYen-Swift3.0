//
//  ViewController.swift
//  Swift-0003-Enumerations
//
//  Created by AlanYen on 2017/5/17.
//  Copyright © 2017年 Alan-App. All rights reserved.
//

import UIKit

// protocol "CustomStringConvertible"
protocol CustomStringConvertible {
    // 該協議只有一個要求，即一個只讀(getter)類型的字符串(String類型)。
    var description: String { get }
}

protocol AccountCompatible {
    var remainingFunds: Int { get }
    mutating func addFunds(amount: Int) throws
    mutating func removeFunds(amount: Int) throws
}

enum AccountError: Error {
    case Overdraft(amount: Int)
}

enum Account {
    case Empty
    case Funds(remaining: Int)
    
    var remainingFunds: Int {
        switch self {
        case .Empty:
            return 0
        case .Funds(let remaining):
            return remaining
        }
    }
}

extension Account: AccountCompatible {
    
    mutating func addFunds(amount: Int) throws {
        var newAmount = amount
        if case let .Funds(remaining) = self {
            newAmount += remaining
        }
        if newAmount < 0 {
            throw AccountError.Overdraft(amount: -newAmount)
        } else if newAmount == 0 {
            self = .Empty
        } else {
            self = .Funds(remaining: newAmount)
        }
    }
    
    mutating func removeFunds(amount: Int) throws {
        try self.addFunds(amount: amount * -1)
    }
}

extension AccountError: CustomStringConvertible {
    var description: String {
        switch self {
        case .Overdraft(let amount): return "Overdraft \(amount)"
        }
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Swift 3.0 開始,定義枚舉值,統一小寫
        
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func demo01() {
        
        enum CompassPoint: Int {
            case north
            case south
            case east
            case west
            
            private static let _count: CompassPoint.RawValue = {
                // find the maximum enum value
                var maxValue: Int = 0
                while let _ = CompassPoint(rawValue: maxValue) {
                    maxValue += 1
                }
                return maxValue
            }()
            
            static func randomCompassPoint() -> CompassPoint {
                // pick and return a new value
                let rand = Int(arc4random_uniform(UInt32(_count)))
                return CompassPoint(rawValue: rand)!
            }
        }
        
        let printSwitchResult = { (direction: CompassPoint) -> Void in

            switch direction {
            case .north:
                print("Lots of planets have a north")
            case .south:
                print("Watch out for penguins")
            case .east:
                print("Where the sun rises")
            case .west:
                print("Where the skies are blue")
            }
            // Prints "Watch out for penguins"
        }
        
        var directionToHead = CompassPoint.west
        print(directionToHead)
        printSwitchResult(directionToHead)
        
        directionToHead = .east
        print(directionToHead)
        printSwitchResult(directionToHead)
        
        directionToHead = .north
        print(directionToHead)
        printSwitchResult(directionToHead)

        directionToHead = .south
        print(directionToHead)
        printSwitchResult(directionToHead)
        
        // Warning: "Switch condition evaluates to a constant"
        switch CompassPoint.randomCompassPoint() {
        case .north:
            print("Lots of planets have a north")
        case .south:
            print("Watch out for penguins")
        case .east:
            print("Where the sun rises")
        case .west:
            print("Where the skies are blue")
        }
        // Prints "Watch out for penguins"
        
        if let b = CompassPoint(rawValue: 3) {
            print(b)
        }
    }
    
    func demo02() {
        
        //
        // Associated Values
        //
        
        enum Barcode {
            case upc(Int, Int, Int, Int)
            case qrCode(String)
        }
        
        let switchClosure_1 = { (code: Barcode) -> Void in
        
            switch code {
            case .upc(let numberSystem, let manufacturer, let product, let check):
                print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
                
            case .qrCode(let productCode):
                print("QR code: \(productCode).")
            }
        }
        
        let switchClosure_2 = { (code: Barcode) -> Void in
            
            switch code {
            case let .upc(numberSystem, manufacturer, product, check):
                print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
                
            case let .qrCode(productCode):
                print("QR code: \(productCode).")
            }
        }

        
        var productBarcode = Barcode.upc(8, 85909, 51226, 3)
        print(productBarcode)
        switchClosure_1(productBarcode)
        switchClosure_2(productBarcode)
        
        productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
        print(productBarcode)
        switchClosure_1(productBarcode)
        switchClosure_2(productBarcode)
        
        if case let .upc(numberSystem, manufacturer, product, check) = productBarcode {
            print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
        }
    }
    
    func demo03() {
        
        //
        // Raw Values
        // Raw values can be strings, characters, or any of the integer or floating-point number types. 
        // Each raw value must be unique within its enumeration declaration.
        //
        
        enum ASCIIControlCharacter: Character {
            case tab = "\t"
            case lineFeed = "\n"
            case carriageReturn = "\r"
        }
        print(ASCIIControlCharacter.tab)
        print(ASCIIControlCharacter.lineFeed)
        print(ASCIIControlCharacter.carriageReturn)
        
        enum Planet: Int {
            case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
        }
        print(Planet.mercury)
        print(Planet.mercury.rawValue)
        
        enum CompassPoint: String {
            case north, south, east, west
        }
        print(CompassPoint.north)
        print(CompassPoint.north.rawValue)

        //
        // Initializing from a Raw Value
        //
        let possiblePlanet = Planet(rawValue: 7)
        print(type(of: possiblePlanet))
        
        print(possiblePlanet as Any)
        print(possiblePlanet?.rawValue as Any)
        // possiblePlanet is of type Planet? and equals Planet.uranus
        
        let positionToFind = 11
        if let somePlanet = Planet(rawValue: positionToFind) {
            switch somePlanet {
            case .earth:
                print("Mostly harmless")
            default:
                print("Not a safe place for humans")
            }
        } else {
            print("There isn't a planet at position \(positionToFind)")
        }
        // Prints "There isn't a planet at position 11"
    }
    
    func demo04() {
        
        //
        // Implicitly Assigned Raw Values
        // When you’re working with enumerations that store integer or string raw values, you don’t have to 
        // explicitly assign a raw value for each case. When you don’t, Swift will automatically assign the 
        // values for you.
        
        enum Planet: Int {
            case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
        }
        
        enum CompassPoint: String {
            case north, south, east, west
        }
        
        let earthsOrder = Planet.earth.rawValue
        print(earthsOrder)
        // earthsOrder is 3
        
        let sunsetDirection = CompassPoint.west.rawValue
        print(sunsetDirection)
        // sunsetDirection is "west"
    }
    
    func demo05() {
        
        //
        // Initializing from a Raw Value
        // The raw value initializer is a failable initializer,
        // because not every raw value will return an enumeration case. 
        // For more information, see Failable Initializers.
        
        enum Planet: Int {
            case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
        }
        
        let possiblePlanet1 = Planet(rawValue: 7)
        print(possiblePlanet1 ?? -1)
        
        let possiblePlanet2 = Planet(rawValue: 11117)
        print(possiblePlanet2 ?? -1)

        // In the example above, possiblePlanet is of type Planet?, or “optional Planet.”
        // possiblePlanet is of type Planet? and equals Planet.uranus
        
        let positionToFind = 11
        if let somePlanet = Planet(rawValue: positionToFind) {
            switch somePlanet {
            case .earth:
                print("Mostly harmless")
            default:
                print("Not a safe place for humans")
            }
        }
        else {
            print("There isn't a planet at position \(positionToFind)")
        }
        // Prints "There isn't a planet at position 11"
    }
    
    func demo06() {
        
        // Int 設置枚舉值的類型
        enum Rank: Int {
            // 定義枚舉值設置值
            case ace
            // 可以case 後面一次定義多個枚舉值
            case two, three, four, five, six, seven, eight, nine, ten
            case jack, queen, king
            
            // 定義函數 如果多人合作的時候,可以使用這個讓別人更加瞭解你定義的屬性的含義
            func simpleDescription() -> String {
                switch self { // self 就是這個枚舉本身
                case .ace:
                    return "ace1"
                case .jack:
                    return "jack1"
                case .queen:
                    return "queen1"
                case .king:
                    return "king1"
                default:
                    return String(self.rawValue)
                }
            } 
        }
        
        let aRank = Rank.ace
        print(aRank.simpleDescription())
    }
    
    func demo07() {
        
        // 元組參數(Tuple as Arguments)
        // 更重要的是,Swift內部相關信息其實是一個元組,所以你可以像下面這樣做:

        enum Trade {
            case Buy(stock: String, amount: Int)
            case Sell(stock: String, amount: Int)
        }
        
        // let tp = (stock: "TSLA", amount: 100)
        // let trade = Trade.Sell(tp)
        // Swift3 移除
        let trade = Trade.Sell(stock: "TSLA", amount: 100)
        
        if case let Trade.Sell(stock, amount) = trade {
            print("buy \(amount) of \(stock)")
        }
        // Prints: "buy 100 of TSLA"
    }
    
    func demo08() {
        
        //
        // 可變方法(Mutating Methods)
        // 方法可以聲明為 mutating。
        // 這樣就允許改變隱藏參數 self 的 case 值了。
        //
        
        enum TriStateSwitch {
            case off, low, high
            mutating func next() {
                switch self {
                case .off:
                    self = .low
                case .low:
                    self = .high
                case .high:
                    self = .off
                }
            }
        }
        var ovenLight = TriStateSwitch.low
        print(ovenLight)
        ovenLight.next() // ovenLight 現在等於.On
        print(ovenLight)
        ovenLight.next() // ovenLight 現在等於.Off
        print(ovenLight)
    }
    
    func demo09() {
        
        //
        // 協議(Protocols)
        // 已經提及了structs和enums之間的相似性。除了附加方法的能力之外，
        // Swift也允許你在枚舉中使用協議(Protocols)和協議擴展(Protocol Extension)。
        //
        
        enum Trade: CustomStringConvertible {
            case buy, sell
            var description: String {
                switch self {
                case .buy: return "We're buying something"
                case .sell: return "We're selling something"
                }
            }
        }
        
        let action = Trade.buy
        print("this action is \(action)")
        print("this action is \(action.description)")
        // prints: this action is We're buying something
    }
    
    func demo10() {
        
        var account = Account.Funds(remaining: 20)
        do {
            try account.addFunds(amount: 10)
        } catch AccountError.Overdraft(let amount) {
            print(amount)
        } catch {
            print("Default Error")
        }
        
        do {
            try account.removeFunds(amount: 100)
        } catch let error as AccountError {
            print("AccountError: \(error.description)")
        } catch {
            print("Default Error")
        }
        
        // prints:
        // : add:  Optional(())
        // : remove 1:  Optional(())
        // : remove 2:  nil
    }
}

