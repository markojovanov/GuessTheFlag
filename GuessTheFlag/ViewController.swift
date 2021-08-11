import UIKit

class ViewController: UIViewController {

    @IBOutlet var flag1: UIButton!
    @IBOutlet var flag2: UIButton!
    @IBOutlet var flag3: UIButton!
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var numberOfQuestions = 0
    var highestScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        for flag in [flag1,flag2,flag3] {
            flag?.layer.borderWidth = 1.0
            flag?.layer.borderColor = UIColor.lightGray.cgColor
        }
        askQuestion(action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self,
                                                            action: #selector(viewScore))
        highestScore = UserDefaults.standard.integer(forKey: "score")
    }
    func askQuestion(action: UIAlertAction!){
        countries.shuffle()
        correctAnswer=Int.random(in: 0...2)
        title="\(countries[correctAnswer].uppercased()) | Score:\(score)"
        flag1.setImage(UIImage(named: countries[0]), for: .normal)
        flag2.setImage(UIImage(named: countries[1]), for: .normal)
        flag3.setImage(UIImage(named: countries[2]), for: .normal)
    }
    @IBAction func flagClicked(_ sender: UIButton) {
        var titleAlert: String
        let correctCountry: String = countries[sender.tag]
        if sender.tag == correctAnswer{
            titleAlert="Correct"
            score+=1
        }
        else {
            titleAlert="Wrong"
            if score > 0 {
            score-=1
            }
        }
        numberOfQuestions += 1
        if numberOfQuestions % 10 ==  9 {
            if score == 10 {
                final(message: "You break the record. Your score is 10/10")
                highestScore = 0
                UserDefaults.standard.set(highestScore,forKey: "score")
            } else if score>highestScore {
                highestScore = score
                UserDefaults.standard.set(highestScore,forKey: "score")
                final(message: "Your new high score is \(score)")
            } else {
                final(message: "Your score is \(score)")
            }
        }
        else {
            if titleAlert == "Wrong"{
                let ac = UIAlertController(title: titleAlert,
                                           message: """
                        You picked the flag of \(correctCountry.uppercased()), but the right answer is \(title?.components(separatedBy: " ").first ?? "").

                        Your score is \(score)
                        """,
                                           preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Continue",
                                           style: .default,
                                           handler: askQuestion))
                present(ac, animated: true)
            }
            else {
                let ac = UIAlertController(title: titleAlert, message: "Your score is \(score)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
                present(ac, animated: true)
            }
        }
    }
    
    @objc func viewScore() {
        let share = "Your score is \(highestScore)"
        let vc = UIActivityViewController(activityItems: [share],
                                          applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(vc, animated: true)
    }
    func final(message: String) {
        let mac = UIAlertController(title: "Final Score",
                                    message: message,
                                    preferredStyle: .alert)
        mac.addAction(UIAlertAction(title: "New Game",
                                    style: .default))
        present(mac, animated: true)
        score=0
        title="\(countries[correctAnswer].uppercased()) | Score:\(score)"
    }
}

