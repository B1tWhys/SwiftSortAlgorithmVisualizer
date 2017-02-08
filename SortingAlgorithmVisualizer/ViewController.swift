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

	override func viewDidLoad() {
		super.viewDidLoad()
		self.graphView.values = [1, 2, 3, 4, 5]
		self.view.window?.backgroundColor = NSColor.black
		
		Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addValToChart), userInfo: nil, repeats: true)
		
		// Do any additional setup after loading the view.
	}

	func addValToChart() {
		let swpObj = Swap(index1: 2, index2: 3)
		
		self.graphView.values.swap(swapObj: swpObj)
		//self.graphView.values.append(Int(val))
	}
	
	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}


}

