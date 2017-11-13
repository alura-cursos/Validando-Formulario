//
//  PickerViewParcela.swift
//  Alura Ingressos
//
//  Created by Alura on 03/11/17.
//  Copyright © 2017 Alura. All rights reserved.
//

import UIKit

protocol PickerViewNumeroDeParcela {
    func pickerViewParcelaSelecionada(parcela:String)
}

class PickerViewParcela: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: - Variáveis
    
    var delegate:PickerViewNumeroDeParcela?
    
    //MARK: - PickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row+1)x"
    }
    
    //MARK: - Delegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if delegate != nil {
            delegate?.pickerViewParcelaSelecionada(parcela: "\(row+1)")
        }
    }
}
