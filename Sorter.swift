//
//  Sorter.swift
//  SortingAlgorithmVisualizer
//
//  Created by Skyler Arnold on 2/9/17.
//  Copyright © 2017 Skyler Arnold. All rights reserved.
//

import Foundation

enum SortAlgorithm {
	case quickSort
	case bubbleSort
}

struct Sorter {
	static var steps = [Step]()
	static var vals = [Int]()
	static var sorted = false
	
	static public func sort(algorithm: SortAlgorithm) {
		switch algorithm {
		case .quickSort:
			Sorter.quicksort(array: &Sorter.vals, lo: 0, hi: Sorter.vals.count)
		
		case .bubbleSort:
			Sorter.bubbleSort(array: &Sorter.vals)
		}
		Swift.print("sort complete")
	}
	
	static private func bubbleSort(array A: inout[Int]) {
		var swapped = false
		repeat {
			swapped = false
			for i in 1..<A.count {
				if A[i-1] > A[i] {
					let swap = Swap(index1: i-1, index2: i)
					DispatchQueue.main.sync {
						steps.append(Read(i-1))
						steps.append(Read(i))
						steps.append(swap)
						A.swap(swapObj: swap)
					}
					
					swapped = true
				}
				
			}
		} while swapped
	}
	
	static private func addRead(_ index: Int) {
		DispatchQueue.main.sync {
			steps.append(Read(index))
		}
	}
	
	static private func quicksort(array A: inout [Int], lo: Int, hi: Int) {
		func partition(A: inout [Int], lo: Int, hi: Int) -> Int {
			let pivot = A[lo]
			var pivotIndex = lo
			var leftwall = lo
			
			for i in (lo+1)..<hi {
				Sorter.addRead(pivotIndex)
				Sorter.addRead(i)
				if (A[i] < pivot) {
					if (i == pivotIndex) {
						pivotIndex = leftwall
					} else if (leftwall == pivotIndex) {
						pivotIndex = i
					}
					let swap = Swap(index1: i, index2: leftwall)
					DispatchQueue.main.sync {
						steps.append(swap)
						A.swap(swapObj: swap)
					}
					leftwall += 1
				}
			}
			
			DispatchQueue.main.sync {
				let swap = Swap(index1: pivotIndex, index2: leftwall)
				
				steps.append(swap)
				A.swap(swapObj: swap)
			}
			
			return leftwall
		}
		
		if (lo < hi) {
			let p = partition(A: &A, lo: lo, hi: hi)
			quicksort(array: &A, lo: lo, hi: p)
			quicksort(array: &A, lo: p+1, hi: hi)
		}
	}
	
}
