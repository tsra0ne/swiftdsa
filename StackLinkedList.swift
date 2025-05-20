import Foundation

// Node class to hold the data
class Node<T> {
    let value: T
    var next: Node?
    
    init(value: T) {
        self.value = value
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        guard let next else { return "\(value)" }
        return "\(value)\n" + String(describing: next)
    }
}

// Stack class to hold all the items
class Stack<T> {
    
    var top: Node<T>?
    
    func push(_ value: T) {
        let currentTop = top
        top = Node(value: value)
        top?.next = currentTop
    }
    
    @discardableResult
    func pop() -> T? {
        let currentTop = top
        top = top?.next
        return currentTop?.value
    }
    
    func peek() -> T? {
        return top?.value
    }
}

extension Stack: CustomStringConvertible {
    var description: String {
        guard let top else { return "---- Srack is Empty ----" }
        return "---- Stack Begin ----\n" + String(describing: top) + "\n---- Stack End ----"
    }
}

let stack = Stack<Int>()

stack.push(1)
stack.push(2)
stack.push(3)
stack.push(4)

print(stack.description)

if let poppedValue = stack.pop() {
    print("Popped Value:", poppedValue)
}

print(stack.description)

if let peekedValue = stack.peek() {
    print("Peeked Value:", peekedValue)
}

print(stack.description)