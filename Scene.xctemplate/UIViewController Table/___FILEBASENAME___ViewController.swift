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
import EmptyDataSet_Swift

class ___VARIABLE_sceneName___Cell: UITableViewCell {
  //  @IBOutlet open weak var avatar: UIImageView!
}

protocol ___VARIABLE_sceneName___DisplayLogic: class
{
  func displayModel(viewModel: ___VARIABLE_sceneName___.Model.ViewModel)
}

class ___VARIABLE_sceneName___ViewController: UIViewController, ___VARIABLE_sceneName___DisplayLogic, EmptyDataSetSource, EmptyDataSetDelegate
{
  var interactor: ___VARIABLE_sceneName___BusinessLogic?
  var router: (NSObjectProtocol & ___VARIABLE_sceneName___RoutingLogic & ___VARIABLE_sceneName___DataPassing)?
  @IBOutlet weak var tableview: UITableView!
  fileprivate var currentPage = 0
  fileprivate var numPages = 0
  fileprivate var data = [___VARIABLE_sceneName___.Model.Fetch.Doc]()
  private let useAutosizingCells = true
  var refreshControls   = UIRefreshControl()
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
   
    tableView.emptyDataSetSource = self
    tableView.emptyDataSetDelegate = self
    tableView.emptyDataSetView { [weak self] view in
        guard let `self` = self else { return }
        view.customView(CustomView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)))
            .shouldFadeIn(true)
            .isTouchAllowed(true)
            .isScrollAllowed(true)
            .isImageViewAnimateAllowed(true)
    }
    refreshControls.attributedTitle = NSAttributedString(string: "Pull to refresh")
    refreshControls.addTarget(self, action: #selector(refresh), for: .valueChanged)
    self.tableView.addSubview(refreshControls)
    
    if useAutosizingCells && tableView.responds(to: #selector(getter: UIView.layoutMargins)) {
        tableView.estimatedRowHeight = 88
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    // Set custom indicator
    tableView.infiniteScrollIndicatorView = CustomInfiniteIndicator(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
    
    // Set custom indicator margin
    tableView.infiniteScrollIndicatorMargin = 40
    
    // Set custom trigger offset
    tableView.infiniteScrollTriggerOffset = 500
    
    // Add infinite scroll handler
    tableView.addInfiniteScroll { [weak self] (tableView) -> Void in
        self!.doModel()
        
    }
    
  }
  
  // MARK: Do Model
  
  //@IBOutlet weak var nameTextField: UITextField!
  
  func doModel()
  {
    let request = ___VARIABLE_sceneName___.Model.Request(page:currentPage)
    interactor?.doModel(request: request)
    Timer.scheduledTimer(timeInterval: 2, target: self,   selector: (#selector(stopRefresh)), userInfo: nil, repeats: false)
  }
  
    @objc func stopRefresh(){
        if self.refreshControls.isRefreshing
        {
            self.refreshControls.endRefreshing()
        }
    }
    
  @objc func refresh(_ sender: Any) {
        // Call webservice here after reload tableview.
        doModel()
   }
    
    
  func displayModel(viewModel: ___VARIABLE_sceneName___.Model.ViewModel)
  {
    stopRefresh()
    tableView.finishInfiniteScroll()
    DispatchQueue.main.async {
        //Do UI Code here.
        //Call Google maps methods.
        let storyCount = self.data.count
        let (start, end) = (storyCount, viewModel.data.response!.docs!.count + storyCount)
        let indexPaths = (start..<end).map { return IndexPath(row: $0, section: 0) }
        self.data.append(contentsOf: viewModel.data.response!.docs!)
        self.currentPage += 1
        // update table view
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: indexPaths, with: .automatic)
        self.tableView.endUpdates()
        
    }
  }
    
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return data.count }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as!  ___VARIABLE_sceneName___Cell
    return cell
  }
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){ }
}
