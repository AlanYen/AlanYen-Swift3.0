//
//  ViewController.swift
//  Swift-0002-Closure
//
//  Created by AlanYen on 2017/5/16.
//  Copyright © 2017年 Alan-App. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        demo01()
        demo02()
        demo03()
        demo04()
        demo05()
        demo06()
        demo07()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func demo01() {

        /*
         * Closure 不包含 Function 名稱。
         * Closure 語法把 Function 名稱右邊參數列與回傳型別放到{右邊然後加上in，其餘不變。
         * 儲存 Closure 變數的型別能從=右邊的 Closure 內容推測得知，型別定義可省略。
         */
        
        let hi = { () -> () in
            print("Hello!!")
        }
        
        let WhoAmI = { (name: String) -> String in
            
            return "I am " + name
        }
        
        let HowOld = { (name: String, age: Int) -> String in
            
            return "I am " + name + ", " + String(age) + " yesrs old"
        }
        
        let Familys = { (name: String) -> Array<String> in
            
            return ["Alan", "Emma", "Rebecca", "Ryan"]
        }
        
        let LastName1 = { (name: String) -> (lastName1: String, lastName2: String) in

            return ("Yen", "Lo")
        }
        
        let LastName2 = { (name: String) -> (String, String) in
            
            return ("Yen", "Lo")
        }
        
        hi()

        //
        let iAm = WhoAmI("Alan")
        print(iAm)
        
        //
        let howOld = HowOld("Alan", 23)
        print(howOld)
        
        //
        let familys = Familys("Alan")
        print(familys)
        
        //
        let lastName1 = LastName1("Alan")
        print(lastName1.lastName1)
        print(lastName1.lastName2)
        
        //
        let lastName2 = LastName2("Alan")
        print(lastName2)
        print(lastName2.0)
        print(lastName2.1)
    }
    
    func demo02() {
        
        /*
         * sorted
         */
        
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        
        func backward(_ s1: String, _ s2: String) -> Bool {
            return s1 > s2
        }
        
        let reversedNames1 = names.sorted(by: backward)
        print(reversedNames1)
        
        let reversedNames21 = names.sorted(by: { (s1, s2) -> Bool in
            return s1 < s2
        })
        print(reversedNames21)

        /*
         * Trailing Closures
         */
        let reversedNames22 = names.sorted { (s1, s2) -> Bool in
            return s1 < s2
        }
        print(reversedNames22)

        let reversedNames31 = names.sorted(by: { return $0 < $1 } )
        print(reversedNames31)
        
        /*
         * Trailing Closures
         */
        let reversedNames32 = names.sorted { return $0 < $1 }
        print(reversedNames32)
        
        let reversedNames41 = names.sorted(by: { return $1 < $0 } )
        print(reversedNames41)
        
        /*
         * Trailing Closures
         */
        let reversedNames42 = names.sorted { return $1 < $0 }
        print(reversedNames42)
        
        let reversedNames5 = names.sorted(by: < )
        print(reversedNames5)

        let reversedNames6 = names.sorted(by: > )
        print(reversedNames6)
    }
    
    func demo03() {
        
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        let numbers = [16, 58, 510]
        
        let strings = numbers.map { (number) -> String in
            print(number)
            var number = number
            var output = ""
            repeat {
                output = digitNames[number % 10]! + output
                number /= 10
            } while number > 0
            print(output)
            return output
        }
        print(strings)
        // strings is inferred to be of type [String]
        // its value is ["OneSix", "FiveEight", "FiveOneZero"]
    }
    
    func demo04() {
        
        /*
         * functions and closures are reference types.
         */
        
        func makeIncrementer(forIncrement amount: Int) -> (() -> Int, () -> Int, () -> Int) {
            var runningTotal = 0
            
            func incrementer() -> Int {
                runningTotal += amount
                return runningTotal
            }
            
            func decrementer() -> Int {
                runningTotal -= amount
                return runningTotal
            }
            
            func reseter() -> Int {
                runningTotal = 0
                return runningTotal
            }
            
            return (incrementer, decrementer, reseter)
        }
        
        let (incrementByTen, decrementByTen, reseter) = makeIncrementer(forIncrement: 10)
        
        let a = incrementByTen()
        print(a)
        
        let incrementByTen1 = incrementByTen
        let a1 = incrementByTen1()
        print(a1)
        
        let b = incrementByTen()
        print(b)

        let c = incrementByTen()
        print(c)
        
        let d = decrementByTen()
        print(d)

        let e = decrementByTen()
        print(e)

        let f = reseter()
        print(f)
    }
    
    func demo05() {
        
        /*
         * @escaping
         */
        
        var completionHandlers: [() -> Void] = []
        func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
            completionHandlers.append(completionHandler)
            print("completionHandlers count = \(completionHandlers.count)")
        }
        
        someFunctionWithEscapingClosure {
            print("exe1")
        }
        someFunctionWithEscapingClosure {
            print("exe2")
        }
        someFunctionWithEscapingClosure {
            print("exe3")
        }
        someFunctionWithEscapingClosure {
            print("exe4")
        }
        
        for handler in completionHandlers {
            handler()
        }
    }
    
    func demo06() {
        
        /*
         * AutoClosure
         */
        
        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        print(customersInLine.count)
        // Prints "5"
        
        let customerProvider = { customersInLine.remove(at: 1) }
        print(customersInLine.count)
        // Prints "5"
        
        print("Now serving \(customerProvider())!")
        // Prints "Now serving Chris!"
        print(customersInLine.count)
        // Prints "4"
        
        // customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
        func serve(customer customerProvider: () -> String) {
            print("Now serving \(customerProvider())!")
        }
        serve(customer: { customersInLine.remove(at: 0) } )
        print(customersInLine.count)
        
        
        // customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
        func serve_autoclosure(customer customerProvider: @autoclosure () -> String) {
            print("Now serving \(customerProvider())!")
        }
        serve_autoclosure(customer: customersInLine.remove(at: 0) )
        print(customersInLine.count)
    }
    
    func demo07() {
    
        /*
         * AutoClosure & Escape
         */
        
        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        print(customersInLine.count)
        // Prints "5"
        
        // customersInLine is ["Barry", "Daniella"]
        var customerProviders: [() -> String] = []
        func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
            customerProviders.append(customerProvider)
        }
        collectCustomerProviders(customersInLine.remove(at: 0))
        collectCustomerProviders(customersInLine.remove(at: 0))
        
        print("Collected \(customerProviders.count) closures.")
        // Prints "Collected 2 closures."
        for customerProvider in customerProviders {
            print("Now serving \(customerProvider())!")
        }
        // Prints "Now serving Barry!"
        // Prints "Now serving Daniella!"
    }
}

