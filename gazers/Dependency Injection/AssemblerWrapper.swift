//
//  AssemblerWrapper.swift
//  gazers
//
//  Created by Nicolò Pasini on 17/03/21.
//

import OSLogger
import Swinject
import Foundation

class AssemblerWrapper {
    var innerAssembler: Assembler = Assembler()
    static let shared: AssemblerWrapper = AssemblerWrapper()

    private init() { }

    func register(assemblies: [Assembly]) {
        self.innerAssembler = Assembler(assemblies)
    }

    func resolve<Service>(_ service: Service.Type) -> Service? {
        if let container = self.innerAssembler.resolver as? Container {
            let threadSafeContainer: Resolver = container.synchronize()
            return threadSafeContainer.resolve(Service.self)
        } else {
            OSLogger.dependencyInjectionLog(message: "Failed to resolve service: \(String(describing: service))", access: .public, type: .debug)
            return nil
        }
    }

    func resolve<Service, Arg1, Arg2>(_ service: Service.Type, arguments: Arg1, _ arg2: Arg2) -> Service? {
        if let container = self.innerAssembler.resolver as? Container {
            let threadSafeContainer: Resolver = container.synchronize()
            return threadSafeContainer.resolve(service.self, arguments: arguments, arg2)
        } else {
            OSLogger.dependencyInjectionLog(message: "Failed to resolve service: \(String(describing: service))", access: .public, type: .debug)
            return nil
        }
    }
}

