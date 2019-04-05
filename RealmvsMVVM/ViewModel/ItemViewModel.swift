//
//  ItemViewModel.swift
//  RealmvsMVVM
//
//  Created by win on 4/5/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift

class ItemViewModel: NSObject {
    var realm : Realm!
    var disposed = DisposeBag()
    
    var searchInput = Variable<String>("")
    var result = Variable<[Item]>([])
    
    var arrayItem: Results<Item>{
        get{
            return realm.objects(Item.self)
        }
    }
    override init() {
        super.init()
        realm = try! Realm()
        getData()
    }
    func getData(){
        self.searchInput
            .asObservable()
            .filter { !$0.isEmpty }
            .subscribe(onNext: {[weak self] text in
                self!.result.value = self!.arrayItem.filter{ $0.code!.hasPrefix(text) }
                })
        .disposed(by: disposed)
    }
}
