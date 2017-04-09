//
//  Swap.swift
//  SortingAlgorithmVisualizer
//
//  Created by Skyler Arnold on 2/8/17.
//  Copyright © 2017 Skyler Arnold. All rights reserved.
//

import Foundation

class Step {} // abstract super for swap and read

class Swap: Step {
	let index1: Int
	let index2: Int
	
	init (index1: Int, index2: Int) {
		self.index1 = index1
		self.index2 = index2
		super.init()
	}
}

class Read: Step {
	let index: Int
	
	init(_ index: Int) {
		self.index = index
		super.init()
	}
}


extension Array {
	mutating func swap(swapObj: Swap) {
		let temp1 = self[swapObj.index1]
		self[swapObj.index1] = self[swapObj.index2]
		self[swapObj.index2] = temp1
	}
}

infix operator *

func * <newElement>(left: Array<newElement>, right: Int) -> Array<newElement> {
	var accumulator = [newElement]()
	for _ in 0..<right {
		accumulator.append(contentsOf: left)
	}
	return accumulator
}
