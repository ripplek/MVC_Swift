//
//  ReactiveCollectionViewCell.swift
//  conjoined_hospital
//
//  Created by 张坤 on 2017/7/29.
//  Copyright © 2017年 searainbow. All rights reserved.
//

import UIKit
import RxSwift

class ReactiveCollectionViewCell: UICollectionViewCell {
    public private(set) var reuseDisposeBag = DisposeBag()
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        reuseDisposeBag = DisposeBag()
    }
}
