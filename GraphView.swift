//
//  GraphView.swift
//  SortingAlgorithmVisualizer
//
//  Created by Skyler Arnold on 2/6/17.
//  Copyright © 2017 Skyler Arnold. All rights reserved.
//

import Cocoa

struct PixelData {
	var a: UInt8
	var r: UInt8
	var g: UInt8
	var b: UInt8
}

class GraphView: NSImageView {
	
	var values: [Int]! {
		didSet {
			if (values.count != 0) {
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
		self.values = [Int]()
		super.init(coder: coder)
	}
	
	override func draw(_ dirtyRect: NSRect) {
		NSColor.black.setFill()
		NSBezierPath.fill(dirtyRect)
		NSColor.white.setFill()
		let path = NSBezierPath()
		for index in 0..<self.values.count {
			let val = self.values[index]
			let height = CGFloat(Float(val)*self.hScale)
			let x = CGFloat(Float(index)*barWidth)
			
			let rect = CGRect(x: x,
			                  y: 0.0,
			                  width: CGFloat(self.barWidth),
			                  height: height)
			path.appendRect(rect)
		}
		path.fill()
		
		
		
	}
	
	private func calcBitmap() -> [Bool] {
		var pixels = [Bool]() // column / rows
		NSGraphicsContext.current()
		let perBarWidth = Int((self.frame.width*2)/CGFloat(self.values.count))

		let height = Float(self.frame.height*2)
		let maxVal = self.values.max()!
		
		for val in self.values {
			let frac = Float(val)/Float(maxVal)
			let pxHeight = Int(frac*height)
			let column = Array(repeating: true, count: pxHeight) + Array(repeating: false, count: Int(height)-pxHeight)
			pixels.append(contentsOf: column*perBarWidth)
		}
		
		return pixels
	}
}
