//
//  HomeVC.swift
//  SideMenu
//
//  Created by iOS Wizard on 17/01/23.
//

import UIKit

protocol HomeVCDelegate: AnyObject {
  func didTappedMenuButton()
}

final class HomeVC: UIViewController {
  
  public var delegate: HomeVCDelegate?
 
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    navigationItem.title = "Home"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.tintColor = .label
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"),
                                                       style: .done,
                                                       target: self,
                                                       action: #selector(didTappedMenuButton(_:)))
  }
  
  private func getImage(image: UIImage) {
    
  }
  
  private var buttonImage = true
  
  @objc private func didTappedMenuButton(_ sender: UIButton) {
    delegate?.didTappedMenuButton()
   
    if sender.isSelected {
      navigationItem.leftBarButtonItem?.image = UIImage(systemName: "line.3.horizontal")
    } else {
      navigationItem.leftBarButtonItem?.image = UIImage(systemName: "xmark")
    }

    sender.isSelected.toggle()
  }
  
}

