//
//  ZLEditToolCells.swift
//  ZLImageEditor
//
//  Created by long on 2021/12/21.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

// MARK: Edit tool cell

class ZLEditToolCell: UICollectionViewCell {
    var toolType: ZLImageEditorConfiguration.EditTool = .draw {
        didSet {
            switch toolType {
            case .draw:
                icon.image = .zl.getImage("zl_drawLine")
                icon.highlightedImage = .zl.getImage("zl_drawLine_selected")
            case .clip:
                icon.image = .zl.getImage("zl_clip")
                icon.highlightedImage = .zl.getImage("zl_clip")
            case .imageSticker:
                icon.image = .zl.getImage("zl_imageSticker")
                icon.highlightedImage = .zl.getImage("zl_imageSticker")
            case .textSticker:
                icon.image = .zl.getImage("zl_textSticker")
                icon.highlightedImage = .zl.getImage("zl_textSticker")
            case .mosaic:
                icon.image = .zl.getImage("zl_mosaic")
                icon.highlightedImage = .zl.getImage("zl_mosaic_selected")
            case .filter:
                icon.image = .zl.getImage("zl_filter")
                icon.highlightedImage = .zl.getImage("zl_filter_selected")
            case .adjust:
                icon.image = .zl.getImage("zl_adjust")
                icon.highlightedImage = .zl.getImage("zl_adjust_selected")
            case .shape:
                icon.image = .zl.getImage("zl_shape") ?? ZLShapeIconGenerator.toolbarIcon()
                icon.highlightedImage = .zl.getImage("zl_shape_selected") ?? ZLShapeIconGenerator.toolbarIcon(highlighted: true)
            }
            if let color = UIColor.zl.toolIconHighlightedColor {
                icon.highlightedImage = icon.highlightedImage?
                    .zl.fillColor(color)
            }
        }
    }
    
    lazy var icon = UIImageView(frame: contentView.bounds)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(icon)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: draw color cell

class ZLDrawColorCell: UICollectionViewCell {
    lazy var colorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return view
    }()
    
    lazy var bgWhiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        return view
    }()
    
    var color: UIColor = .clear {
        didSet {
            colorView.backgroundColor = color
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(bgWhiteView)
        contentView.addSubview(colorView)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        colorView.center = contentView.center
        bgWhiteView.center = contentView.center
    }
}

// MARK: filter cell

class ZLFilterImageCell: UICollectionViewCell {
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: bounds.height - 20, width: bounds.width, height: 20)
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        label.layer.shadowOffset = .zero
        label.layer.shadowOpacity = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.width)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(imageView)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: adjust tool cell

class ZLAdjustToolCell: UICollectionViewCell {
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: bounds.height - 30, width: bounds.width, height: 30)
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byCharWrapping
        label.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        label.layer.shadowOffset = .zero
        label.layer.shadowOpacity = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: (bounds.width - 30) / 2, y: 0, width: 30, height: 30)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    var adjustTool: ZLImageEditorConfiguration.AdjustTool = .brightness {
        didSet {
            switch adjustTool {
            case .brightness:
                imageView.image = .zl.getImage("zl_brightness")
                imageView.highlightedImage = .zl.getImage("zl_brightness_selected")
                nameLabel.text = localLanguageTextValue(.brightness)
            case .contrast:
                imageView.image = .zl.getImage("zl_contrast")
                imageView.highlightedImage = .zl.getImage("zl_contrast_selected")
                nameLabel.text = localLanguageTextValue(.contrast)
            case .saturation:
                imageView.image = .zl.getImage("zl_saturation")
                imageView.highlightedImage = .zl.getImage("zl_saturation_selected")
                nameLabel.text = localLanguageTextValue(.saturation)
            }
            if let color = UIColor.zl.toolIconHighlightedColor {
                imageView.highlightedImage = imageView.highlightedImage?
                    .zl.fillColor(color)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(imageView)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: shape type cell

class ZLShapeTypeCell: UICollectionViewCell {
    lazy var icon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var shapeType: ZLImageEditorConfiguration.ShapeType = .line {
        didSet {
            updateIcon()
        }
    }
    
    var isChoosen: Bool = false {
        didSet {
            updateIcon()
        }
    }
    
    private func updateIcon() {
        icon.image = ZLShapeIconGenerator.shapeIcon(for: shapeType, selected: isChoosen)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(icon)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        icon.frame = contentView.bounds
    }
}

// MARK: Programmatic shape icon generator

enum ZLShapeIconGenerator {
    /// Generate the toolbar icon for the shape tool (a simple diamond/rhombus shape).
    static func toolbarIcon(highlighted: Bool = false) -> UIImage {
        let size = CGSize(width: 30, height: 30)
        return UIGraphicsImageRenderer(size: size).image { ctx in
            let color: UIColor = highlighted ? .zl.rgba(3, 193, 94) : .white
            color.setStroke()
            
            // Draw a simple diamond shape
            let path = UIBezierPath()
            path.lineWidth = 2
            path.move(to: CGPoint(x: 15, y: 3))
            path.addLine(to: CGPoint(x: 27, y: 15))
            path.addLine(to: CGPoint(x: 15, y: 27))
            path.addLine(to: CGPoint(x: 3, y: 15))
            path.close()
            path.stroke()
        }
    }
    
    /// Generate an icon for the fill/stroke toggle button.
    static func fillToggleIcon(isFilled: Bool) -> UIImage {
        let size = CGSize(width: 30, height: 30)
        return UIGraphicsImageRenderer(size: size).image { ctx in
            UIColor.white.setStroke()
            
            let rect = CGRect(x: 5, y: 5, width: 20, height: 20)
            let path = UIBezierPath(roundedRect: rect, cornerRadius: 3)
            path.lineWidth = 2
            path.stroke()
            
            if isFilled {
                UIColor.white.setFill()
                let innerRect = CGRect(x: 8, y: 8, width: 14, height: 14)
                let innerPath = UIBezierPath(roundedRect: innerRect, cornerRadius: 2)
                innerPath.fill()
            }
        }
    }
    
    /// Generate an icon for a specific shape type.
    static func shapeIcon(for type: ZLImageEditorConfiguration.ShapeType, selected: Bool) -> UIImage {
        let size = CGSize(width: 30, height: 30)
        return UIGraphicsImageRenderer(size: size).image { ctx in
            let color: UIColor = selected ? .white : .zl.rgba(160, 160, 160)
            color.setStroke()
            
            switch type {
            case .line:
                let path = UIBezierPath()
                path.lineWidth = 2.5
                path.lineCapStyle = .round
                path.move(to: CGPoint(x: 4, y: 26))
                path.addLine(to: CGPoint(x: 26, y: 4))
                path.stroke()
                
            case .arrow:
                let path = UIBezierPath()
                path.lineWidth = 2.5
                path.lineCapStyle = .round
                path.lineJoinStyle = .round
                path.move(to: CGPoint(x: 4, y: 26))
                path.addLine(to: CGPoint(x: 26, y: 4))
                path.stroke()
                
                // Arrowhead
                let head = UIBezierPath()
                head.lineWidth = 2.5
                head.lineCapStyle = .round
                head.lineJoinStyle = .round
                head.move(to: CGPoint(x: 18, y: 4))
                head.addLine(to: CGPoint(x: 26, y: 4))
                head.addLine(to: CGPoint(x: 26, y: 12))
                head.stroke()
                
            case .oval:
                let rect = CGRect(x: 3, y: 5, width: 24, height: 20)
                let path = UIBezierPath(ovalIn: rect)
                path.lineWidth = 2.5
                path.stroke()
                
            case .rectangle:
                let rect = CGRect(x: 4, y: 5, width: 22, height: 20)
                let path = UIBezierPath(rect: rect)
                path.lineWidth = 2.5
                path.stroke()
            }
        }
    }
}
