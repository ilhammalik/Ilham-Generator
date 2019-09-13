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

enum ___VARIABLE_sceneName___
{
  // MARK: Use cases
  
  enum Model
  {
    struct Request {}
    struct Response : Codable
    {
        var data: ___VARIABLE_sceneName___.Model.Fetch.Data
    }
    
    struct ViewModel
    {
        var data: ___VARIABLE_sceneName___.Model.Fetch.Data
    }

    enum Fetch {
        struct Data: Codable {
            
        }
    }
  }
}
