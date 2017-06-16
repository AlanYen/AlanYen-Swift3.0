//
//  ViewController.swift
//  Swift-0011-Initialization
//
//  Created by Alan Yen on 2017/6/15.
//  Copyright © 2017年 Alan-App. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialization is the process of preparing an instance of a class, structure, or enumeration for use.
        
        // Classes and structures must set all of their stored properties to an appropriate initial value 
        // by the time an instance of that class or structure is created. 
        // Stored properties cannot be left in an indeterminate state.
        
        title = "Initialization"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            initializers()
        }
        else if indexPath.row == 1 {
            syntaxForDesignatedAndConvenienceInitializers()
        }
        else if indexPath.row == 2 {
            twoPhaseInitialization()
        }
        else if indexPath.row == 3 {
            designatedAndConvenienceInitializersInAction()
        }
        else if indexPath.row == 4 {
            failableInitializersForEnumerationsWithRawValues()
        }
        else if indexPath.row == 5 {
            propagationOfInitializationFailure()
        }
        else if indexPath.row == 6 {
            overridingAFailableInitializer()
        }
        else if indexPath.row == 7 {
            theInitExclamationMarkFailableInitializer()
        }
        else if indexPath.row == 8 {
            requiredInitializers()
        }
        else if indexPath.row == 9 {
            settingADefaultPropertyValueWithAClosureOrFunction()
        }
    }

    func initializers() {
        
        // Initializers are called to create a new instance of a particular type. 
        // In its simplest form, an initializer is like an instance method with no parameters, written using the init keyword:
        
        /*
        init() {
            // perform some initialization here
        }
         */
        
        struct Fahrenheit {
            var temperature: Double
            init() {
                temperature = 32.0
            }
        }
        
        /*
        struct Fahrenheit {
            var temperature: Double = 32.0
        }
         */
        
        let f = Fahrenheit()
        print("The default temperature is \(f.temperature)° Fahrenheit")
        // Prints "The default temperature is 32.0° Fahrenheit"
    }
    
    func syntaxForDesignatedAndConvenienceInitializers() {
    
        // Designated initializers for classes are written in the same way as simple initializers for value types:
        
        /*
        init(parameters) {
            
            statements
            
        }
         */
        
        // Convenience initializers are written in the same style, but with the convenience modifier placed before the init keyword, separated by a space:
        
        /*
        convenience init(parameters) {
            
            statements
            
        }
         */
        
        // To simplify the relationships between designated and convenience initializers, Swift applies the following three rules for delegation calls between initializers:
        
        // Rule 1
        // A designated initializer must call a designated initializer from its immediate superclass.
        
        // Rule 2
        // A convenience initializer must call another initializer from the same class.
        
        // Rule 3
        // A convenience initializer must ultimately call a designated initializer.
        
        // A simple way to remember this is:
        // Designated initializers must always delegate up.
        // Convenience initializers must always delegate across.
    }
    
    func twoPhaseInitialization() {
        
        // Swift’s compiler performs four helpful safety-checks to make sure that two-phase initialization is completed without error:
        
        // Safety check 1
        
        // A designated initializer must ensure that all of the properties introduced by its class are initialized before it delegates up to a superclass initializer.
        
        // As mentioned above, the memory for an object is only considered fully initialized once the initial state of all of its stored properties is known. 
        // In order for this rule to be satisfied, a designated initializer must make sure that all of its own properties are initialized before it hands off up the chain.
        
        // Safety check 2
        
        // A designated initializer must delegate up to a superclass initializer before assigning a value to an inherited property. If it doesn’t, the new value the designated initializer assigns will be overwritten by the superclass as part of its own initialization.

        // Safety check 3
        
        // A convenience initializer must delegate to another initializer before assigning a value to any property (including properties defined by the same class). If it doesn’t, the new value the convenience initializer assigns will be overwritten by its own class’s designated initializer.
        
        // Safety check 4
        
        // An initializer cannot call any instance methods, read the values of any instance properties, or refer to self as a value until after the first phase of initialization is complete.
        
        // The class instance is not fully valid until the first phase ends. Properties can only be accessed, and methods can only be called, once the class instance is known to be valid at the end of the first phase.
        
        
        // Phase 1
        
        // A designated or convenience initializer is called on a class.
        
        // Memory for a new instance of that class is allocated. The memory is not yet initialized.
        
        // A designated initializer for that class confirms that all stored properties introduced by that class have a value. The memory for these stored properties is now initialized.
        
        // The designated initializer hands off to a superclass initializer to perform the same task for its own stored properties.
        
        // This continues up the class inheritance chain until the top of the chain is reached.
        
        // Once the top of the chain is reached, and the final class in the chain has ensured that all of its stored properties have a value, the instance’s memory is considered to be fully initialized, and phase 1 is complete.
        
        // Phase 2
        
        // Working back down from the top of the chain, each designated initializer in the chain has the option to customize the instance further. Initializers are now able to access self and can modify its properties, call its instance methods, and so on.
        
        // Finally, any convenience initializers in the chain have the option to customize the instance and to work with self.
    }
    
    func designatedAndConvenienceInitializersInAction() {
    
        class Food {
            var name: String
            init(name: String) {
                self.name = name
            }
            convenience init() {
                self.init(name: "[Unnamed]")
            }
        }
        
        let namedMeat = Food(name: "Bacon")
        print(namedMeat.name)
        // namedMeat's name is "Bacon"
        
        let mysteryMeat = Food()
        print(mysteryMeat.name)
        // mysteryMeat's name is "[Unnamed]"
        
        class RecipeIngredient: Food {
            var quantity: Int
            init(name: String, quantity: Int) {
                self.quantity = quantity
                super.init(name: name)
            }
            override convenience init(name: String) {
                self.init(name: name, quantity: 1)
            }
        }
        
        let oneMysteryItem = RecipeIngredient()
        print(oneMysteryItem.name)
        let oneBacon = RecipeIngredient(name: "Bacon")
        print(oneBacon.name)
        let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
        print(sixEggs.name)
        
        // Because it provides a default value for all of the properties it introduces 
        // and does not define any initializers itself, 
        // ShoppingListItem automatically inherits all of the designated
        // and convenience initializers from its superclass.
        class ShoppingListItem: RecipeIngredient {
            var purchased = false
            var description: String {
                var output = "\(quantity) x \(name)"
                output += purchased ? " ✔" : " ✘"
                return output
            }
        }
        
        var breakfastList = [
            ShoppingListItem(),
            ShoppingListItem(name: "Bacon"),
            ShoppingListItem(name: "Eggs", quantity: 6),
            ]
        breakfastList[0].name = "Orange juice"
        breakfastList[0].purchased = true
        for item in breakfastList {
            print(item.description)
        }
        // 1 x Orange juice ✔
        // 1 x Bacon ✘
        // 6 x Eggs ✘
    }
    
    func failableInitializers() {
        
        // It is sometimes useful to define a class, structure, 
        // or enumeration for which initialization can fail. 
        // This failure might be triggered by invalid initialization parameter values, 
        // the absence of a required external resource, 
        // or some other condition that prevents initialization from succeeding.
        
        let wholeNumber: Double = 12345.0
        let pi = 3.14159
        
        if let valueMaintained = Int(exactly: wholeNumber) {
            print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
        }
        // Prints "12345.0 conversion to Int maintains value of 12345"
        
        let valueChanged = Int(exactly: pi)
        // valueChanged is of type Int?, not Int
        
        if valueChanged == nil {
            print("\(pi) conversion to Int does not maintain value")
        }
        // Prints "3.14159 conversion to Int does not maintain value"
        
        struct Animal {
            let species: String
            init?(species: String) {
                if species.isEmpty { return nil }
                self.species = species
            }
        }
        
        let someCreature = Animal(species: "Giraffe")
        // someCreature is of type Animal?, not Animal
        
        if let giraffe = someCreature {
            print("An animal was initialized with a species of \(giraffe.species)")
        }
        // Prints "An animal was initialized with a species of Giraffe"
        
        // If you pass an empty string value to the failable initializer’s species parameter, 
        // the initializer triggers an initialization failure:
        
        let anonymousCreature = Animal(species: "")
        // anonymousCreature is of type Animal?, not Animal
        
        if anonymousCreature == nil {
            print("The anonymous creature could not be initialized")
        }
        // Prints "The anonymous creature could not be initialized"
    }
    
    func failableInitializersForEnumerations() {
    
        // You can use a failable initializer to select an appropriate enumeration case based on one or more parameters. 
        // The initializer can then fail if the provided parameters 
        // do not match an appropriate enumeration case.
        
        enum TemperatureUnit {
            case kelvin, celsius, fahrenheit
            init?(symbol: Character) {
                switch symbol {
                case "K":
                    self = .kelvin
                case "C":
                    self = .celsius
                case "F":
                    self = .fahrenheit
                default:
                    return nil
                }
            }
        }
        
        let fahrenheitUnit = TemperatureUnit(symbol: "F")
        if fahrenheitUnit != nil {
            print("This is a defined temperature unit, so initialization succeeded.")
        }
        // Prints "This is a defined temperature unit, so initialization succeeded."
        
        let unknownUnit = TemperatureUnit(symbol: "X")
        if unknownUnit == nil {
            print("This is not a defined temperature unit, so initialization failed.")
        }
        // Prints "This is not a defined temperature unit, so initialization failed."
    }
    
    func failableInitializersForEnumerationsWithRawValues() {
    
        // Enumerations with raw values automatically receive a failable initializer, init?(rawValue:), 
        // that takes a parameter called rawValue of the appropriate raw-value type and selects a matching enumeration case 
        // if one is found, or triggers an initialization failure if no matching value exists.
        
        enum TemperatureUnit: Character {
            case kelvin = "K", celsius = "C", fahrenheit = "F"
        }
        
        let fahrenheitUnit = TemperatureUnit(rawValue: "F")
        if fahrenheitUnit != nil {
            print("This is a defined temperature unit, so initialization succeeded.")
        }
        // Prints "This is a defined temperature unit, so initialization succeeded."
        
        let unknownUnit = TemperatureUnit(rawValue: "X")
        if unknownUnit == nil {
            print("This is not a defined temperature unit, so initialization failed.")
        }
        // Prints "This is not a defined temperature unit, so initialization failed."
    }
    
    func propagationOfInitializationFailure() {
    
        // A failable initializer of a class, structure, or enumeration can 
        // delegate across to another failable initializer from the same class, structure, or enumeration. 
        // Similarly, a subclass failable initializer can delegate up to a superclass failable initializer.
        
        class Product {
            let name: String
            init?(name: String) {
                if name.isEmpty { return nil }
                self.name = name
            }
        }
        
        class CartItem: Product {
            let quantity: Int
            init?(name: String, quantity: Int) {
                if quantity < 1 { return nil }
                self.quantity = quantity
                super.init(name: name)
            }
        }
        
        // Success
        if let twoSocks = CartItem(name: "sock", quantity: 2) {
            print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
        }
        // Prints "Item: sock, quantity: 2"

        // Fail
        if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
            print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
        } else {
            print("Unable to initialize zero shirts")
        }
        // Prints "Unable to initialize zero shirts"
        
        // Fail
        if let oneUnnamed = CartItem(name: "", quantity: 1) {
            print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
        } else {
            print("Unable to initialize one unnamed product")
        }
        // Prints "Unable to initialize one unnamed product"
    }
    
    func overridingAFailableInitializer() {
    
        // You can override a superclass failable initializer in a subclass,
        // just like any other initializer. 
        // Alternatively, you can override a superclass failable initializer 
        // with a subclass nonfailable initializer. 
        // This enables you to define a subclass for which initialization 
        // cannot fail, even though initialization of the superclass is allowed to fail.
        
        // You can override a failable initializer with a nonfailable initializer but not the other way around. 
        
        class Document {
            var name: String?
            // this initializer creates a document with a nil name value
            init() {}
            // this initializer creates a document with a nonempty name value
            init?(name: String) {
                if name.isEmpty { return nil }
                self.name = name
            }
        }
        
        class AutomaticallyNamedDocument: Document {
            override init() {
                super.init()
                self.name = "[Untitled]"
            }
            override init(name: String) {
                super.init()
                if name.isEmpty {
                    self.name = "[Untitled]"
                } else {
                    self.name = name
                }
            }
        }
        
        // You can use forced unwrapping in an initializer to call a failable initializer 
        // from the superclass as part of the implementation of a subclass’s nonfailable initializer. 
        // For example, the UntitledDocument subclass below is always named "[Untitled]", 
        // and it uses the failable init(name:) initializer from its superclass during initialization.
        
        class UntitledDocument: Document {
            override init() {
                super.init(name: "[Untitled]")!
            }
        }
        
        // In this case, if the init(name:) initializer of the superclass were ever called with an empty string as the name, 
        // the forced unwrapping operation would result in a runtime error.
        // However, because it’s called with a string constant, 
        // you can see that the initializer won’t fail, 
        // so no runtime error can occur in this case.
    }
    
    func theInitExclamationMarkFailableInitializer() {
    
        // You typically define a failable initializer that creates an optional instance of the appropriate type by placing a question mark after the init keyword (init?). 
        // Alternatively, you can define a failable initializer that creates an implicitly unwrapped optional instance of the appropriate type. 
        // Do this by placing an exclamation mark after the init keyword (init!) instead of a question mark.
    
        // You can delegate from init? to init! and vice versa, 
        // and you can override init? with init! and vice versa. 
        // You can also delegate from init to init!, 
        // although doing so will trigger an assertion if the init! initializer causes initialization to fail.
    }
    
    func requiredInitializers() {
        
        // Write the required modifier before the definition of a class initializer to indicate that every subclass of the class must implement that initializer:
        
        class SomeClass {
            required init() {
                // initializer implementation goes here
            }
        }
        
        // You must also write the required modifier before every subclass implementation of a required initializer, 
        // to indicate that the initializer requirement applies to further subclasses in the chain. 
        // You do not write the override modifier when overriding a required designated initializer:
        
        class SomeSubclass: SomeClass {
            required init() {
                // subclass implementation of the required initializer goes here
            }
        }
    }
    
    func settingADefaultPropertyValueWithAClosureOrFunction() {
    
        // If a stored property’s default value requires some customization or setup, 
        // you can use a closure or global function to provide a customized default value for that property. 
        // Whenever a new instance of the type that the property belongs to is initialized, 
        // the closure or function is called, and its return value is assigned as the property’s default value.
        
        struct Chessboard {
            let boardColors: [Bool] = {
                var temporaryBoard = [Bool]()
                var isBlack = false
                for i in 1...8 {
                    for j in 1...8 {
                        temporaryBoard.append(isBlack)
                        isBlack = !isBlack
                    }
                    isBlack = !isBlack
                }
                return temporaryBoard
            }()
            func squareIsBlackAt(row: Int, column: Int) -> Bool {
                return boardColors[(row * 8) + column]
            }
        }
        
        let board = Chessboard()
        print(board.squareIsBlackAt(row: 0, column: 1))
        // Prints "true"
        print(board.squareIsBlackAt(row: 7, column: 7))
        // Prints "false"
    }
}
