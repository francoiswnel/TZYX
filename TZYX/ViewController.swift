//
//  ViewController.swift
//  TZYX
//
//  Created by Francois W. Nel on 25/10/2015.
//  Open sourced on 15/02/2016.
//  Creative Commons BY-NC-SA © 2016 Francois W. Nel.
//

import UIKit

class ViewController: UIViewController {
    var register: [Double] = [0.0, 0.0, 0.0, 0.0]
    var inputString: String = "0.0"
    var newInput: Bool = true
    var valuePushed: Bool = false
    var hasDecimalPoint: Bool = false

    // X: register[0]
    // Y: register[1]
    // Z: register[2]
    // T: register[3]

    @IBOutlet weak var invertButton: UIButton!
    @IBOutlet weak var rootButton: UIButton!
    @IBOutlet weak var powerButton: UIButton!
    @IBOutlet weak var rollButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var swapButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var num7Button: UIButton!
    @IBOutlet weak var num8Button: UIButton!
    @IBOutlet weak var num9Button: UIButton!
    @IBOutlet weak var divButton: UIButton!
    @IBOutlet weak var num4Button: UIButton!
    @IBOutlet weak var num5Button: UIButton!
    @IBOutlet weak var num6Button: UIButton!
    @IBOutlet weak var mtplyButton: UIButton!
    @IBOutlet weak var num1Button: UIButton!
    @IBOutlet weak var num2Button: UIButton!
    @IBOutlet weak var num3Button: UIButton!
    @IBOutlet weak var subButton: UIButton!
    @IBOutlet weak var num0Button: UIButton!
    @IBOutlet weak var decButton: UIButton!
    @IBOutlet weak var posNegButton: UIButton!
    @IBOutlet weak var addButton: UIButton!

    @IBOutlet weak var tOutput: UILabel!
    @IBOutlet weak var zOutput: UILabel!
    @IBOutlet weak var yOutput: UILabel!
    @IBOutlet weak var xOutput: UILabel!

    @IBAction func invertButtonAction(_ sender: UIButton) {
        invertX()
    }

    @IBAction func rootButtonAction(_ sender: UIButton) {
        doFunction("r")
    }

    @IBAction func powerButtonAction(_ sender: UIButton) {
        doFunction("p")
    }

    @IBAction func rollButtonAction(_ sender: UIButton) {
        rollRegisters()
    }

    @IBAction func enterButtonAction(_ sender: UIButton) {
        inputX()
    }

    @IBAction func swapButtonAction(_ sender: UIButton) {
        swapXY()
    }

    @IBAction func clearButtonAction(_ sender: UIButton) {
        clearX()
    }

    @IBAction func divButtonAction(_ sender: UIButton) {
        doFunction("d")
    }

    @IBAction func mtplyButtonAction(_ sender: UIButton) {
        doFunction("m")
    }

    @IBAction func subButtonAction(_ sender: UIButton) {
        doFunction("s")
    }

    @IBAction func addButtonAction(_ sender: UIButton) {
        doFunction("a")
    }

    @IBAction func num1Action(_ sender: UIButton) {
        updateInputString("1")
    }

    @IBAction func num2Action(_ sender: UIButton) {
        updateInputString("2")
    }

    @IBAction func num3Action(_ sender: UIButton) {
        updateInputString("3")
    }

    @IBAction func num4Action(_ sender: UIButton) {
        updateInputString("4")
    }

    @IBAction func num5Action(_ sender: UIButton) {
        updateInputString("5")
    }

    @IBAction func num6Action(_ sender: UIButton) {
        updateInputString("6")
    }

    @IBAction func num7Action(_ sender: UIButton) {
        updateInputString("7")
    }

    @IBAction func num8Action(_ sender: UIButton) {
        updateInputString("8")
    }

    @IBAction func num9Action(_ sender: UIButton) {
        updateInputString("9")
    }

    @IBAction func num0Action(_ sender: UIButton) {
        updateInputString("0")
    }

    @IBAction func decButtonAction(_ sender: UIButton) {
        updateInputString(".")
    }

    @IBAction func posNegButtonAction(_ sender: UIButton) {
        updateInputString("-")
    }

    func doFunction(_ selectedFunction: Character) {
        if (!newInput) {
            register[0] = Double(inputString)!
            inputString = String(format: getStringFormat(register[0]), register[0])
        }

        if (selectedFunction == "d" || selectedFunction == "r") {
            if (register[0] != 0.0) {
                switch selectedFunction {
                case "d": // Division
                    register[0] = register[1] / register[0]
                    break
                case "r": // Root
                    register[0] = pow(register[1], (1 / register[0]))
                    break
                default:
                    break
                }
                inputString = String(format: getStringFormat(register[0]), register[0])
                register[1] = register[2]
                register[2] = register[3]
                newInput = true
                updateDisplay()
            }
            else {
                inputString = String(format: getStringFormat(register[0]), register[0])
                xOutput.text = "Division By 0"
                newInput = true
                valuePushed = true
            }
        }
        else {
            switch selectedFunction {
            case "a": // Addition
                register[0] += register[1]
                break
            case "s": // Subtractrion
                register[0] = register[1] - register[0]
                break
            case "m": // Multiplication
                register[0] *= register[1]
                break
            case "p": // Power
                register[0] = pow(register[1], register[0])
                break
            default:
                break
            }
            inputString = String(format: getStringFormat(register[0]), register[0])
            register[1] = register[2]
            register[2] = register[3]
            newInput = true
            updateDisplay()
        }
    }

    func invertX() {
        if (!newInput) {
            register[0] = Double(inputString)!
            inputString = String(format: getStringFormat(register[0]), register[0])
        }
        if (register[0] != 0.0) {
            register[0] = 1 / register[0]
            inputString = String(format: getStringFormat(register[0]), register[0])
            newInput = true
            updateDisplay()
        }
        else {
            inputString = String(format: getStringFormat(register[0]), register[0])
            xOutput.text = "Division By 0"
            newInput = true
            valuePushed = true
        }
    }

    func rollRegisters() {
        let temp = register[0]
        for i in 0...2 {
            register[i] = register[i + 1]
        }
        inputString = String(format: getStringFormat(register[0]), register[0])
        register[3] = temp
        newInput = true
        updateDisplay()
    }

    func inputX() {
        register[0] = Double(inputString)!
        pushRegisters()
        inputString = String(format: getStringFormat(register[0]), register[0])
        newInput = true
        valuePushed = true
        updateDisplay()
    }

    func swapXY() {
        let temp = register[0]
        register[0] = register[1]
        register[1] = temp
        inputString = String(format: getStringFormat(register[0]), register[0])
        newInput = true
        updateDisplay()
    }

    func clearX() {
        if (newInput) {
            register[0] = 0.0
            inputString = String(format: getStringFormat(register[0]), register[0])
            updateDisplay()
        }
        else {
            if (inputString.characters.count > 1) {
                inputString.remove(at: inputString.characters.index(before: inputString.endIndex))
                xOutput.text = inputString + "_"
            }
            else {
                register[0] = 0.0
                inputString = String(format: getStringFormat(register[0]), register[0])
                updateDisplay()
                newInput = true
                valuePushed = true
            }
        }
    }

    func pushRegisters() {
        for i in (1...3).reversed() {
            register[i] = register[i - 1]
        }
    }

    func updateInputString(_ numValue: String) {
        if (numValue == ".") {
            if (newInput) {
                newInput = false
                inputString = "0."
                if (!valuePushed) {
                    pushRegisters()
                }
                valuePushed = false
                xOutput.text = inputString + "_"
            }
            else {
                for i in inputString.characters.indices {
                    if (inputString[i] == ".") {
                        hasDecimalPoint = true
                    }
                }
                if (!hasDecimalPoint) {
                    inputString += "."
                    register[0] = Double(inputString)!
                    xOutput.text = inputString + "_"
                }
                hasDecimalPoint = false
            }
        }
        else if (numValue == "-") {
            if (newInput && register[0] != 0) {
                newInput = false
                register[0] = -register[0]
                inputString = String(format: getStringFormat(register[0]), register[0])
                xOutput.text = inputString
            }
            else if (register[0] != 0) {
                if (register[0] < 0) {
                    inputString.remove(at: inputString.startIndex)
                    register[0] = Double(inputString)!
                }
                else {
                    inputString = "-" + inputString
                    register[0] = Double(inputString)!
                }
                xOutput.text = inputString + "_"
            }
        }
        else {
            if (newInput) {
                newInput = false
                inputString = numValue
                if (!valuePushed) {
                    pushRegisters()
                }
                valuePushed = false
            }
            else {
                inputString += numValue
            }
            register[0] = Double(inputString)!
            xOutput.text = inputString + "_"
        }
        yOutput.text = String(format: getStringFormat(register[1]), register[1])
        zOutput.text = String(format: getStringFormat(register[2]), register[2])
        tOutput.text = String(format: getStringFormat(register[3]), register[3])
    }

    func updateDisplay() {
        xOutput.text = String(format: getStringFormat(register[0]), register[0])
        yOutput.text = String(format: getStringFormat(register[1]), register[1])
        zOutput.text = String(format: getStringFormat(register[2]), register[2])
        tOutput.text = String(format: getStringFormat(register[3]), register[3])
    }

    func getStringFormat(_ value: Double) -> String {
        var charBeforeDec: Int
        var intValue: Int

        charBeforeDec = 0
        intValue = abs(Int(value))

        while (intValue >= 10) {
            charBeforeDec += 1
            intValue /= 10
        }

        if (value < 0) {
            charBeforeDec += 1
        }

        switch charBeforeDec {
        case 0:
            return "%.11f"
        case 1:
            return "%.10f"
        case 2:
            return "%.9f"
        case 3:
            return "%.8f"
        case 4:
            return "%.7f"
        case 5:
            return "%.6f"
        case 6:
            return "%.5f"
        case 7:
            return "%.4f"
        case 8:
            return "%.3f"
        case 9:
            return "%.2f"
        case 10:
            return "%.1f"
        default:
            return "%.0f"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

