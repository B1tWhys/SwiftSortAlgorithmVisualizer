//
//  Swap.swift
//  SortingAlgorithmVisualizer
//
//  Created by Skyler Arnold on 2/8/17.
//  Copyright © 2017 Skyler Arnold. All rights reserved.
//

import Foundation

struct Swap {
	let index1: Int
	let index2: Int
}

extension Array {
	mutating func swap(swapObj: Swap) {
		let temp1 = self[swapObj.index1]
		self[swapObj.index1] = self[swapObj.index2]
		self[swapObj.index2] = temp1
	}
}
