//
//  Cell_custom.swift
//  jsonCurrency
//
//  Created by Igor Abovyan on 03.12.2021.
//

import UIKit

class Cell_custom: UITableViewCell {
    
    private static let imageHeight: CGFloat = 40
    
    static var height: CGFloat {
        let h = CGFloat.offset * 2 + imageHeight
        return h
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageView?.contentMode = .scaleAspectFill
        imageView?.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Cell_custom {
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame.size.width = Cell_custom.imageHeight
        imageView?.frame.size.height = Cell_custom.imageHeight
        imageView?.frame.origin.x = CGFloat.offset
        imageView?.frame.origin.y = CGFloat.offset
        textLabel?.frame.origin.x = imageView!.frame.origin.x + CGFloat.offset + imageView!.frame.size.width
    }
}
