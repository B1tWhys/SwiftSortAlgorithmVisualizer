//
//  SortingAlgorithmVisualizerTests.swift
//  SortingAlgorithmVisualizerTests
//
//  Created by Skyler Arnold on 2/24/17.
//  Copyright © 2017 Skyler Arnold. All rights reserved.
//

import XCTest

@testable import SortingAlgorithmVisualizer

class SortingAlgorithmVisualizerTests: XCTestCase {
	
	var graphView: GraphView?
	
    override func setUp() {
        super.setUp()
		
		self.graphView = GraphView(frame: CGRect(x: 0, y: 0, width: 1429, height: 855))
	}
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func genRandomArray(length: Int) -> [Int] {
		var pool = Array(0..<length)
		var array = [Int]()
		
		for _ in 0..<length {
			array.append(pool.remove(at: Int(arc4random_uniform(UInt32(pool.count-1)))))
		}
		
		return array
	}
	
	func testGraphBitmapCalcSpeed() {
		self.graphView!.values = self.genRandomArray(length: 100)
		
		self.measure {
			self.graphView!.calcBitmap()
		}
	}
}
