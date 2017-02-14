//
//  ViewController.swift
//  SortingAlgorithmVisualizer
//
//  Created by Skyler Arnold on 2/6/17.
//  Copyright © 2017 Skyler Arnold. All rights reserved.
//

import Cocoa

let numOfItemsInArray = 100


class ViewController: NSViewController {
	@IBOutlet weak var graphView: GraphView!
	var graphicsArray = [Int]()

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	required override init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	

	
	override func viewDidLoad() {
		super.viewDidLoad()

		self.view.window?.backgroundColor = NSColor.black
		
		self.runSort()

		print(Sorter.swaps.count)
		Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(updateGraphView(sender:)), userInfo: nil, repeats: true)
		
	}

	func runSort() { // initialize the sort array, and call the sort in the right queue
		self.initSortArray()
		Sorter.sorted = false
		
		DispatchQueue.global().async {
//			Sorter.quicksort(array: &Sorter.vals, lo: 0, hi: Sorter.vals.count)
//			Sorter.bubbleSort(array: &Sorter.vals)
			
			Sorter.sort(algorithm: .bubbleSort)
			
			DispatchQueue.main.sync {
				Sorter.sorted = true
			}
		}
	}
	
	func initSortArray() {
		Sorter.vals = [Int]()
		
		let len = numOfItemsInArray
		var pool = Array(0..<len)
		for _ in 0..<(len) {
			let index = Int(arc4random_uniform(UInt32(pool.count)))
			Sorter.vals.append(pool.remove(at: index))
		}
		
		self.graphView.values = Sorter.vals
	}
	
	func updateGraphView(sender: Any) {
		if Sorter.swaps.count > 0 {
			let swap = Sorter.swaps.remove(at: 0)
			self.graphView.values.swap(swapObj: swap)
		} else if Sorter.sorted {
			if let sender = sender as? Timer {
				sender.invalidate()
				DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
					self.runSort()
					Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.updateGraphView(sender:)), userInfo: nil, repeats: true)
				}
			}
		}
	}
}

