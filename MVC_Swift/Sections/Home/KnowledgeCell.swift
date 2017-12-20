//
//  KnowledgeCell.swift
//  conjoined_hospital
//
//  Created by 张坤 on 2017/8/1.
//  Copyright © 2017年 searainbow. All rights reserved.
//

import UIKit

class KnowledgeCell: ReactiveTableViewCell {
    
    static var rowheight: CGFloat {
        return 87
    }

    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!

}
