import Foundation

struct Heap<T> {
    var elements: [T] = []
    let sort: (T, T) -> Bool
    
    init(sort: @escaping (T, T) -> Bool, elements: [T] = []) {
        self.sort = sort
        self.elements = elements
        
        if !elements.isEmpty {
            for i in stride(from: (elements.count / 2) - 1, through: 0, by: -1) {
                shiftDown(from: i)
            }
        }
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
    
    func peek() -> T? {
        return elements.first
    }
    
    func leftChildIndex(ofParent index: Int) -> Int {
        return (2 * index) + 1
    }
    
    func rightChildIndex(ofParent index: Int) -> Int {
        return (2 * index) + 2
    }
    
    func parentIndex(ofChildAt index: Int) -> Int {
        return (index - 1) / 2
    }
}

extension Heap {
    @discardableResult
    mutating func remove() -> T? {
        guard !isEmpty else { return nil }
        elements.swapAt(0, count - 1)
        defer {
            shiftDown(from: 0)
        }
        return elements.removeLast()
    }
    
    mutating func insert(_ value: T) {
        elements.append(value)
        shiftUp(from: count - 1)
    }
    
    mutating func shiftDown(from index: Int) {
        var parent = index
        while true {
            let left = leftChildIndex(ofParent: parent)
            let right = rightChildIndex(ofParent: parent)
            var candidate = parent
            if left < count && sort(elements[left], elements[candidate]) {
                candidate = left
            }
            if right < count && sort(elements[right], elements[candidate]) {
                candidate = right
            }
            if candidate == parent {
                return
            }
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
    
    mutating func shiftUp(from index: Int) {
        var child = index
        var parent = parentIndex(ofChildAt: child)
        while child > 0 && sort(elements[child], elements[parent]) {
            elements.swapAt(child, parent)
            child = parent
            parent = parentIndex(ofChildAt: child)
        }
    }
}

extension Heap: CustomStringConvertible {
    var description: String {
        return elements.description
    }
}

var heap = Heap(sort: { a, b in
    return a > b
}, elements: [1, 2, 3, 4, 5, 6, 7, 8])

print(heap.description)
