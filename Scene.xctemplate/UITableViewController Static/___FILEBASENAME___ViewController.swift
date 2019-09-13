//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
///  Modify By:  * Ilham Malik Ibrahim
//              * ilhammalik19@gmail.com
//              * https://github.com/ilhammalik11
//

import UIKit

protocol ___VARIABLE_sceneName___DisplayLogic: class
{
  func displayModel(viewModel: ___VARIABLE_sceneName___.Model.ViewModel)
}

class ___VARIABLE_sceneName___ViewController: UITableViewController, ___VARIABLE_sceneName___DisplayLogic
{
  var interactor: ___VARIABLE_sceneName___BusinessLogic?
  var router: (NSObjectProtocol & ___VARIABLE_sceneName___RoutingLogic & ___VARIABLE_sceneName___DataPassing)?
  
  // MARK: Setup
     override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    

  private func setup()
  {
    let viewController = self
    let interactor = ___VARIABLE_sceneName___Interactor()
    let presenter = ___VARIABLE_sceneName___Presenter()
    let router = ___VARIABLE_sceneName___Router()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing

  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doModel()
 
  }
  
  // MARK: Do Model
  
  //@IBOutlet weak var nameTextField: UITextField!
  
  func doModel()
  {
    let request = ___VARIABLE_sceneName___.Model.Request()
    interactor?.doModel(request: request)
  }
  
  func displayModel(viewModel: ___VARIABLE_sceneName___.Model.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
}
