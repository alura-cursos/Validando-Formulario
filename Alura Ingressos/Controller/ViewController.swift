//
//  ViewController.swift
//  Alura Ingressos
//
//  Created by Alura on 30/10/17.
//  Copyright © 2017 Alura. All rights reserved.
// 45033687026

import UIKit
import Money

class ViewController: UIViewController, PickerViewMesSelecionado, PickerViewAnoSelecionado, PickerViewNumeroDeParcela {
    
    //MARK: - Outlets
    
    @IBOutlet weak var imagemBanner: UIImageView!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var scrollViewPrincipal: UIScrollView!
    @IBOutlet weak var labelValorDasParcelas: UILabel!
    
    //MARK: - Variáveis
    
    var pickerViewMes = PickerViewMes()
    var pickerViewAno = PickerViewAno()
    var pickerViewParcela = PickerViewParcela()
    var valorDoIngresso:BRL = 199.00
    
    //MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagemBanner.layer.cornerRadius = 10
        self.imagemBanner.layer.masksToBounds = true
        pickerViewMes.delegate = self
        pickerViewAno.delegate = self
        pickerViewParcela.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(aumentarScrollView(notification:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    //MARK: - Métodos
    
    func buscaTextField(tipoDeTextField:TiposDeTextField, completion:(_ textFieldSolicitado:UITextField) -> Void) {
        for textField in textFields {
            if let textFieldAtual = TiposDeTextField(rawValue: textField.tag) {
                if textFieldAtual == tipoDeTextField {
                    completion(textField)
                }
            }
        }
    }
    
    @objc func aumentarScrollView(notification:Notification) {
        self.scrollViewPrincipal.contentSize = CGSize(width: self.scrollViewPrincipal.frame.width, height: self.scrollViewPrincipal.frame.height + 750)
    }
    
    //MARK: - PickerViewDelegate
    
    func mesSelecionado(mes: String) {
        self.buscaTextField(tipoDeTextField: .mesDeVencimento) { (textFieldMes) in
            textFieldMes.text = mes
        }
    }
    
    func anoSelecionado(ano: String) {
        self.buscaTextField(tipoDeTextField: .anoDeVencimento) { (textFieldAno) in
            textFieldAno.text = ano
        }
    }
    
    func pickerViewParcelaSelecionada(parcela: String) {
        self.buscaTextField(tipoDeTextField: .parcela) { (textFieldParcela) in
            textFieldParcela.text = "\(parcela)x"
            let calculoDaParcela = "\(valorDoIngresso/Int(parcela)!)"
            self.labelValorDasParcelas.text = String(format: "%@x %@ (ou R$199,00 à vista)", parcela, calculoDaParcela)
        }
    }
    
    //MARK: - Actions
    
    @IBAction func botaoComprar(_ sender: UIButton) {
        let textFieldsEstaoPreenchidos = ValidaFormulario().verificaTextFieldsPreenchidos(textFields: textFields)
        let textFieldsEstaoValidos = ValidaFormulario().verificaTextFieldsValidos(listaDeTextFields: textFields)
        
        if textFieldsEstaoPreenchidos && textFieldsEstaoValidos {
            present(ValidaFormulario().exibeNotificacaoDeCompraRealizada(), animated: true, completion: nil)
        }
        else {
            present(ValidaFormulario().exibeNotificacaoDePreenchimentoDosTextFields(), animated: true, completion: nil)
        }
    }
    
    @IBAction func textFieldCepAlterouValor(_ sender: UITextField) {
        LocalizacaoConsultaAPI().consultaViaCepAPI(cep: sender.text!, sucesso: { (localizacao) in
            self.buscaTextField(tipoDeTextField: .endereco, completion: { (textFieldEndereco) in
                textFieldEndereco.text = localizacao.logradouro
            })
            self.buscaTextField(tipoDeTextField: .bairro, completion: { (textFieldBairro) in
                textFieldBairro.text = localizacao.bairro
            })
            
        }) { (error) in
            print(error)
        }
    }
    
    @IBAction func textFieldMesEntrouEmFoco(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewMes
        pickerView.dataSource = pickerViewMes
        sender.inputView = pickerView
    }
    
    @IBAction func textFieldAnoEntrouEmFoco(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewAno
        pickerView.dataSource = pickerViewAno
        sender.inputView = pickerView
    }
    
    @IBAction func textFieldParcelas(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewParcela
        pickerView.dataSource = pickerViewParcela
        sender.inputView = pickerView
    }
    
    @IBAction func textFieldCodigoDeSeguranca(_ sender: UITextField) {
        guard let texto = sender.text else { return }
        
        if texto.count > 3 {
            let codigo = texto.suffix(3)
            self.buscaTextField(tipoDeTextField: .codigoDeSeguranca, completion: { (textFieldCodigoSeguranca) in
                textFieldCodigoSeguranca.text = String(codigo)
            })
        }
        else {
            self.buscaTextField(tipoDeTextField: .codigoDeSeguranca, completion: { (textFieldCodigoSeguranca) in
                textFieldCodigoSeguranca.text = texto
            })
        }
    }
    
}

