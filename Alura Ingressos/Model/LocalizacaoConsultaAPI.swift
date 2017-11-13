//
//  LocalizacaoConsultaAPI.swift
//  Alura Ingressos
//
//  Created by Alura on 01/11/17.
//  Copyright © 2017 Alura. All rights reserved.
//

import UIKit
import Alamofire

class LocalizacaoConsultaAPI: NSObject {
    
    //MARK: - GET
    
    func consultaViaCepAPI(cep:String, sucesso:@escaping(_ localizacao:Localizacao) -> Void, falha:@escaping(_ error:Error) -> Void) {
        Alamofire.request("https://viacep.com.br/ws/\(cep)/json/", method: .get).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                if let resultado = response.result.value as? Dictionary<String, String> {
                    sucesso(Localizacao(resultado))
                }
            case .failure:
                falha(response.error!)
            }
        }
    }
}
