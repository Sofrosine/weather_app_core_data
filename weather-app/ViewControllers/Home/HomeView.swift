//
//  HomeView.swift
//  weather-app
//
//  Created by Soultan Muhammad Albar on 12/06/22.
//

import UIKit

class HomeView: UIView {
    
    var searchTextField: UITextField {
        searchInputView
    }
    
    var cityLabel: UILabel {
        cityLabelView
    }
    
    private lazy var searchInputView: UITextField = {
        let searchInputView = UITextField()
        searchInputView.translatesAutoresizingMaskIntoConstraints = false
        searchInputView.placeholder = "Type the city name"
        searchInputView.setBorderWidthColorRadius(1, UIColor.lightGray.cgColor, 8)
        searchInputView.addPaddingLeft(8)
        searchInputView.addPaddingRight(8)
        
        return searchInputView
    }()
    
    private lazy var cityLabelView: UILabel = {
        let cityLabelView = UILabel()
        cityLabelView.translatesAutoresizingMaskIntoConstraints = false
        cityLabelView.numberOfLines = 0
        cityLabelView.text = ""
        cityLabelView.textAlignment = .center
        
        return cityLabelView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchInputView, cityLabelView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        stackView.spacing = 32
        
        return stackView
    }()
    
    private func setupSubView() {
        addSubview(stackView)
    }
    
    private func setupView() {
        setupSubView()
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            searchInputView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    convenience init() {
        self.init(frame: .zero)
        self.setupView()
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }

}
