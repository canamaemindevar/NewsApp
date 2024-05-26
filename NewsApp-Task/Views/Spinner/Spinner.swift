//
//  Spinner.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 26.05.2024.
//

import SwiftUI

class Spinner {

    static var spinner: UIActivityIndicatorView?
    static var style: UIActivityIndicatorView.Style = .whiteLarge
    static var baseBackColor = UIColor.black.withAlphaComponent(0.4)
    static var baseColor: UIColor = .blue

    class func start(style: UIActivityIndicatorView.Style = style, backColor: UIColor = baseBackColor, baseColor: UIColor = baseColor) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
            if spinner == nil, let window = UIApplication.shared.keyWindow {
                let frame = UIScreen.main.bounds
                spinner = UIActivityIndicatorView(frame: frame)
                spinner!.backgroundColor = backColor
                spinner!.style = style
                spinner?.color = baseColor
                window.addSubview(spinner!)
                spinner!.startAnimating()
            }
        })
    }

    class func stop() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
            if spinner != nil {
                spinner!.stopAnimating()
                spinner!.removeFromSuperview()
                spinner = nil
            }
        })
    }
}

