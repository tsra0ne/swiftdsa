import Foundation

/*
 This particular implementation is simple but not very efficient. Several
 operations are O(n). A more efficient implementation would use a doubly
 linked list or a circular buffer.
 */

public struct Deque<T> {
    private var array: [T] = []
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func enqueueFront(_ element: T) {
        array.insert(element, at: 0)
    }
    
    @discardableResult
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    @discardableResult
    public mutating func dequeueBack() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeLast()
        }
    }
    
    public func peekFront() -> T? {
        return array.first
    }
    
    public func peekBack() -> T? {
        return array.last
    }
}

extension Deque: CustomStringConvertible {
    public var description: String {
        if isEmpty { return "Dequeue is Empty ... " }
        return "---- Dequeue Start ----\n" + array.map{ "\($0)" }.joined(separator: " <- ") + "\n---- Dequeue End ----"
    }
}

var deque = Deque<Int>()

deque.enqueue(1)
deque.enqueue(2)
deque.enqueueFront(3)
deque.enqueueFront(4)

print(deque.description)

deque.dequeue()
deque.dequeueBack()

print(deque.description)