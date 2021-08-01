//
//  SearchView.swift
//  Pokedex
//
//  Created by Laborit on 25/07/21.
//

import UIKit

class SearchView: UIView {
    @IBOutlet var View: UIView!
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var searchV: UISearchBar!
    var delegate: SearchViewDelegate?
    //always need 2 constructor when used the reusable component
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
   private func initView()  {
    Bundle.main.loadNibNamed("SearchView", owner: self, options: nil)
    View.frame = bounds
    addSubview(View)
    searchV.searchTextField.delegate = self
    }
}

extension SearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text {
            delegate?.searchedText(textSearched: text)
        }
        return true
    }
    
}

//extension SearchView: UISearchBarDelegate {
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        
//    }
//}
