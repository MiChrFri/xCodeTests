//
//  UnitTests.swift
//  UnitTests
//
//  Created by Michael Frick on 27.01.18.
//

import XCTest

import Foundation


class UnitTests: XCTestCase {
    
    func testfindsLastElementInList() {
//        let list = List("one", "two", "three", "four")
        let list = List(1, 1, 2, 3, 5, 8)
        XCTAssertEqual(list?.last, 8)
    }
    
    func testfindsSecondLastElementInList() {
        let list = List(1, 1, 2, 3, 5, 8)
        XCTAssertEqual(list?.pennultimate, 5)
    }
    
    func testfindElementInListbyIndex() {
        let list = List(1, 1, 2, 3, 5, 8)
        XCTAssertEqual(list?[2], 2)
    }
    
    func testFindNumberOfElementsInList() {
        let list = List(1, 1, 2, 3, 5, 8)
        XCTAssertEqual(list?.length, 6)
    }
    
    func testReverseList() {
        let list = List(1, 1, 2, 3, 5, 8)
        
        XCTAssertEqual((list?.reverse)!, [8, 5, 3, 2, 1, 1])
    }

}

class List<T> {
    var value: T
    var nextItem: List<T>?
    
    convenience init?(_ values: T...) {
        self.init(Array(values))
    }
    
    init?(_ values: [T]) {
        guard let first = values.first else {
            return nil
        }
        value = first
        nextItem = List(Array(values.suffix(from: 1)))
    }
    
    var last: T? {
        var element = self
        while element.nextItem != nil {
            element = element.nextItem!
        }
        
        return element.value
    }
    
    var pennultimate: T? {
        var element = self
        while element.nextItem?.nextItem != nil {
            element = element.nextItem!
        }
        
        return element.value
    }
    
    subscript(index: Int) -> T? {
        var currentIndex = 0
        var currentElement = self
        
        while currentIndex < index {
            if let nextElement = currentElement.nextItem {
                currentElement = nextElement
                currentIndex += 1
            } else {
                print("Index out of bounds")
                return nil
            }
        }
        
        return currentElement.value
    }
    
    var length: Int {
        var elementCount = 0
        var currentElement = self
        
        while currentElement.nextItem != nil {
            currentElement = currentElement.nextItem!
            elementCount += 1
        }
        elementCount += 1
        
        return elementCount
    }
    
    var reverse: [T] {
        var reversedList:[T] = []
        var element = self
        while element.nextItem != nil {
            reversedList.insert(element.value, at: 0)
            element = element.nextItem!
        }
        reversedList.insert(element.value, at: 0)
        
        return reversedList
    }
}
