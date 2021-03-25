//
//  StarGazersListViewModel.swift
//  gazers
//
//  Created by Nicolò Pasini on 21/03/21.
//

import OSLogger
import Foundation
import ReactiveSwift

final class StarGazersListViewModel: StarGazersListViewModelProtocol {

    let errorSignal: Property<Bool>
    let stopFetchingData: Property<Bool>
    let gazersDataSource: MutableProperty<[Gazer]>

    private var currentPage: Int
    private var isFetching: Bool
    private let gazersPerPage: Int
    private var errorString: String
    private let serialDisposable: SerialDisposable
    private let gazersRepository: StarGazersRepositoryService?
    private let errorSignalPipe: (output: VoidSignal, input: VoidSignal.Observer)
    private let stopFetchingPipe: (output: BoolSignal, input: BoolSignal.Observer)

    // MARK: - Lyfe Cycle

    init(repositoryName: String, repositoryOwner: String, perPageItems: Int = 25) {
        currentPage = 1
        errorString = ""
        isFetching = false
        gazersPerPage = perPageItems
        errorSignalPipe = VoidSignal.pipe()
        stopFetchingPipe = BoolSignal.pipe()
        gazersDataSource = MutableProperty([])
        serialDisposable = SerialDisposable(nil)
        stopFetchingData = Property(initial: false, then: stopFetchingPipe.output)
        errorSignal = Property(initial: false, then: errorSignalPipe.output.map({ true }))
        gazersRepository = AssemblerWrapper.shared.resolve(StarGazersRepositoryService.self, arguments: repositoryName, repositoryOwner, gazersPerPage)
    }

    deinit {
        OSLogger.dataFlowLog(message: "Disposing BeersViewModel", access: .public, type: .debug)

        if (!serialDisposable.isDisposed) {
            serialDisposable.dispose()
        }
    }

    //MARK: Public Functions

    func errorMessage() -> String {
        return errorString
    }

    func isValid() -> Bool {
        return true
    }

    func getStarGazers() {
        if (!isFetching && !stopFetchingData.value) {
            OSLogger.dataFlowLog(message: "Fetching new Gazer Models from page \(currentPage)", access: .public, type: .debug)
            isFetching = true

            if let gazersRepository = gazersRepository {
                serialDisposable.inner = gazersRepository.getGazers(page: currentPage).on(failed: { [weak self] (error: NSError) in
                    self?.isFetching = false
                    self?.errorString = "An error occurred while retrieving data"
                    self?.stopFetchingPipe.input.send(value: true)
                    self?.errorSignalPipe.input.send(value: ())
                }, completed: { [weak self] in
                    self?.currentPage += 1
                    self?.isFetching = false
                }, value: { [weak self] (newGazers: [Gazer]) in
                    if let perPageCount = self?.gazersPerPage {
                        let endOfFetchingReachedValue = (newGazers.count < perPageCount || newGazers.count == 0) ? true : false
                        self?.stopFetchingPipe.input.send(value: endOfFetchingReachedValue)
                    }

                    OSLogger.dataFlowLog(message: "Appending \(newGazers.count) new Gazer Models to previous \(self?.gazersDataSource.value.count ?? 0) Gazer Models", access: .public, type: .debug)

                    self?.gazersDataSource.value.append(contentsOf: newGazers)
                }).start()
            }
        } else if (isFetching) {
            OSLogger.dataFlowLog(message: "Fetching already in progress for page \(currentPage)", access: .public, type: .debug)
        } else if (stopFetchingData.value) {
            OSLogger.dataFlowLog(message: "Fetching stopped because reached end of paged results", access: .public, type: .debug)
        }
    }
}
