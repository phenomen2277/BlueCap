//
//  RawPairDeserializableTests.swift
//  BlueCapKit
//
//  Created by Troy Stribling on 2/9/15.
//  Copyright (c) 2015 gnos.us. All rights reserved.
//

import UIKit
import XCTest
import BlueCapKit

class RawPairDeserializableTests: XCTestCase {
    
    struct Pair : RawPairDeserializable {
        
        let value1:Int8
        let value2:UInt8
        
        // RawArrayPairDeserializable
        static let uuid = "abc"
        
        var rawValue1 : Int8  {
            return self.value1
        }
        
        var rawValue2 : UInt8 {
            return self.value2
        }
        
        init?(rawValue1:Int8, rawValue2:UInt8) {
            if rawValue2 > 10 {
                self.value1 = rawValue1
                self.value2 = rawValue2
            } else {
                return nil
            }
        }
        
    }
    

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSuccessfulDeserilaization() {
        let data = "02ab".dataFromHexString()
        if let value : Pair = Serde.deserialize(data) {
            XCTAssert(value.value1 == 2 && value.value2 == 171, "RawPairDeserializableTests deserialization value invalid: \(value.value1), \(value.value2)")
        } else {
            XCTFail("RawPairDeserializableTests deserialization failed")
        }
    }
    
    func testFailedDeserilaization() {
        let data = "0201".dataFromHexString()
        if let value : Pair = Serde.deserialize(data) {
            XCTFail("RawPairDeserializableTests deserialization succeeded")
        }
    }
    
    func testSuccessfuleSerialization() {
        if let let value = Pair(rawValue1:5, rawValue2:100) {
            let data = Serde.serialize(value)
            XCTAssert(data.hexStringValue() == "0564", "RawDeserializable serialization failed: \(data)")
        } else {
            XCTFail("RawPairDeserializableTests RawArray creation failed")
        }
    }

    func testFailedeSerialization() {
        if let let value = Pair(rawValue1:5, rawValue2:1) {
            XCTFail("RawPairDeserializableTests RawArray creation succeeded")
        }
    }

}