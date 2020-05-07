import CoreGraphics

final class AStar {

    func findPathAStar(from startNode: Node, to goalNode: Node) throws -> [Node] {
        var closedSet = [Node]()        // Множество вершин, которые уже обработаны (раскрыты)
        var openSet: [Node] = [startNode]   // Множество вершин(очередь), которые предстоит обработать (раскрыть)

        startNode.g = 0 // g(x). Стоимость пути от начальной вершины. У start g(x) = 0
        startNode.h = heuristicCostEstimate(startNode, goalNode)    // Эвристическая оценка расстояния до цели. h(x)

        while !openSet.isEmpty {
            guard let currentNode = findCheapestFNodeIn(openSet) else { // вершина из openSet, имеющая самую низкую оценку f
                throw PathfinderError.somethingWentWrong
            }

            if currentNode == goalNode {
                return reconstructPath(startNode, goalNode)
            }

            openSet.removeAll { $0 == currentNode } // Вершина currentNode пошла на обработку, удаляем её из очереди на обработку
            closedSet.append(currentNode) // и добавляем в список уже обработанных

            currentNode.neighbourNodes.forEach { neighbourNode in
                guard !closedSet.contains(neighbourNode) else {
                    return
                }

                // Вычисляем neighbourNode.g через currentNode
                let tentativeGScore = currentNode.g + distanceBetween(currentNode, neighbourNode)
                var isTentativeBetter = false

                if !openSet.contains(neighbourNode) { // Если neighbourNode ещё не в открытом списке, добавим её туда
                    openSet.append(neighbourNode)
                    isTentativeBetter = true
                } else { // neighbourNode была в открытом списке, значит мы знаем её g, h и f
                    if tentativeGScore < neighbourNode.g {
                        // Вычисленная g(neighbourNode) через currentNode оказалась меньше, значит нужно обновить её g, h и f
                        isTentativeBetter = true
                    } else {
                        // Вычисленная g(neighbourNode) через currentNode оказалась больше, чем имеющаяся в openSet
                        // Значит, из вершины currentNode путь через neighbourNode дороже, т.е. существует менее дорогой маршрут,
                        // пролегающий через neighbourNode (из какой-то другой вершины, не из currentNode)
                        // Поэтому данную neighbourNode мы игнорируем
                        isTentativeBetter = false
                    }
                }

                // Обновление свойств neighbourNode
                if isTentativeBetter {
                    neighbourNode.cameFrom = currentNode
                    neighbourNode.g = tentativeGScore
                    neighbourNode.h = heuristicCostEstimate(neighbourNode, goalNode)
                }
            }
        }

        throw PathfinderError.noPathFound // управление передаётся сюда когда openSet пуст, а goal не найден
    }

    func distanceBetween(_ firstNode: Node, _ secondNode: Node) -> Double {
        return 0.0
    }

    func reconstructPath(_ startNode: Node, _ goalNode: Node) -> [Node] {
        var path = [Node]()
        var currentNode = goalNode
        while currentNode != startNode {
            path.append(currentNode) // Добавить вершину в карту
            guard let previousNodeInPath = currentNode.cameFrom else { // у стартовой вершины нет cameFrom ?
                return path
            }

            currentNode = previousNodeInPath
        }

        path.append(startNode)
        return path
    }

    func findCheapestFNodeIn(_ set: [Node]) -> Node? {
        return set.min { $0.f < $1.f }
    }

    func heuristicCostEstimate(_ startNode: Node, _ goalNode: Node) -> Double {
        return 0.0
    }
}
