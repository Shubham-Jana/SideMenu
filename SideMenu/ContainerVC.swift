//
//  ViewController.swift
//  SideMenu
//
//  Created by iOS Wizard on 17/01/23.
//

import UIKit

private enum MenuState {
  case opened, closed
}

final class ContainerVC: UIViewController {
  
  private let homeVC = HomeVC()
  private let menuVC = MenuVC()
  private var navVC: UINavigationController?
  private var menuState: MenuState = .closed
 
  override func viewDidLoad() {
    super.viewDidLoad()
    addChildVC()
  }
  
  private func addChildVC() {
      // Menu
    menuVC.delegate = self
    addChild(menuVC)
    view.addSubview(menuVC.view)
    menuVC.didMove(toParent: self)
    
      // Home
    homeVC.delegate = self
    let navVC = UINavigationController(rootViewController: homeVC)
    addChild(navVC)
    view.addSubview(navVC.view)
    navVC.didMove(toParent: self)
    self.navVC = navVC
  }
  
  private func toggleMenu(onCompletion: (() -> Void)?) {
    switch menuState {
    case .closed:
      UIView.animate(withDuration: 0.6,
                     delay: 0,
                     usingSpringWithDamping: 0.8,
                     initialSpringVelocity: 0,
                     options: .curveEaseInOut) {
        self.navVC?.view.frame.origin.x = 260
        self.homeVC.view.backgroundColor = .systemGray2
      } completion: { [weak self] done in
        guard let self else { return }
        if done {
          self.menuState = .opened
        }
      }
      
    case .opened:
      UIView.animate(withDuration: 0.6,
                     delay: 0,
                     usingSpringWithDamping: 0.8,
                     initialSpringVelocity: 0,
                     options: .curveEaseInOut) {
        self.navVC?.view.frame.origin.x = 0
        self.homeVC.view.backgroundColor = .systemBackground
      } completion: { [weak self] done in
        guard let self else { return }
        if done {
          self.menuState = .closed
          DispatchQueue.main.async {
            onCompletion?()
          }
        }
      }
    }
  }

}


extension ContainerVC: HomeVCDelegate {
  func didTappedMenuButton() {
   toggleMenu(onCompletion: nil)
  }
}


extension ContainerVC: MenuVCDelegate {
  func didSelect(menuItem: MenuOptions) {
    toggleMenu {
      switch menuItem {
      case .home:
        break
      case .iPhone:
        break
      case .AirPods:
        break
      case .MacBook_Pro:
        break
      case .iPad:
        break
      case .Apple_Watch:
        break
      case .Homepod:
        break
      }
    }
  }
}


