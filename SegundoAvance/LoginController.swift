import UIKit

class LoginController: UIViewController {
    
    
    @IBOutlet weak var tfUser: UITextField!
   
    @IBOutlet weak var tfPass: UITextField!
    var tries = 5
    
    @IBOutlet weak var validate: UIButton!
    @IBOutlet weak var login: UIButton!
    @IBAction func validate(_ sender: Any) {
        let file = "User.txt"
        
        var arrUtil = [String]()
        var arrUtil2 = [String]()
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            
            let path = dir.appendingPathComponent(file)
            
            print(path)
            do{
                let contents = try String(contentsOf: path, encoding: String.Encoding.utf8)
                arrUtil2 = contents.components(separatedBy: "/")
                arrUtil = arrUtil2[0].components(separatedBy: ",")
               
                print(tries)
                print("\(arrUtil[0]),\(arrUtil[1])")
                if arrUtil[0] == tfUser.text!  && arrUtil[1] == tfPass.text!{
                
                    login.isEnabled = true
                    
                }else{
                    tries-=1
                    print(tries)
                    
                }
                if tries == 0 {
                createAlert(titleText: "Has alcanzado el numero maximo de intentos", messageText: "todos tus archivos se han borrado, lo sentimos")
                print("oops")
                    let text = ""
                    try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                    validate.isEnabled = false;
                
                }
                
            }catch let error as NSError{
                
                print("fk \(error)")
            }
        }
    }
    func createAlert(titleText: String, messageText: String){
    
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated:true, completion:nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let file = "User.txt"
        var arrUtil = [String]()
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            
            let path = dir.appendingPathComponent(file)
            //print(path)
            do{
                let contents = try String(contentsOf: path, encoding: String.Encoding.utf8)
                arrUtil = contents.components(separatedBy: ",")
                //print("\(arrUtil[0]),\(arrUtil[1])")
                if arrUtil[0] != "" && !arrUtil.isEmpty{
                    
                    print("hay usuario")
                    validate.isEnabled = true
                }else{
                    print("no hay usuario")
                    validate.isEnabled = false
                }
            }catch let error as NSError{
                
                print("fk \(error)")
            }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
