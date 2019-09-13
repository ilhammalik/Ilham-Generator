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
import Alamofire
import Toaster

class ___VARIABLE_sceneName___Worker
{
    var headers: HTTPHeaders = [:]
    var params: Parameters = [:]
    
    func fetch(request: ___VARIABLE_sceneName___.Model.Request, completionHandler: @escaping(___VARIABLE_sceneName___.Model.Fetch.Data?) -> Void) {
        if Connectivity.isConnectedToInternet() {
            Alamofire.request("", method: .get, parameters:  self.params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                print(response.value as Any)
                
                if response.response?.statusCode == 200 {
                    let json = try? JSONDecoder().decode(___VARIABLE_sceneName___.Model.Fetch.Data.self, from: response.data!)
                    completionHandler(json)
                    setAlert(title: NSLocalizedString("Success", comment: ""), message:"", style: .success)
                }
                
                if response.response?.statusCode == 400 || response.response?.statusCode == 422 {
                    Toast(text: "Ops something wrong", delay: 0, duration: 1).show()
                }
            }
        }else {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
           setAlert(title: NSLocalizedString("Perhatian", comment: ""), message: NSLocalizedString("Tidak ada koneksi internet", comment: ""), style: .danger)
        }
    }

}
