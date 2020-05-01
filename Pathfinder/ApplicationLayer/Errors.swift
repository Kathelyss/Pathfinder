import Foundation

enum PathfinderError: Error {
    case noSourceNode, noDestinationNode, noPathFound, somethingWentWrong
}
