//
//  Localizacao.swift
//  Alura Ingressos
//
//  Created by Alura on 01/11/17.
//  Copyright © 2017 Alura. All rights reserved.
//

import UIKit

class Localizacao: NSObject {
    
    var logradouro = ""
    var bairro = ""
    var cidade = ""
    var uf = ""
    
    init(_ dicionario:Dictionary<String, String>) {
        logradouro = dicionario["logradouro"] ?? ""
        bairro = dicionario["bairro"] ?? ""
        cidade = dicionario["localidade"] ?? ""
        uf = dicionario["uf"] ?? ""
    }
    
    class func serializaObjeto(dicionario:Dictionary<String, String>) -> Localizacao {
        let localizacao = Localizacao(dicionario)
        
        return localizacao
    }

}
