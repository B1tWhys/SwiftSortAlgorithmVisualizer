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
		let bitmap = calcBitmap()
		var date = NSDate()
		let image = imageFromBitmap(bitmap, width: Int(self.frame.width*2.0), height: Int(self.frame.height*2.0))
		Swift.print("imageGen: \(-date.timeIntervalSinceNow)")
		date = NSDate()
		image.draw(in: dirtyRect)
		Swift.print("draw: \(-date.timeIntervalSinceNow)\n\n")
	}
	
	let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
	let bitmapInfo: CGBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
	
	func imageFromBitmap(_ pixels:[UInt32], width: Int, height: Int) -> NSImage {
		let bitsPerComponent = 8
		let bitsPerPixel = 32
		
		assert(pixels.count == Int(width*height))
		var data: [UInt32] = pixels
		let providerRef = CGDataProvider(
			data: Data(bytes: UnsafeRawPointer!(&data), count: data.count * MemoryLayout<PixelData>.size) as CFData
		)
		
		let gcim = CGImage(
			width: width,
			height: height,
			bitsPerComponent: bitsPerComponent,
			bitsPerPixel: bitsPerPixel,
			bytesPerRow: width*MemoryLayout<PixelData>.size,
			space: self.rgbColorSpace,
			bitmapInfo: self.bitmapInfo,
			provider: providerRef!,
			decode: nil,
			shouldInterpolate: true,
			intent: CGColorRenderingIntent.defaultIntent)
		
		return NSImage(cgImage: gcim!, size: CGSize(width: width, height: height))
	}
	
	func calcBitmap() -> [UInt32] {
		let height = Int(self.frame.height*2)
		let width = Int(self.frame.width*2)
		
		var pixels = Array(repeating: Array(repeating: UInt32.max, count: height), count: width)

		let maxVal = Float(self.values.max()!)
		let scaleFactor = Float(height)/maxVal
		
		var barHeights = [Int]()
		for val in values {
			barHeights.append(Int(Float(val)*scaleFactor))
		}
		
		let blackPx = UInt32(255)
		
		var vector = Array(repeating: UInt32.max, count: width*height)
		
		let xRange = 0..<width
		
		let start = NSDate()
		
		for x in xRange {
			let index = Int(roundf((Float(x)/Float(width))*Float(self.values.count-1)))
			let pxHeight = barHeights[index]
			
			let yRange = (0..<pxHeight)
			for y in yRange {
				//pixels[x][y] = blackPx
				vector[width*y+x] = blackPx
			}
		}
		
		Swift.print("EntireLoop: \(-start.timeIntervalSinceNow)")
//		
//		for row in 0..<height {
//			for column in 0..<width {
//				vector[width*row+column] = pixels[column][row]
//
//			}
//		}
		
		return vector
	}
}
