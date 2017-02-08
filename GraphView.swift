//
//  GraphView.swift
//  SortingAlgorithmVisualizer
//
//  Created by Skyler Arnold on 2/6/17.
//  Copyright © 2017 Skyler Arnold. All rights reserved.
//

import Cocoa

class GraphView: NSView {
	
	var values: [Int]! {
		didSet {
			if (values.count != 0) {
				Swift.print("valuesSet")
				self.setNeedsDisplay(self.frame)
			}
		}
	}
	
	var barWidth: Float {
		get {
			return Float(self.frame.width)/Float(values.count)
		}
	}
	var hScale: Float {
		get {
			let range = Float(values.max()!)
			return Float(self.frame.height)/range
		}
	}
	
	
	override init(frame frameRect: NSRect) {
		self.values = [Int]()

		super.init(frame: frameRect)
	}
	
	convenience init(frame frameRect: NSRect, values: [Int]) {
		self.init(frame: frameRect)
		
		self.values = values

	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func draw(_ dirtyRect: NSRect) {
		NSColor.black.setFill()
		NSBezierPath.fill(dirtyRect)
		NSColor.white.setFill()
		for index in 0..<self.values.count {
			let val = self.values[index]
			let height = CGFloat(Float(val)*self.hScale)
			let x = CGFloat(Float(index)*barWidth)
			
			let rect = CGRect(x: x,
			                  y: 0.0,
			                  width: CGFloat(self.barWidth),
			                  height: height)
			NSBezierPath.fill(rect)
		}
	}
}
