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
	var whiteCount = 0

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
		self.whiteCount = 0
		let bitmap = calcBitmap()
		let image = imageFromBitmap(bitmap, width: Int(self.frame.width*2.0), height: Int(self.frame.height*2.0))
		image.draw(in: dirtyRect)
	}
	
	let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
	let bitmapInfo: CGBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
	
	func imageFromBitmap(_ pixels:[PixelData], width: Int, height: Int) -> NSImage {
		let bitsPerComponent = 8
		let bitsPerPixel = 32
		
		assert(pixels.count == Int(width*height))
		var data: [PixelData] = pixels
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
	
	
	func calcBitmap() -> [PixelData] {
		var pixels = [PixelData]()
		NSGraphicsContext.current()
		
		let height = Int(self.frame.height*2)
		let width = Int(self.frame.width*2)
		
		let maxVal = Float(self.values.max()!)
		let scaleFactor = Float(height)/maxVal
		
		
		
		for rowFromTop in 0..<height {
			let row = height-rowFromTop
			for column in 0..<width {
				let index = Int(roundf((Float(column)/Float(width))*Float(self.values.count-1)))
				let valForRow = Float(self.values[index])
				let isWhite = Float(row) <= (valForRow)*(scaleFactor)
				//let isWhite = Float(row)<=(valForRow/maxVal)
				if isWhite {
					whiteCount += 1
					//Swift.print(whiteCount)
				}
				let pixel = isWhite ? PixelData(a: 255, r: 255, g: 255, b: 255) : PixelData(a: 255, r: 0, g: 0, b: 0)
				pixels.append(pixel)
			}
		}
		whiteCount = 0
		
//		for val in self.values {
//			let frac = Float(val)/Float(maxVal)
//			let pxHeight = Int(frac*Float(height))
//			let column = Array(repeating: true, count: pxHeight) + Array(repeating: false, count: Int(height)-pxHeight)
//			pixels.append(contentsOf: column*perBarWidth)
//		}
		
		return pixels
	}
}
