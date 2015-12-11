//
//  ViewController.swift
//  PedirDatosDelServidor
//
//  Created by Netzer Rivera on 03/12/15.
//  Copyright © 2015 Netzer Rivera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var isbn: UITextField!
    @IBOutlet weak var texto: UITextView!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblAutores: UILabel!
    @IBOutlet weak var lblUrl: UILabel!
    
    @IBOutlet weak var limpiar: UIButton!
    @IBAction func limpiando(sender: AnyObject) {
        
        isbn.text = ""
    
    }
    
    @IBAction func buscar(sender: AnyObject) {
       buscandoLibro(isbn.text!)
   }
    
    func buscandoLibro(idPagina: String)->String
    {
        let destino="https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" //+ idPagina
        //let url = NSURL(string: destino)
        //let datos : NSData? = NSData(contentsOfURL: url!)
        
        let url = NSURL(string: destino + idPagina)
        let datos = NSData(contentsOfURL: url!)
        
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
            let dico1 = json as! NSDictionary
            let dico2 = dico1["ISBN:978-84-376-0494-7"] as! NSDictionary
             self.lblTitulo.text = dico2["title"] as! NSString as String
            self.lblAutores.text = dico2["notes"] as! NSString as String
            self.lblUrl.text = dico2["url"] as! NSString as String
            
        }
        catch _{
        
        }
        
        if datos == nil
        {
            return ("Problemas con internet")
            
            
        }
        var dat = NSString(data: datos!, encoding: NSUTF8StringEncoding)
        if dat! as String == "{}" {
            dat = "No encontrado"
            
            
        }
        return dat! as String
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

}

