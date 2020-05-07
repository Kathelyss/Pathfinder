import Foundation

struct Matrix<T> {
    let rows: Int
    let columns: Int
    var grid: [T]

    init() {
        rows = 0
        columns = 0
        grid = []
    }

    init(rows: Int, columns: Int, initValue: T) {
        self.rows = rows
        self.columns = columns
        grid = []

        for _ in 1...(self.rows * self.columns) {
            grid.append(initValue)
        }
    }

    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }

    func indexIsValid(row: Int) -> Bool {
        return row >= 0 && row < rows
    }

    subscript(row: Int, column: Int) -> T {
        get {
            assert(indexIsValidForRow(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}
