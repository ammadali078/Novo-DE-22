//
//  PdfDetailViewController.swift
//  E-detailer
//
//  Created by Ammad on 8/31/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit
class PdfDetailViewController : UIViewController {
    var pdf: String = ""
    @IBOutlet weak var pdfWebViewer: UIWebView!
    
    override func viewDidLoad() {
        let url : NSURL! = NSURL(string: pdf.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)
        pdfWebViewer.loadRequest(NSURLRequest(url: url as URL) as URLRequest)
    }
    @IBAction func onBackClick(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
