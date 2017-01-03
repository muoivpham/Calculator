//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by muoivpham on 12/31/16.
//  Copyright © 2016 muoivpham. All rights reserved.
//

import Foundation



class CalculatorBrain
{
    private var accumlator = 0.0
    
    func setOperand(operand: Double){
        accumlator = operand
    }
    
    private var operations: Dictionary<String, Operation>= [
        "π": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt), //sqrt,
        "cos": Operation.UnaryOperation(cos), //cos
        "x": Operation.BinaryOperation({$0 * $1}),
        "÷": Operation.BinaryOperation({$0 / $1}),
        "+": Operation.BinaryOperation({$0 + $1}),
        "-": Operation.BinaryOperation({$0 - $1}),
        "=": Operation.Equals
    ]
    
    private  enum Operation{
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
        
    }
    
    func performOperation(symbol: String) {
        if let Operation = operations[symbol]{
            switch Operation{
            case .Constant(let value):
                accumlator = value
            case .UnaryOperation(let function):
                accumlator = function(accumlator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperatnd: accumlator)
            case .Equals:
               executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation()
    {
        if pending != nil {
            accumlator = pending!.binaryFunction(pending!.firstOperatnd, accumlator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    struct PendingBinaryOperationInfo{
        var binaryFunction: (Double, Double) -> Double
        var firstOperatnd: Double
    }
    
    var result: Double {
        get {
            return accumlator
        }
    }
}
