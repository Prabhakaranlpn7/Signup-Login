//
//  Extension+UIElements.swift
//  Login_Swfit
//
//  Created by Prabhakaran on 15/11/25.
//

import UIKit

extension UITapGestureRecognizer {

    func didTapAttributedTextInLabel(label: UILabel, targetRange: NSRange) -> Bool {
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        textContainer.size = label.bounds.size

        let location = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(
            x: (label.bounds.width - textBoundingBox.width) * 0.0 - textBoundingBox.minX,
            y: (label.bounds.height - textBoundingBox.height) * 0.5 - textBoundingBox.minY
        )
        let locationInTextContainer = CGPoint(
            x: location.x - textContainerOffset.x,
            y: location.y - textContainerOffset.y
        )

        let index = layoutManager.characterIndex(for: locationInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)

        return NSLocationInRange(index, targetRange)
    }
}

