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

class ___VARIABLE_sceneName___Cell: UICollectionViewCell {
  //  @IBOutlet open weak var avatar: UIImageView!
}

protocol ___VARIABLE_sceneName___DisplayLogic: class
{
  func displayModel(viewModel: ___VARIABLE_sceneName___.Model.ViewModel)
}

class ___VARIABLE_sceneName___ViewController: UICollectionViewController, ___VARIABLE_sceneName___DisplayLogic
{
  var interactor: ___VARIABLE_sceneName___BusinessLogic?
  var router: (NSObjectProtocol & ___VARIABLE_sceneName___RoutingLogic & ___VARIABLE_sceneName___DataPassing)?
  fileprivate var currentPage = 0
  fileprivate var numPages = 0
  fileprivate var data = [___VARIABLE_sceneName___.Model.Fetch.Doc]()
  private let useAutosizingCells = true

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
    if useAutosizingCells && tableView.responds(to: #selector(getter: UIView.layoutMargins)) {
        tableView.estimatedRowHeight = 88
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    // Set custom indicator
    collectionView.infiniteScrollIndicatorView = CustomInfiniteIndicator(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
    
    // Set custom indicator margin
    collectionView.infiniteScrollIndicatorMargin = 40
    
    // Set custom trigger offset
    collectionView.infiniteScrollTriggerOffset = 500
    
    // Add infinite scroll handler
    collectionView.addInfiniteScroll { [weak self] (scrollView) -> Void in
        self!.doModel()
        
    }

    collectionView.beginInfiniteScroll(true)
  }
  
  // MARK: Do Model
  //@IBOutlet weak var nameTextField: UITextField!
  
  func doModel()
  {
    let request = ___VARIABLE_sceneName___.Model.Request(page:currentPage)
    interactor?.doModel(request: request)
    collectionView.finishInfiniteScroll()
  }
  
  func displayModel(viewModel: ___VARIABLE_sceneName___.Model.ViewModel)
  {
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
        self.collectionView?.performBatchUpdates({ () -> Void in
            self.collectionView?.insertItems(at: indexPaths)
        }, completion: { (finished) -> Void in
            completionHandler?()
        });
        
    }
  }
    
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return 0 }
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
  {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "cell", for: indexPath) as! ___VARIABLE_sceneName___Cell
    return cell
  }
    
}
