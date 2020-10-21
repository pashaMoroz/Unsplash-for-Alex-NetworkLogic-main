//
//  MainVCControlCell.swift
//  UnsplashApp
//
//  Created by Mykhailo Romanovskyi on 15.08.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//
protocol ChangeCellViewProtocol: class {
    func buttonAction(cell: MainVCControlCell, tag: Int)
}


import UIKit

class MainVCControlCell: UICollectionViewCell {
    
    let oneInRowButton = UIButton()
    let twoInRowButton = UIButton()
    
    //Три новые кнопки
    let historyButton = UIButton(type: .system)
    let athleticsButton = UIButton(type: .system)
    let technologyButton = UIButton(type: .system)

    weak var refreshDelegate: MainViewControllerUpdateDataDelegate?
    
    static let reuseId = "mainControlCell"
    
    weak var delegat: ChangeCellViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElemenst()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: @objc methods

    
    @objc private func buttonPressed(_ sender: UIButton) {
        delegat?.buttonAction(cell: self, tag: sender.tag)
    }
    
    @objc private func filterButtonPressed(_ sender: UIButton) {

        changeTitleButtonColor(tag: sender.tag)

        switch sender.tag {
        case 0:
            refreshDelegate?.refreshData(idTopic: UserSettings.History)
        case 1:
            refreshDelegate?.refreshData(idTopic: UserSettings.Athletics)
        case 2:
            refreshDelegate?.refreshData(idTopic: UserSettings.Technology)
        default:
            break
        }

    }
}

//MARK: Setup Elements
extension MainVCControlCell {
    private func setupElemenst() {


        let styleSegment = UISegmentedControl(items: [UIImage(systemName: "rectangle.grid.1x2")!,
                                                      UIImage(systemName: "rectangle.grid.2x2")!
        ])
        styleSegment.tintColor = .brown
        styleSegment.backgroundColor = .none
        
        oneInRowButton.setImage(UIImage(systemName: "rectangle.grid.1x2.fill"), for: .normal)
        oneInRowButton.tintColor = .black
        oneInRowButton.tag = 0
        oneInRowButton.addTarget(self,action: #selector(buttonPressed), for: .touchUpInside)
        
        twoInRowButton.setImage(UIImage(systemName: "rectangle.grid.2x2"), for: .normal)
        twoInRowButton.tintColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
        twoInRowButton.tag = 1
        twoInRowButton.addTarget(self,action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        
        buttonCreation()
        let firstStack = UIStackView(arrangedSubviews: [historyButton, athleticsButton, technologyButton])
        firstStack.axis = .horizontal
        firstStack.spacing = 14
        
        let secondStack = UIStackView(arrangedSubviews: [oneInRowButton, twoInRowButton])
        secondStack.axis = .horizontal
        secondStack.spacing = 11
        
        let stack = UIStackView(arrangedSubviews: [firstStack, secondStack])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    private func buttonCreation() {

        historyButton.setTitle("History", for: .normal)
        athleticsButton.setTitle("Athletics", for: .normal)
        technologyButton.setTitle("Technology", for: .normal)
        
        historyButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        athleticsButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        technologyButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 16)

        historyButton.tag = 0
        athleticsButton.tag = 1
        technologyButton.tag = 2

        changeTitleButtonColor(tag: 0)
        
        historyButton.addTarget(self, action: #selector(filterButtonPressed(_:)), for: .touchUpInside)
        athleticsButton.addTarget(self, action: #selector(filterButtonPressed(_:)), for: .touchUpInside)
        technologyButton.addTarget(self, action: #selector(filterButtonPressed(_:)), for: .touchUpInside)
    }

    //MARK: Setup Buttons Color
     func changeTitleButtonColor(tag: Int) {

        let colorDeselect = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
        let colorSelect = UIColor.black

        let collectionOfButoons: [UIButton] = [historyButton, athleticsButton, technologyButton]

        collectionOfButoons.forEach { (selectButton) in

            selectButton.tintColor = selectButton.tag == tag ? colorSelect : colorDeselect
        }

    }
}
