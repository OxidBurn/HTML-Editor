//
//  ViewController.swift
//  HTML Editor
//
//  Created by Nikolay Chaban on 22.05.2020.
//  Copyright © 2020 Nikolay Chaban. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Outlets -
    @IBOutlet weak var editorView: UITextView!
    
    //MARK: - Properties -
    let htmlService: HTMLService = HTMLServiceImp()
    
    //MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    //MARK: - Actions -
    @IBAction func didClickOpenFile(_ sender: Any) {
        editorView.attributedText = htmlService.loadLocalHTMLFile()
    }
    
    
    @IBAction func didClickSave(_ sender: UIButton) {
        htmlService.saveHTMLFile(editorView.attributedText)
    }
}

