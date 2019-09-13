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

import UIKit

protocol ___VARIABLE_sceneName___PresentationLogic
{
  func presentModel(response: ___VARIABLE_sceneName___.Model.Response)
}

class ___VARIABLE_sceneName___Presenter: ___VARIABLE_sceneName___PresentationLogic
{
  weak var viewController: ___VARIABLE_sceneName___DisplayLogic?
  
  // MARK: Do Model
  
  func presentModel(response: ___VARIABLE_sceneName___.Model.Response)
  {
    let viewModel = ___VARIABLE_sceneName___.Model.ViewModel(data: response.data)
    viewController?.displayModel(viewModel: viewModel)
  }
}
