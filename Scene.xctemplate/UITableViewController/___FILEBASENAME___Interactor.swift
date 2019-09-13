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

protocol ___VARIABLE_sceneName___BusinessLogic
{
  func doModel(request: ___VARIABLE_sceneName___.Model.Request)
}

protocol ___VARIABLE_sceneName___DataStore
{
  //var name: String { get set }
    var data: ___VARIABLE_sceneName___.Model.Fetch.Data! { get set }
}

class ___VARIABLE_sceneName___Interactor: ___VARIABLE_sceneName___BusinessLogic, ___VARIABLE_sceneName___DataStore
{
  var presenter: ___VARIABLE_sceneName___PresentationLogic?
  var worker: ___VARIABLE_sceneName___Worker?

  var data: ___VARIABLE_sceneName___.Model.Fetch.Data!

  // MARK: Do Model
  
    func doModel(request: ___VARIABLE_sceneName___.Model.Request)
  {
    worker = ___VARIABLE_sceneName___Worker()
    worker?.fetch(request: request) { result  in
        if result != nil {
            self.data = result!
            let response = ___VARIABLE_sceneName___.Model.Response(data: result!)
            self.presenter?.presentModel(response: response)
        }
    }
  }
}
