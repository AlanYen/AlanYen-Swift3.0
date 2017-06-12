//
//  ViewController.swift
//  Swift-0010-ClassesAndStructures
//
//  Created by Alan Yen on 2017/6/12.
//  Copyright © 2017年 Alan-App. All rights reserved.
//

import UIKit

// Resolution
struct Resolution {
    var width = 0
    var height = 0
}

// VideoMode
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Classes and structures are general-purpose, flexible constructs 
        // that become the building blocks of your program’s code. 
        // You define properties and methods to add functionality to your classes and structures 
        // by using exactly the same syntax as for constants, variables, and functions.
        
        title = "Classes and Structures"
        
        // An instance of a class is traditionally known as an object. 
        // However, Swift classes and structures are much closer in functionality than in other languages, 
        // and much of this chapter describes functionality 
        // that can apply to instances of either a class or a structure type. 
        // Because of this, the more general term instance is used.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            comparingClassesAndStructures()
        }
        else if indexPath.row == 1 {
            definitionSyntax()
        }
        else if indexPath.row == 2 {
            accessingProperties()
        }
        else if indexPath.row == 3 {
            memberwiseInitializersForStructureTypes()
        }
        else if indexPath.row == 4 {
            structuresAndEnumerationsAreValueTypes()
        }
        else if indexPath.row == 5 {
            classesAreReferenceTypes()
        }
        else if indexPath.row == 6 {
            identityOperators()
        }
        else if indexPath.row == 7 {
            choosingBetweenClassesAndStructures()
        }
        else if indexPath.row == 8 {
            assignmentAndCopyBehaviorForStringsArraysAndDictionaries()
        }
    }
    
    func comparingClassesAndStructures() {
        
        // Classes and structures in Swift have many things in common. 
        // Both can:
        
        print("Define properties to store values")
        print("Define methods to provide functionality")
        print("Define subscripts to provide access to their values using subscript syntax")
        print("Define initializers to set up their initial state")
        print("Be extended to expand their functionality beyond a default implementation")
        print("Conform to protocols to provide standard functionality of a certain kind")
        
        // Classes have additional capabilities that structures do not:
        print("Inheritance enables one class to inherit the characteristics of another.")
        print("Type casting enables you to check and interpret the type of a class instance at runtime.")
        print("Deinitializers enable an instance of a class to free up any resources it has assigned.")
        print("Reference counting allows more than one reference to a class instance.")
    }
    
    func definitionSyntax() {
        
        // Classes and structures have a similar definition syntax.
        /*
        class SomeClass {
            // class definition goes here
        }
        struct SomeStructure {
            // structure definition goes here
        }
         */
        
        let someResolution = Resolution()
        print(type(of: someResolution))
        print(someResolution)

        let someVideoMode = VideoMode()
        print(type(of: someVideoMode))
        print(someResolution)
    }
    
    func accessingProperties() {
        
        // You can access the properties of an instance using dot syntax. 
        // In dot syntax, you write the property name immediately after the instance name, 
        // separated by a period (.), without any spaces:
        
        let someResolution = Resolution()
        let someVideoMode = VideoMode()
        
        print("The width of someResolution is \(someResolution.width)")
        // Prints "The width of someResolution is 0"
        
        print("The width of someVideoMode is \(someVideoMode.resolution.width)")
        // Prints "The width of someVideoMode is 0"
        
        // You can also use dot syntax to assign a new value to a variable property:
        
        someVideoMode.resolution.width = 1280
        print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
        // Prints "The width of someVideoMode is now 1280"
    }
    
    func memberwiseInitializersForStructureTypes() {
    
        // All structures have an automatically-generated memberwise initializer, 
        // which you can use to initialize the member properties of new structure instances. 
        // Initial values for the properties of the new instance can be passed to the memberwise initializer by name:
        
        let vga = Resolution(width: 640, height: 480)
        print(vga)
    }
    
    func structuresAndEnumerationsAreValueTypes() {
        
        // A value type is a type whose value is copied when it is assigned to a variable or constant, 
        // or when it is passed to a function.
        
        let hd = Resolution(width: 1920, height: 1080)
        var cinema = hd
        
        cinema.width = 2048
        
        // Checking the width property of cinema shows that it has indeed changed to be 2048:
        
        print("cinema is now \(cinema.width) pixels wide")
        // Prints "cinema is now 2048 pixels wide"
        
        // However, the width property of the original hd instance still has the old value of 1920:
        
        print("hd is still \(hd.width) pixels wide")
        // Prints "hd is still 1920 pixels wide"
        
        // The same behavior applies to enumerations:
        enum CompassPoint {
            case north, south, east, west
        }
        var currentDirection = CompassPoint.west
        let rememberedDirection = currentDirection
        currentDirection = .east
        if rememberedDirection == .west {
            print("The remembered direction is still .west")
        }
        // Prints "The remembered direction is still .west"
    }
    
    func classesAreReferenceTypes() {
        
        // Unlike value types, reference types are not copied when they are assigned to a variable or constant, 
        // or when they are passed to a function. 
        // Rather than a copy, a reference to the same existing instance is used instead.
        
        let hd = Resolution(width: 1920, height: 1080)
        let tenEighty = VideoMode()
        tenEighty.resolution = hd
        tenEighty.interlaced = true
        tenEighty.name = "1080i"
        tenEighty.frameRate = 25.0
        
        let alsoTenEighty = tenEighty
        alsoTenEighty.frameRate = 30.0
        
        // Because classes are reference types, tenEighty and alsoTenEighty actually both refer to the same VideoMode instance. 
        // Effectively, they are just two different names for the same single instance.
        
        print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
        // Prints "The frameRate property of tenEighty is now 30.0"
        
        alsoTenEighty.resolution.width = 1234
        print(tenEighty.resolution.width)
        print(alsoTenEighty.resolution.width)
        
        // Note that tenEighty and alsoTenEighty are declared as constants,
        // rather than variables. 
        // However, you can still change tenEighty.frameRate and alsoTenEighty.frameRate because the values of the tenEighty and alsoTenEighty 
        // constants themselves do not actually change. 
        // tenEighty and alsoTenEighty themselves do not “store” the VideoMode instance—instead, 
        // they both refer to a VideoMode instance behind the scenes. 
        // It is the frameRate property of the underlying VideoMode that is changed, 
        // not the values of the constant references to that VideoMode.
    }
    
    func identityOperators() {
     
        // Because classes are reference types, it is possible for multiple constants and variables to 
        // refer to the same single instance of a class behind the scenes. 
        // (The same is not true for structures and enumerations, 
        // because they are always copied when they are assigned
        // to a constant or variable, or passed to a function.)
        
        // Identical to (===)
        
        // Not identical to (!==)
        
        // se these operators to check whether two constants or variables refer to the same single instance:
        
        let hd = Resolution(width: 1920, height: 1080)
        let tenEighty = VideoMode()
        tenEighty.resolution = hd
        tenEighty.interlaced = true
        tenEighty.name = "1080i"
        tenEighty.frameRate = 25.0
        
        let alsoTenEighty = tenEighty

        if tenEighty === alsoTenEighty {
            print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
        }
        // Prints "tenEighty and alsoTenEighty refer to the same VideoMode instance."
    }
    
    func choosingBetweenClassesAndStructures() {
    
        // You can use both classes and structures to define custom data types to use as the building blocks of your program’s code.
        
        // As a general guideline, consider creating a structure when one or more of these conditions apply:
        
        // The structure’s primary purpose is to encapsulate a few relatively simple data values.
        
        // It is reasonable to expect that the encapsulated values will be copied rather than referenced when you assign or pass around an instance of that structure.
        
        // Any properties stored by the structure are themselves value types, which would also be expected to be copied rather than referenced.
        
        // The structure does not need to inherit properties or behavior from another existing type.

        // In all other cases, define a class, and create instances of that class to be managed and passed by reference. 
        // In practice, this means that most custom data constructs should be classes, not structures
    }
    
    func assignmentAndCopyBehaviorForStringsArraysAndDictionaries() {

        // In Swift, many basic data types such as String, Array, and Dictionary are implemented as structures. 
        // This means that data such as strings, arrays, and dictionaries are copied when they are assigned to a new constant or variable, 
        // or when they are passed to a function or method.
        
        // This behavior is different from Foundation: NSString, NSArray, and NSDictionary are implemented as classes, 
        // not structures. Strings, arrays, and dictionaries in Foundation are 
        // always assigned and passed around as a reference to an existing instance, rather than as a copy.
    }
}
