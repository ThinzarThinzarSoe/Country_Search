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
    var countryList : [CityVO] = []
    var searchedCountryList : [CityVO] = []
    var isSearch : Bool = false
    var seachKeyWords : String = ""
    var trie = CityTrie()
    
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
                self?.countryList = dataList
                self?.countryList.forEach({ city in
                    self?.trie.add(city)
                })
            }
            DispatchQueue.main.async {
                self?.tblCountry.isHidden = dataList.isEmpty
                self?.tblCountry.reloadData()
                self?.lblSearchResult.isHidden = dataList.isEmpty
                self?.searchView.isHidden = dataList.isEmpty
            }
        }.disposed(by: disposableBag)
        
        tfSearch?.rx.text.bind { [weak self] text in
            if let text = text, !text.isEmpty {
                self?.viewModel.keywordDataBehaviorRelay.accept(text)
            } else {
                self?.isSearch = false
                self?.seachKeyWords = text ?? ""
                self?.tblCountry.reloadData()
                self?.isShowNoDataAndInternet(isShow: false)
                self?.heightConstraintForSearchResultCount.constant = 0
                self?.lblSearchResult.isHidden = true
            }
        }.disposed(by: disposableBag)
        
        viewModel.keywordDataBehaviorRelay // Observable property thanks to RxCocoa
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .bind(onNext: { (text) in
                if self.seachKeyWords != text {
                    self.isSearch = true
                    self.seachKeyWords = text
                    self.searchedCountryList.removeAll()
                    self.searchedCountryList = self.trie.findCitiesWithPrefix(prefix: self.seachKeyWords).sorted { $0.name ?? "" < $1.name ?? ""}
                    self.lblSearchResult.text = "Search Result (\(self.searchedCountryList.count))"
                    self.heightConstraintForSearchResultCount.constant = UIScreen.main.bounds.height * 0.08
                    self.lblSearchResult.isHidden = self.searchedCountryList.isEmpty
                    if self.searchedCountryList.isEmpty {
                        self.isShowNoDataAndInternet(isShow: true)
                    }
                }
                self.tblCountry.reloadData()
        }).disposed(by: disposableBag)
        
        viewModel.isNoDataPublishRealy.bind {
            self.showErrorView($0)
        }.disposed(by: disposableBag)
        
        viewModel.isSeverErrorPublishRelay.bind {
            self.showErrorView($0)
        }.disposed(by: disposableBag)
        
        viewModel.isNoInternetPublishRelay.bind {
            self.showErrorView($0)
        }.disposed(by: disposableBag)
    }
    
    func showErrorView(_ isShow : Bool) {
        DispatchQueue.main.async {
            self.tblCountry.isHidden = isShow
            self.isShowNoDataAndInternet(isShow: isShow)
            self.searchView.isHidden = isShow
            self.tblCountry.isHidden = isShow
            self.lblSearchResult.isHidden = isShow
            self.heightConstraintForSearchResultCount.constant = 0
        }
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
        return isSearch ? searchedCountryList.count :countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getCountryItemTableCell(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !countryList.isEmpty || searchedCountryList.isEmpty {
            HomeScreen.HomeVC.navigateToMapViewVC(isSearch ? searchedCountryList[indexPath.row] : countryList[indexPath.row]).show()
        }
    }
}

extension HomeViewController {
    private func getCountryItemTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tblCountry.dequeReuseCell(type: CountryItemTableViewCell.self, indexPath: indexPath)
        cell.setupCell(data: isSearch ? searchedCountryList[indexPath.row] : countryList[indexPath.row])
        return cell
    }
}
