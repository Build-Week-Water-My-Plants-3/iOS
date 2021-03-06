//
//  WaterMyPlantsTests.swift
//  WaterMyPlantsTests
//
//  Created by Craig Swanson on 3/4/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

import XCTest
import CoreData
@testable import WaterMyPlants

class WaterMyPlantsTests: XCTestCase {
    
    // Log in with a known existing user should not return error
    func testLogInExistingUser() {
        let userController = UserController()
        let user = User(password: "craigTest", phoneNumber: "12345", username: "craigTest")
        let userRep = user.userRepresentation
        var resultError: Error?
        
        let logInExpectation = expectation(description: "LogIn Existing User")
        userController.signIn(with: userRep!) { (possibleError) in
            logInExpectation.fulfill()
            if possibleError != nil {
                resultError = possibleError
            }
        }
        wait(for: [logInExpectation], timeout: 2)
        XCTAssertNil(resultError)
        
    }
    
    // Log in with known non-existing user should return error
    func testLogInNonExistingUser() {
        let userController = UserController()
        let user = User(password: "crt", phoneNumber: "12345", username: "crt")
        let userRep = user.userRepresentation
        var resultError: Error?
        
        let logInExpectation = expectation(description: "LogIn Existing User")
        userController.signIn(with: userRep!) { (possibleError) in
            logInExpectation.fulfill()
            if possibleError != nil {
                resultError = possibleError
            }
        }
        wait(for: [logInExpectation], timeout: 2)
        XCTAssertNotNil(resultError)
        
    }
    
    // Get the current user's phone number should not return error
    func testGettingCurrentUserPhoneNumber() {
        let userController = UserController()
        let user = User(password: "craigTest", phoneNumber: "12345", username: "craigTest")
        let userRep = user.userRepresentation
        var resultError: Error?
        
        let userPhoneNumberExpectation = expectation(description: "Fetch user phone number")
        userController.getUserPhoneNumber(with: userRep!) { (possibleError) in
            userPhoneNumberExpectation.fulfill()
            if possibleError != nil {
                resultError = possibleError
            }
        }
        wait(for: [userPhoneNumberExpectation], timeout: 2)
        XCTAssertNil(resultError)
    }
    
    // Updating an existing user should not return an error
    func testValidUpdateUser() {
        let userController = UserController()
        let user = User(password: "craigTest", phoneNumber: "12345", username: "craigTest")
        let userRep = user.userRepresentation
        var resultError: Error?
        
        let updateUserExpectation = expectation(description: "Updating user information")
        userController.updateUser(with: userRep!) { (possibleError) in
            updateUserExpectation.fulfill()
            if possibleError != nil {
                resultError = possibleError
            }
        }
        wait(for: [updateUserExpectation], timeout: 2)
        XCTAssertNil(resultError)
    }
    
    // Saving plant should not produce an error
    func testSavePlantToServer() {
        let plantController = PlantController()
        let oldPlant = Plant(nickname: "charlie", species: "daisy", h2oFrequency: 6, image: nil)
        oldPlant.user = User(password: "craigTest", phoneNumber: "12345", username: "craigTest")
        var resultError: Error?
        
        let savePlantExpectation = expectation(description: "Wait for user results")
        
        plantController.put(plant: oldPlant) { possibleError in
            savePlantExpectation.fulfill()
            if possibleError != nil {
                resultError = possibleError
            }
        }
        wait(for: [savePlantExpectation], timeout: 2)
        
        XCTAssertNil(resultError)
    }
    
    // Saving plant without an associated user should return early from the function and return neither and error nor data. Setting the expectation to inverted.
    func testSavePlantToServerNoUser() {
        let plantController = PlantController()
        let orphanedPlant = Plant(nickname: "charlie", species: "daisy", h2oFrequency: 6, image: nil)
        var resultError: Error?
        
        let savePlantExpectation = expectation(description: "Wait for user results")
        savePlantExpectation.isInverted = true
        
        plantController.put(plant: orphanedPlant) { possibleError in
            savePlantExpectation.fulfill()
            if possibleError != nil {
                resultError = possibleError
            }
        }
        wait(for: [savePlantExpectation], timeout: 2)
        
        XCTAssertNil(resultError)
    }
    
    func testFetchUserPlants() {
        let tableViewController = UserPlantsViewController()
        let frc = tableViewController.fetchedResultsController
        let user = User(password: "craigTest", phoneNumber: "12345", username: "craigTest")
        
        XCTAssertTrue(frc.sections?.count == 2)
        
    }
    
    func testCountUserPlantsForSection() {
        let tableViewController = UserPlantsViewController()
        let frc = tableViewController.fetchedResultsController
        let user = User(password: "craigTest", phoneNumber: "12345", username: "craigTest")
        
        XCTAssertTrue(frc.sections?[0].numberOfObjects == 1)
        XCTAssertTrue(frc.sections?[1].numberOfObjects == 1)
    }
    
    // Change water date. New date should be greater than previous date.
    // test daystowateringcalc()
//    func testChangeWateredDate() {
//        let plantDetailVC = PlantDetailViewController()
//        let plantController = PlantController()
//        let user = User(password: "craigTest", phoneNumber: "54321", username: "craigTest")
//        
//        let isoDate = "2020-03-04T03:39:18Z"
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        let date = formatter.date(from: isoDate)
//        
//        let plant = Plant(identifier: UUID(uuidString: "4A583ABA-3938-44DA-896E-B22F4D30E417")!, nickname: "Paulie", species: "Palmetto", h2oFrequency: 4, lastWatered: date!, image: nil, context: CoreDataStack.shared.mainContext)
//        
//        plantDetailVC.updateLastWateredDate
//    }
}
