//
//  FirestoreError.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 24.10.2024.
//

import Foundation

enum FirestoreError: LocalizedError {
    case userNotAuthenticated
    case documentNotFound
    case fieldNotFound(fieldName: String)
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .userNotAuthenticated:
            return "Пользователь не аутентифицирован."
        case .documentNotFound:
            return "Документ пользователя не найден."
        case .fieldNotFound(let fieldName):
            return "Поле '\(fieldName)' не найдено в документе."
        case .unknownError:
            return "Неизвестная ошибка."
        }
    }
}

enum StorageError: LocalizedError {
    case imageDataError
    case unknownError
    case noDownloadURL
    
    var errorDescription: String? {
        switch self {
        case .imageDataError:
            return "Данные image не найдены либо равняются nil"
        case .unknownError:
            return "Неизвестная ошибка."
        case .noDownloadURL:
            return "Не указан URL для скачивания."
        }
    }
}
