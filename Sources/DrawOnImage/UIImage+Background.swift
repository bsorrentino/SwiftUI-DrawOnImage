//
//  UIImage+Background.swift
//  DrawOnImage
//
//  Created by bsorrentino on 04/01/26.
//

import UIKit

///
/// [how to set a background color in UIimage in swift programming](https://stackoverflow.com/a/53500161/521197)
///
extension UIImage {
    public func withBackground(color: UIColor, opaque: Bool = true) -> UIImage {
        guard let ctx = UIGraphicsGetCurrentContext(), let image = cgImage else { return self }
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        defer { UIGraphicsEndImageContext() }
        let rect = CGRect(origin: .zero, size: size)
        ctx.setFillColor(color.cgColor)
        ctx.fill(rect)
        ctx.concatenate(CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height))
        ctx.draw(image, in: rect)
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}

