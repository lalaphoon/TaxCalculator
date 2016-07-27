//
//  OrderedDictionary.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-07-27.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
//reference: http://timekl.com/blog/2014/06/02/learning-swift-ordered-dictionaries/
//reference :https://www.raywenderlich.com/82572/swift-generics-tutorial


struct OrderedDictionary<KeyType: Hashable, ValueType>{
    typealias ArrayType = [KeyType]
    typealias DictionaryType = [KeyType: ValueType]
    
    var array = ArrayType()
    var dictionary = DictionaryType()
    
    mutating func insert(value: ValueType, forKey key: KeyType, atIndex index: Int) -> ValueType?
    {
        var adjustedIndex = index
        
        let existingValue = self.dictionary[key]
        if existingValue != nil {
            let existingIndex = self.array.indexOf(key)
            
            if existingIndex < index {
                adjustedIndex--
            }
            self.array.removeAtIndex(existingIndex!)
        }
        
        self.array.insert(key, atIndex:adjustedIndex)
        self.dictionary[key] = value
        
        return existingValue
    }
    mutating func removeAtIndex(index: Int) -> (KeyType, ValueType)
    {
        precondition(index < self.array.count, "Index out-of-bounds")
        
        let key = self.array.removeAtIndex(index)
        
        let value = self.dictionary.removeValueForKey(key)!
        
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
            if let index = self.array.indexOf(key) {
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