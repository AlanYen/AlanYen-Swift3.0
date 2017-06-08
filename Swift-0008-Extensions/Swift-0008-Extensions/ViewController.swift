//
//  ViewController.swift
//  Swift-0008-Extensions
//
//  Created by Alan Yen on 2017/6/8.
//  Copyright © 2017年 Alan-App. All rights reserved.
//

import UIKit

// Double
extension Double {
    var km: Double { return self * 1_000.0 }
    var  m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

// Rect
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

// Int
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

extension Int {
    mutating func square() {
        self = self * self
    }
}

extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Extensions add new functionality to an existing 
        // class, structure, enumeration, or protocol type. 
        // This includes the ability to extend types for which you do not have access to the original source code 
        // (known as retroactive modeling). 
        // Extensions are similar to categories in Objective-C.
        // (Unlike Objective-C categories, Swift extensions do not have names.)
        
        // Extensions in Swift can:
        // Add computed instance properties and computed type properties
        // Define instance methods and type methods
        // Provide new initializers
        // Define subscripts
        // Define and use new nested types
        // Make an existing type conform to a protocol

        // Extensions can add new functionality to a type, but they cannot override existing functionality.
        
        title = "Extensions"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            extensionSyntax()
        }
        else if indexPath.row == 1 {
            computedProperties()
        }
        else if indexPath.row == 2 {
            initializers()
        }
        else if indexPath.row == 3 {
            methods()
        }
        else if indexPath.row == 4 {
            mutatingInstanceMethods()
        }
        else if indexPath.row == 5 {
            subscripts()
        }
        else if indexPath.row == 6 {
            nestedTypes()
        }
    }
    
    func extensionSyntax() {
        
        // Declare extensions with the extension keyword:
        
        /*
        extension SomeType {
            // new functionality to add to SomeType goes here
        }
         */
        
        /*
        extension SomeType: SomeProtocol, AnotherProtocol {
            // implementation of protocol requirements goes here
        }
         */
    }
    
    func computedProperties() {
    
        let oneInch = 25.4.mm
        print("One inch is \(oneInch) meters")
        // Prints "One inch is 0.0254 meters"
        
        let threeFeet = 3.ft
        print("Three feet is \(threeFeet) meters")
        // Prints "Three feet is 0.914399970739201 meters"
        
        // Extensions can add new computed properties, 
        // but they cannot add stored properties, 
        // or add property observers to existing properties.
    }
    
    func initializers() {
     
        // Extensions can add new convenience initializers to a class, 
        // but they cannot add new designated initializers or deinitializers to a class. 
        // Designated initializers and deinitializers must always be provided 
        // by the original class implementation.
        
        // Because the Rect structure provides default values for all of its properties, 
        // it receives a default initializer and a memberwise initializer automatically, 

        let defaultRect = Rect()
        print(defaultRect)
        
        let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                                  size: Size(width: 5.0, height: 5.0))
        print(memberwiseRect)
        
        let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                              size: Size(width: 3.0, height: 3.0))
        print(centerRect)
        // centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)
    }
    
    func methods() {
        
        // Extensions can add new instance methods and 
        // type methods to existing types. 
        // The following example adds a new instance method called 
        // repetitions to the Int type:
        
        3.repetitions {
            print("Hello!")
        }
        // Hello!
        // Hello!
        // Hello!
        
        4.repetitions(task: {
            print("Hello!")
        })
        // Hello!
        // Hello!
        // Hello!
        // Hello!
    }
    
    func mutatingInstanceMethods() {
        
        var someInt = 3
        print(someInt)
        
        someInt.square()
        print(someInt)
        // someInt is now 9
    }
    
    func subscripts() {
     
        print(746381295[0])
        // returns 5
        print(746381295[1])
        // returns 9
        print(746381295[2])
        // returns 2
        print(746381295[8])
        // returns 7
    }
    
    func nestedTypes() {
        
        // This function, printIntegerKinds(_:), takes an input array of Int values 
        // and iterates over those values in turn. For each integer in the array, 
        // the function considers the kind computed property for that integer, 
        // and prints an appropriate description.
        func printIntegerKinds(_ numbers: [Int]) {
            for number in numbers {
                
                // number.kind is already known to be of type Int.Kind.
                // Because of this, all of the Int.Kind case values can be written
                // in shorthand form inside the switch statement,
                // such as .negative rather than Int.Kind.negative.
                switch number.kind {
                case .negative:
                    print("- ", terminator: "")
                case .zero:
                    print("0 ", terminator: "")
                case .positive:
                    print("+ ", terminator: "")
                }
            }
            print("")
        }
        printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
        // Prints "+ + - 0 - 0 + "
    }
}
