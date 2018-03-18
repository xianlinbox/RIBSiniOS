//
//  OffGameViewController.swift
//  TicTacToe
//
//  Created by Xianning Liu  on 10/03/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol OffGamePresentableListener: class {
  // TODO: Declare properties and methods that the view controller can invoke to perform
  // business logic, such as signIn(). This protocol is implemented by the corresponding
  // interactor class.
}

final class OffGameViewController: UIViewController, OffGamePresentable, OffGameViewControllable {
  
  weak var listener: OffGamePresentableListener?
  private let player1Name: String
  private let player2Name: String
 
  required init?(coder aDecoder: NSCoder) {
    fatalError("Method is not supported")
  }
  
  init(player1Name: String, player2Name: String) {
    self.player1Name = player1Name
    self.player2Name = player2Name
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.yellow
//    buildStartButton()
    buildPlayerLabels()
  }
  
  private func buildPlayerLabels() {
    let labelBuilder: (UIColor, String) -> UILabel = { (color: UIColor, text: String) in
      let label = UILabel()
      label.font = UIFont.boldSystemFont(ofSize: 35)
      label.backgroundColor = UIColor.clear
      label.textColor = color
      label.textAlignment = .center
      label.text = text
      return label
    }
    
    let player1Label = labelBuilder(UIColor.blue, player1Name)
    view.addSubview(player1Label)
    player1Label.snp.makeConstraints { (maker: ConstraintMaker) in
      maker.top.equalTo(self.view).offset(70)
      maker.leading.trailing.equalTo(self.view).inset(20)
      maker.height.equalTo(40)
    }
    
    let vsLabel = UILabel()
    vsLabel.font = UIFont.systemFont(ofSize: 25)
    vsLabel.backgroundColor = UIColor.clear
    vsLabel.textColor = UIColor.darkGray
    vsLabel.textAlignment = .center
    vsLabel.text = "vs"
    view.addSubview(vsLabel)
    vsLabel.snp.makeConstraints { (maker: ConstraintMaker) in
      maker.top.equalTo(player1Label.snp.bottom).offset(10)
      maker.leading.trailing.equalTo(player1Label)
      maker.height.equalTo(20)
    }
    
    let player2Label = labelBuilder(UIColor.red, player2Name)
    view.addSubview(player2Label)
    player2Label.snp.makeConstraints { (maker: ConstraintMaker) in
      maker.top.equalTo(vsLabel.snp.bottom).offset(10)
      maker.height.leading.trailing.equalTo(player1Label)
    }
  }
}

