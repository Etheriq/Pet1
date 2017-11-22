//
//  DropDownButton.swift
//  pet1
//
//  Created by Yuriy T on 22.11.2017.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import UIKit

protocol DropDownOptionsProtocol {
    func dropDownOptionTitle() -> String
    func dropDownOptionValue() -> Int
}
protocol DropDownSelectedOptionDelegate: class {
    func dropDownSelected(withItem: DropDownOptionsProtocol)
}

class DropDownButton: UIButton {
    
    var dropDownView = DropDownView()
    weak var selectedDelegate: DropDownSelectedOptionDelegate?
    private var dropViewHeight = NSLayoutConstraint()
    private var isOpen = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - Configuration
    private func configure() {
        dropDownView = DropDownView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        dropDownView.selectedDelegate = self
        dropDownView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func didMoveToSuperview() {
        configure()
        self.superview?.addSubview(dropDownView)
        self.superview?.bringSubview(toFront: dropDownView)
        
        dropDownView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dropDownView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dropDownView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        dropViewHeight = dropDownView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    // MARK: - Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen {
            closeDropDown()
        } else {
            openDropDown()
        }
    }
    
    fileprivate func openDropDown() {
        isOpen = true
        
        NSLayoutConstraint.deactivate([dropViewHeight])
        if dropDownView.tableView.contentSize.height > 150 {
            dropViewHeight.constant = 150
        } else {
            dropViewHeight.constant = dropDownView.tableView.contentSize.height
        }
        NSLayoutConstraint.activate([dropViewHeight])
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.dropDownView.layoutIfNeeded()
            self.dropDownView.center.y += self.dropDownView.frame.height / 2
        }, completion: nil)
    }
    
    fileprivate func closeDropDown() {
        isOpen = false
        
        NSLayoutConstraint.deactivate([dropViewHeight])
        dropViewHeight.constant = 0
        NSLayoutConstraint.activate([dropViewHeight])
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.dropDownView.center.y -= self.dropDownView.frame.height / 2
            self.dropDownView.layoutIfNeeded()
        }, completion: { _ in
            self.dropDownView.tableView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: false)
        })
    }
}

extension DropDownButton: DropDownSelectedOptionDelegate {
    func dropDownSelected(withItem: DropDownOptionsProtocol) {
        setTitle(withItem.dropDownOptionTitle(), for: .normal)
        closeDropDown()
        selectedDelegate?.dropDownSelected(withItem: withItem)
    }
}

class DropDownView: UIView {
    var dropDownOptions = [DropDownOptionsProtocol]()
    var dropDownViewBackgroundColor = UIColor.darkGray
    var dropDownOptionsTitleColor = UIColor.white
    var dropDownOptionsTitleFont = UIFont.systemFont(ofSize: 13)
    
    let tableView = UITableView()
    var selectedDelegate: DropDownSelectedOptionDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.delegate = self
        tableView.dataSource = self
        backgroundColor = dropDownViewBackgroundColor
        tableView.bounces = false
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension DropDownView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        selectedDelegate.dropDownSelected(withItem: dropDownOptions[indexPath.row])
    }
}

extension DropDownView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "dropDownCell")
        cell.textLabel?.text = dropDownOptions[indexPath.row].dropDownOptionTitle()
        cell.backgroundColor = dropDownViewBackgroundColor
        cell.textLabel?.textColor = dropDownOptionsTitleColor
        cell.textLabel?.font = dropDownOptionsTitleFont
        
        return cell
    }
}
