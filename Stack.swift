import Foundation

public struct Stack<T> {
    
    // array of items
    private var items: [T] = []
    
    public var isEmpty: Bool {
        return items.isEmpty
    }
    
    public var count: Int {
        return items.count
    }
    
    public mutating func push(_ element: T) {
        items.append(element)
    }
    
    @discardableResult
    public mutating func pop() -> T? {
        return items.popLast()
    }
    
    func peek() -> T? {
        return items.last
    }
}

extension Stack: CustomStringConvertible {
    // to print the formatted description
    public var description: String {
        return "---- Stack Begin ----\n" + items.map{ "\($0)" }.reversed().joined(separator: "\n") + "\n---- Stack End ----"
    }
}

var stack = Stack<Int>()

stack.push(1)
stack.push(2)
stack.push(3)
stack.push(4)

print(stack.description)

if let poppedValue = stack.pop() {
    print("popped item:", poppedValue)
}

print(stack.description)

if let peekItem = stack.peek() {
    print("Peek Item in Stack:", peekItem)
}