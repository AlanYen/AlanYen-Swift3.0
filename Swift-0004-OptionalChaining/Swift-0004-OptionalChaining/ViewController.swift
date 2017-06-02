//
//  ViewController.swift
//  Swift-0004-OptionalChaining
//
//  Created by Alan Yen on 2017/6/2.
//  Copyright © 2017年 Alan-App. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        // Optional chaining in Swift is similar to messaging nil in Objective-C, 
        // but in a way that works for any type, and that can be checked for success or failure
        //
        demo01()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func demo01() {
        
        class Person {
            var residence: Residence?
        }
        
        class Residence {
            var rooms = [Room]()
            var numberOfRooms: Int {
                return rooms.count
            }
            subscript(i: Int) -> Room {
                get {
                    return rooms[i]
                }
                set {
                    rooms[i] = newValue
                }
            }
            func printNumberOfRooms() {
                print("The number of rooms is \(numberOfRooms)")
            }
            var address: Address?
        }
        
        class Room {
            let name: String
            init(name: String) { self.name = name }
        }
        
        class Address {
            var buildingName: String?
            var buildingNumber: String?
            var street: String?
            func buildingIdentifier() -> String? {
                if let buildingNumber = buildingNumber, let street = street {
                    return "\(buildingNumber) \(street)"
                } else if buildingName != nil {
                    return buildingName
                } else {
                    return nil
                }
            }
        }
        
        let john = Person()
        let roomCount = john.residence?.numberOfRooms
        print(type(of: roomCount)) // optional Int / Int?

        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }
        // Prints "Unable to retrieve the number of rooms."

        //
        // In this example, the attempt to set the address property of john.residence will fail, because 
        // john.residence is currently nil.
        //
        
        let someAddress = Address()
        someAddress.buildingNumber = "29"
        someAddress.street = "Acacia Road"
        john.residence?.address = someAddress
        if john.residence?.address != nil {
            print("John's residence.address \(String(describing: john.residence?.address?.buildingIdentifier()))")
        } else {
            print("Unable to retrieve residence.address.")
        }
        
        // Assign Residence
        john.residence = Residence()
        john.residence?.rooms = [Room(name: "TestRoom")]
        
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }
        // Prints "John's residence has 1 room(s)."
        
        // If you call this method on an optional value with optional chaining,
        // the method’s return type will be Void?, not Void, 
        // because return values are always of an optional type when called through optional chaining. 
        // This enables you to use an if statement to check whether it was possible to call the printNumberOfRooms() 
        // method, even though the method does not itself define a return value. 
        // Compare the return value from the printNumberOfRooms call against nil to see if the method call was successful:
        
        // john.residence?.printNumberOfRooms() ====> Void? / ()?
        
        if john.residence?.printNumberOfRooms() != nil {
            print("It was possible to print the number of rooms.")
        } else {
            print("It was not possible to print the number of rooms.")
        }
        // Prints "It was not possible to print the number of rooms."
        
        
        
        if let _ = john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
            print("John's building identifier begins with \"The\".")
        } else {
                print("John's building identifier does not begin with \"The\".")
        }
        // Prints "John's building identifier begins with "The"."
    }
    
    func demo02() {
        
        var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
        testScores["Dave"]?[0] = 91
        testScores["Bev"]?[0] += 1
        testScores["Brian"]?[0] = 72
        // the "Dave" array is now [91, 82, 84] and the "Bev" array is now [80, 94, 81]
        
        testScores["Test"] = [1]
        testScores["Test"]?[4] = 1
    }
}
