//
//  Extensions.swift
//  Photo Editor
//
//  Created by Andreas Schultz on 07.09.20.
//

import UIKit

extension UIImage {
    func compressed() -> UIImage? {
        var compressedImage = UIImage()
        
        if let imageData = self.pngData(){
            let options = [
                kCGImageSourceCreateThumbnailWithTransform: true,
                kCGImageSourceCreateThumbnailFromImageAlways: true,
                kCGImageSourceThumbnailMaxPixelSize: 200] as CFDictionary

            imageData.withUnsafeBytes { ptr in
               guard let bytes = ptr.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                  return
               }
               if let cfData = CFDataCreate(kCFAllocatorDefault, bytes, imageData.count){
                  let source = CGImageSourceCreateWithData(cfData, nil)!
                  let imageReference = CGImageSourceCreateThumbnailAtIndex(source, 0, options)!
                  compressedImage = UIImage(cgImage: imageReference)
               }
            }
        }
        
        return compressedImage
    }
}
