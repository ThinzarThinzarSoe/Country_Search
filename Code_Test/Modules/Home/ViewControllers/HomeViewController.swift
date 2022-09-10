//
//  HomeViewController.swift
//  Code_Test
//
//  Created by Thinzar Soe on 9/8/22.
//

import UIKit
import RxSwift

class HomeViewController : BaseViewController {
    
    @IBOutlet weak var searchView: CardView!
    @IBOutlet weak var lblSearchResult : UILabel!
    @IBOutlet weak var heightConstraintForSearchResultCount : NSLayoutConstraint!
    @IBOutlet weak var tfSearch : UITextField!
    @IBOutlet weak var tblCountry : UITableView!
    @IBOutlet weak var heightConstraintForSearchView : NSLayoutConstraint!
    
    var viewModel : HomeViewModel = HomeViewModel()
    var countryList : [CountryResponse] = []
    var searchedCountryList : [CountryResponse] = []
    var isSearch : Bool?
    var seachKeyWords : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isShowNavigationBar(true)
        setupNavigationTitle(title: "Country List")
    }
    
    override func setupUI() {
        super.setupUI()
        heightForSearchView()
        heightConstraintForSearchResultCount.constant = 0
        lblSearchResult.textColor = .darkGray
        lblSearchResult.font = UIFont.Roboto.Regular.font(size: 15)
        setupTableView()
        self.searchView.isHidden = true
        self.lblSearchResult.isHidden = true
    }
    
    override func viewDidLayoutSubviews(){
        heightForSearchView()
    }
    
    func heightForSearchView() {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            heightConstraintForSearchView.constant = UIScreen.main.bounds.width * 0.07
        } else {
            heightConstraintForSearchView.constant = UIScreen.main.bounds.height * 0.07
        }
    }

    func setupTableView() {
        tblCountry.registerForCells(cells: [
            CountryItemTableViewCell.self])
        tblCountry.separatorStyle = .none
        tblCountry.backgroundColor = .clear
        tblCountry.dataSource = self
        tblCountry.delegate = self
        tblCountry.isHidden = true
        tblCountry.showsVerticalScrollIndicator = false
        tblCountry.bounces = false
        tblCountry.reloadData()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        viewModel.bindViewModel(in: self)
    }
    
    override func bindData() {
        super.bindData()
        viewModel.countryListBehaviorRelay.bind { [weak self] dataList in
            if !dataList.isEmpty {
                self?.countryList = dataList.sorted { $0.name ?? "" < $1.name ?? ""}
                DispatchQueue.main.async {
                    self?.tblCountry.isHidden = false
                    self?.tblCountry.reloadData()
                    self?.lblSearchResult.isHidden = false
                    self?.searchView.isHidden = false
                }
            }
        }.disposed(by: disposableBag)
        
        tfSearch
            .rx.text // Observable property thanks to RxCocoa
            .orEmpty.skip(1)  // Make it non-optional
            .debounce(.seconds(3), scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .bind(onNext: { (text) in
                if self.seachKeyWords != text {
                    self.seachKeyWords = text
                    self.searchedCountryList.removeAll()
                    let indexList = self.countryList.binarySearch(key: text )
                    indexList?.forEach({ index in
                        self.searchedCountryList.append(self.countryList[index])
                    })
                    self.lblSearchResult.text = "Search Result (\(self.searchedCountryList.count))"
                    self.heightConstraintForSearchResultCount.constant = UIScreen.main.bounds.height * 0.08
                    self.tblCountry.reloadData()
                }
        }).disposed(by: disposableBag)
        
        viewModel.isNoInternetPublishRelay.bind { isConnect in
            if isConnect {
                self.isShowNoDataAndInternet(isShow: true)
                DispatchQueue.main.async {
                    self.searchView.isHidden = false
                    self.tblCountry.isHidden = false
                    self.lblSearchResult.isHidden = false
                    self.heightConstraintForSearchResultCount.constant = 0
                }
            }
        }.disposed(by: disposableBag)
        
        viewModel.isSeverErrorPublishRelay.bind { isServerError in
            if isServerError {
                self.isShowNoDataAndInternet(isShow: true , isServerError: true)
                DispatchQueue.main.async {
                    self.searchView.isHidden = false
                    self.tblCountry.isHidden = false
                    self.lblSearchResult.isHidden = false
                    self.heightConstraintForSearchResultCount.constant = 0
                }
            }
        }.disposed(by: disposableBag)
    }
    
    override func reloadScreen() {
        super.reloadScreen()
        fetchData()
    }
    
    func fetchData() {
        seachKeyWords = ""
        countryList.removeAll()
        searchedCountryList.removeAll()
        self.viewModel.getCountryList()
    }
}

extension HomeViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.seachKeyWords.isEmpty ? countryList.count :searchedCountryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getCountryItemTableCell(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !countryList.isEmpty || searchedCountryList.isEmpty {
            HomeScreen.HomeVC.navigateToMapViewVC(self.seachKeyWords.isEmpty ? countryList[indexPath.row] : searchedCountryList[indexPath.row]).show()
        }
    }
}

extension HomeViewController {
    private func getCountryItemTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tblCountry.dequeReuseCell(type: CountryItemTableViewCell.self, indexPath: indexPath)
        cell.setupCell(data: self.seachKeyWords.isEmpty ? countryList[indexPath.row] : searchedCountryList[indexPath.row])
        return cell
    }
}
