//
//  Sorter.swift
//  SortingAlgorithmVisualizer
//
//  Created by Skyler Arnold on 2/9/17.
//  Copyright © 2017 Skyler Arnold. All rights reserved.
//

import Foundation

struct Sorter {
	static var swaps = [Swap]()
	static var vals = [Int]()
	
	static func quicksort(array A: inout [Int], lo: Int, hi: Int) {
		func partition(A: inout [Int], lo: Int, hi: Int) -> Int {
			let pivot = A[lo]
			var leftwall = lo
			
			for i in (lo+1)..<hi {
				if (A[i] < pivot) {
					let swap = Swap(index1: i, index2: leftwall)
					swaps.append(swap)
					A.swap(swapObj: swap)
					leftwall += 1
				}
			}
			let swap = Swap(index1: Sorter.vals.index(of: pivot)!, index2: leftwall)
			swaps.append(swap)
			A.swap(swapObj: swap)
			return leftwall
		}
		
		if (lo < hi) {
			let p = partition(A: &A, lo: lo, hi: hi)
			quicksort(array: &A, lo: lo, hi: p)
			quicksort(array: &A, lo: p+1, hi: hi)
		}
	}
	
}
