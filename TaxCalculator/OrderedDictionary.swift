//
//  OrderedDictionary.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-07-27.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

//reference: http://timekl.com/blog/2014/06/02/learning-swift-ordered-dictionaries/
//reference :https://www.raywenderlich.com/82572/swift-generics-tutorial


struct OrderedDictionary<KeyType: Hashable, ValueType>{
    typealias ArrayType = [KeyType]
    typealias DictionaryType = [KeyType: ValueType]
    
    var array = ArrayType()
    var dictionary = DictionaryType()
    
    mutating func insert(_ value: ValueType, forKey key: KeyType, atIndex index: Int) -> ValueType?
    {
        var adjustedIndex = index
        
        let existingValue = self.dictionary[key]
        if existingValue != nil {
            let existingIndex = self.array.index(of: key)
            
            if existingIndex < index {
                adjustedIndex -= 1
            }
            self.array.remove(at: existingIndex!)
        }
        
        self.array.insert(key, at:adjustedIndex)
        self.dictionary[key] = value
        
        return existingValue
    }
    mutating func removeAtIndex(_ index: Int) -> (KeyType, ValueType)
    {
        precondition(index < self.array.count, "Index out-of-bounds")
        
        let key = self.array.remove(at: index)
        
        let value = self.dictionary.removeValue(forKey: key)!
        
        return (key, value)
    }
    var count: Int {
        return self.array.count
    }
    subscript(key: KeyType) -> ValueType? {
        get {
            return self.dictionary[key]
        }
        set {
            if let index = self.array.index(of: key) {
            } else {
                self.array.append(key)
            }
            
            self.dictionary[key] = newValue
        }
    }
    subscript(index: Int) -> (KeyType, ValueType) {
        get {
            precondition(index < self.array.count,
                "Index out-of-bounds")
            
            let key = self.array[index]
            
            let value = self.dictionary[key]!
            
            return (key, value)
        }
    }
    
}
