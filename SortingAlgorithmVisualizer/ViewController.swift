//
//  ViewController.swift
//  SortingAlgorithmVisualizer
//
//  Created by Skyler Arnold on 2/6/17.
//  Copyright © 2017 Skyler Arnold. All rights reserved.
//

import Cocoa

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
		
		
		let len = 100
		var pool = Array(0..<len)
		for _ in 0..<(len) {
			let index = Int(arc4random_uniform(UInt32(pool.count)))
			Sorter.vals.append(pool.remove(at: index))
		}
		
		self.graphView.values = Sorter.vals
		
		DispatchQueue.global().async {
			Sorter.quicksort(array: &Sorter.vals, lo: 0, hi: Sorter.vals.count)
		}
		print(Sorter.swaps.count)
		Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(updateGraphView), userInfo: nil, repeats: true)
		
	}

	func updateGraphView() {
		if Sorter.swaps.count > 0 {
			let swap = Sorter.swaps.remove(at: 0)
			self.graphView.values.swap(swapObj: swap)
		}
	}
	
	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}


}

