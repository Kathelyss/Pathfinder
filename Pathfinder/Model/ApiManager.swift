import UIKit

final class ApiManager {

    private let serverAddress = "https://zbc6dqieta.execute-api.us-east-1.amazonaws.com/production/"

    func requestWarehouseTopology(completion: (Result<[GraphNode], Error>) -> Void) {
        // MOCK: add implemetation here
    }

    func requestWaybill(userId: String, completion: (Result<Waybill, Error>) -> Void) {
        // MOCK: add implemetation here
    }

    func sendRequest<T>(completion: (Result<T, Error>) -> Void) {

    }

    func parseNodes(nodes: [GraphNode]) {

    }
}
