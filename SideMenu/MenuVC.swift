  //
  //  MenuVC.swift
  //  SideMenu
  //
  //  Created by iOS Wizard on 17/01/23.
  //

import UIKit

protocol MenuVCDelegate: AnyObject {
  func didSelect(menuItem: MenuOptions)
}

enum MenuOptions: String, CaseIterable {
  case home = "Home"
  case iPhone = "iPhone"
  case AirPods = "AirPods"
  case MacBook_Pro = "MacBook Pro"
  case iPad = "iPad"
  case Apple_Watch = "Apple Watch"
  case Homepod = "HomePod"

  var imageName: String {
    switch self {
    case .home:
      return "house.fill"
    case .iPhone:
      return "iphone"
    case .AirPods:
      return "airpodspro"
    case .MacBook_Pro:
      return "laptopcomputer"
    case .iPad:
      return "ipad"
    case .Apple_Watch:
      return "applewatch"
    case .Homepod:
      return "homepod.fill"
    }
  }
}
  
  final class MenuVC: UIViewController {
    
    private let CELL_ID = String(describing: MenuVC.self)
    public weak var delegate: MenuVCDelegate?
    
    private lazy var tableView: UITableView = {
      let tableView = UITableView()
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_ID)
      tableView.delegate = self
      tableView.dataSource = self
      tableView.separatorColor = .label
      return tableView
    }()
    
    override func viewDidLoad() {
      super.viewDidLoad()
      view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      tableView.frame = view.bounds
    }
    
  }
  
  extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID,  for: indexPath)
      
      var contentConfig = cell.defaultContentConfiguration()
      contentConfig.text = MenuOptions.allCases[indexPath.row].rawValue
      contentConfig.textProperties.color = .label
      contentConfig.textProperties.font = .monospacedDigitSystemFont(ofSize: 14, weight: .semibold)
      contentConfig.secondaryText = "#" + "My Devices"
      contentConfig.secondaryTextProperties.color = .secondaryLabel
      contentConfig.secondaryTextProperties.font = .systemFont(ofSize: 14)
      contentConfig.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
      contentConfig.imageProperties.tintColor = .label
      
      cell.contentConfiguration = contentConfig
      return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      let item = MenuOptions.allCases[indexPath.row]
      delegate?.didSelect(menuItem: item)
    }
    
  }
  

