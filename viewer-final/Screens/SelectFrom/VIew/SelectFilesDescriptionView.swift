//
//  SelectFilesDescriptionView.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 24.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit


protocol SelectFilesDescriptionViewDelegate: class {
    func buttonTappedHere()
}




final class SelectFilesDescriptionView: UIView {
    
    
    weak var delegate: SelectFilesDescriptionViewDelegate?
    
    let label: UILabel = {
        let label = UILabel.H5.regular
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate let termText: String = "ARQ Viewer supports more than 40 3D formats. A list of supported 3D models can be found here."
    fileprivate let term: String = "here"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    fileprivate func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
        let formattedText = String.format(strings: [term],
                                          boldFont: UIFont.getTTNormsFont(type: .medium, size: 14),
                                          boldColor: UIColor.Primary.primary,
                                          inString: termText,
                                          font: UIFont.getTTNormsFont(type: .medium, size: 14),
                                          color: .black)
        label.attributedText = formattedText
        label.setLineSpacing(lineSpacing: 4.0)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTermTapped))
        label.addGestureRecognizer(tap)
        
        
        
        
    }
    
    @objc func handleTermTapped(gesture: UITapGestureRecognizer) {
        
        let termString = termText as NSString
        let termRange = termString.range(of: term)
        
        
        let tapLocation = gesture.location(in: label)
        let index = label.indexOfAttributedTextCharacterAtPoint(point: tapLocation)
        
        if checkRange(termRange, contain: index) == true {
            delegate?.buttonTappedHere()
            return
        }
        
    }
    
    
    func checkRange(_ range: NSRange, contain index: Int) -> Bool {
        return index > range.location && index < range.location + range.length
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}






//MARK: - UILabel
extension UILabel {
    func indexOfAttributedTextCharacterAtPoint(point: CGPoint) -> Int {
        assert(self.attributedText != nil, "This method is developed for attributed string")
        let textStorage = NSTextStorage(attributedString: self.attributedText!)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer(size: self.frame.size)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = self.numberOfLines
        textContainer.lineBreakMode = self.lineBreakMode
        layoutManager.addTextContainer(textContainer)
        let index = layoutManager.characterIndex(for: point, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return index
    }
}



//MARK: - String
extension String {
    static func format(strings: [String],
                       boldFont: UIFont = UIFont.boldSystemFont(ofSize: 14),
                       boldColor: UIColor = UIColor.blue,
                       inString string: String,
                       font: UIFont = UIFont.systemFont(ofSize: 14),
                       color: UIColor = UIColor.black) -> NSAttributedString {
        let attributedString =
            NSMutableAttributedString(string: string,
                                      attributes: [
                                        NSAttributedString.Key.font: font,
                                        NSAttributedString.Key.foregroundColor: color])
        let boldFontAttribute = [NSAttributedString.Key.underlineStyle: 0x11,
                                 NSAttributedString.Key.font: boldFont,
                                 NSAttributedString.Key.foregroundColor: boldColor] as [NSAttributedString.Key : Any]
        for bold in strings {
            attributedString.addAttributes(boldFontAttribute, range: (string as NSString).range(of: bold))
        }
        return attributedString
    }
}
