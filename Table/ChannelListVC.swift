//
//  ChannelListVC.swift
//  Table
//
//  Created by Keval Patel on 8/6/19.
//  Copyright © 2019 Keval Patel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ChannelListVC: UIViewController {
    
    @IBOutlet weak var tblChannelList: UITableView!
    let channels: BehaviorRelay<[ChannelViewModel]> = BehaviorRelay(value: [])
    var lastContentOffset: CGFloat = 0
    
    enum urlStrings : String{
        case getChannel = "https://raw.githubusercontent.com/jvanaria/jvanaria.github.io/master/channels.json"
    }
    enum constants: String {
        case unknown = "Unknown"
        case titleDJ = "DJ"
        case titleSelect = "Select"
        case titleCancel = "Cancel"
        case all = "All"
        case tblChannelsAccessibility = "table--channlesTableView"
    }
    let utilityQueue = DispatchQueue.global(qos: .utility)
    let mainQueue = DispatchQueue.main
    var channelViewModels = [ChannelViewModel]()
    var djList = [constants.all.rawValue]
    var disposeBag = DisposeBag()


    override func viewDidLoad() {
        channels.bind(to: tblChannelList.rx.items(cellIdentifier: "ListCell", cellType: ListCell.self)) { row, viewmodel, cell in
                cell.channelViewModel = viewmodel
//                cell.lblName?.text = "\(viewmodel.dj)"
            }.disposed(by: disposeBag)
        getChannelData()
    }
    
    //MARK: - getData BY calling Web Service
    func getChannelData() {
        
        //Call WebService
        WebService.shared.fetchArticles(urlStrings.getChannel.rawValue, utilityQueue, mainQueue) { (channels, error) in
         
            //Use guard
            //Check For Error
            if let error = error{
                //Pop Up Error Alert
//                self.errorAlert("Couldn't Find Data", error.localizedDescription)
            }
            //Mapping Models to channelViewModels Array
            self.channelViewModels = channels?.map({return ChannelViewModel($0)}) ?? []

            self.channels.accept(channels?.map({return ChannelViewModel($0)}) ?? [])
            self.djList.append(contentsOf: self.channelViewModels.map({
                if $0.dj == ""{
                    return constants.unknown.rawValue
                }
                return $0.dj}))
            print(self.djList)
            //Remove Duplicates from DjList
//            self.djList = self.djList.removeDuplicates()
            
//            self.tblChannels.reloadData()
            
        }
    }
}
