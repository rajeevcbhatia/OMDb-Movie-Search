//
//  OMDb_Movie_SearchTests.swift
//  OMDb Movie SearchTests
//
//  Created by Rajeev Bhatia on 23/01/18.
//  Copyright © 2018 rajeev. All rights reserved.
//

import XCTest
@testable import OMDb_Movie_Search

class OMDb_Movie_SearchTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMovieListResponse() {
        
        let expectation = XCTestExpectation(description: "api expectation")
        
        let searchTerm = "godfather"
        APIClient.getMoviesList(searchTerm: searchTerm) { (items) in
            XCTAssert(items != nil, "nil response received")
            XCTAssert(items!.count > 0, "no items in response")
           expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testMovieListDecoding() {
        
        let jsonString = "{\"Search\":[{\"Title\":\"Friends\",\"Year\":\"1994–2004\",\"imdbID\":\"tt0108778\",\"Type\":\"series\",\"Poster\":\"https://images-na.ssl-images-amazon.com/images/M/MV5BMTg4NzEyNzQ5OF5BMl5BanBnXkFtZTYwNTY3NDg4._V1._CR24,0,293,443_SX89_AL_.jpg_V1_SX300.jpg\"},{\"Title\":\"Friends with Benefits\",\"Year\":\"2011\",\"imdbID\":\"tt1632708\",\"Type\":\"movie\",\"Poster\":\"https://images-na.ssl-images-amazon.com/images/M/MV5BMTQ2MzQ0NTk4N15BMl5BanBnXkFtZTcwMDc2NDYzNQ@@._V1_SX300.jpg\"},{\"Title\":\"Just Friends\",\"Year\":\"2005\",\"imdbID\":\"tt0433400\",\"Type\":\"movie\",\"Poster\":\"https://images-na.ssl-images-amazon.com/images/M/MV5BMjA0Mzg2NjUzMl5BMl5BanBnXkFtZTcwNDg2ODUzMQ@@._V1_SX300.jpg\"},{\"Title\":\"How to Lose Friends & Alienate People\",\"Year\":\"2008\",\"imdbID\":\"tt0455538\",\"Type\":\"movie\",\"Poster\":\"https://images-na.ssl-images-amazon.com/images/M/MV5BMjY0MzFmMDgtY2ZiOC00M2QyLWFmOWMtOTBmZWY4OWE2YTYzXkEyXkFqcGdeQXVyMjA5MTIzMjQ@._V1_SX300.jpg\"},{\"Title\":\"Friends with Kids\",\"Year\":\"2011\",\"imdbID\":\"tt1720616\",\"Type\":\"movie\",\"Poster\":\"https://images-na.ssl-images-amazon.com/images/M/MV5BMTcyMDI2NjU2Ml5BMl5BanBnXkFtZTcwNjA4MzQzNw@@._V1_SX300.jpg\"},{\"Title\":\"We Are Your Friends\",\"Year\":\"2015\",\"imdbID\":\"tt3787590\",\"Type\":\"movie\",\"Poster\":\"https://images-na.ssl-images-amazon.com/images/M/MV5BMjE2NjIxODUxNF5BMl5BanBnXkFtZTgwMjI1MzM1NjE@._V1_SX300.jpg\"},{\"Title\":\"Friends with Money\",\"Year\":\"2006\",\"imdbID\":\"tt0436331\",\"Type\":\"movie\",\"Poster\":\"https://images-na.ssl-images-amazon.com/images/M/MV5BMjE3Mjc3NjQ5NV5BMl5BanBnXkFtZTYwMjY5MjE3._V1_SX300.jpg\"},{\"Title\":\"Happy Tree Friends\",\"Year\":\"1999–\",\"imdbID\":\"tt0770762\",\"Type\":\"series\",\"Poster\":\"https://images-na.ssl-images-amazon.com/images/M/MV5BMzRiMjRkNDYtNjNmZC00MTQwLThjNGQtZDEzZDA0OWVlOWUxXkEyXkFqcGdeQXVyMjAxODI1Nzk@._V1_SX300.jpg\"},{\"Title\":\"Foster's Home for Imaginary Friends\",\"Year\":\"2004–2009\",\"imdbID\":\"tt0419326\",\"Type\":\"series\",\"Poster\":\"https://images-na.ssl-images-amazon.com/images/M/MV5BNjYyNGFjOTctYzFmNC00NzdmLThhMDgtNjEzZTRmNzA3ODc5XkEyXkFqcGdeQXVyNjk1Njg5NTA@._V1_SX300.jpg\"},{\"Title\":\"Peter's Friends\",\"Year\":\"1992\",\"imdbID\":\"tt0105130\",\"Type\":\"movie\",\"Poster\":\"https://images-na.ssl-images-amazon.com/images/M/MV5BMjIxODM3MTI4M15BMl5BanBnXkFtZTcwNTIzNzU2NA@@._V1_SX300.jpg\"}],\"totalResults\":\"1714\",\"Response\":\"True\"}"
        
        let jsonData = jsonString.data(using: String.Encoding.utf8)
        
        XCTAssert(jsonData != nil, "could not decode json string")
        
        
        let itemsList = APIClient.decodeMoviesList(data: jsonData!)
        
        XCTAssert(itemsList != nil, "nil response received")
        XCTAssert(itemsList!.count > 0, "no items decoded")
        
    }
    
    func testItemResponse() {
        let expectation = XCTestExpectation(description: "api expectation")
        
        let id = "tt0108778"
        APIClient.getMovieDetails(id: id) { (item) in
            XCTAssert(item != nil, "item details not found")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testItemDecode() {
        
        let jsonString = "{\"Title\":\"Friends\",\"Year\":\"1994–2004\",\"Rated\":\"TV-14\",\"Released\":\"22 Sep 1994\",\"Runtime\":\"22 min\",\"Genre\":\"Comedy, Romance\",\"Director\":\"N/A\",\"Writer\":\"David Crane, Marta Kauffman\",\"Actors\":\"Jennifer Aniston, Courteney Cox, Lisa Kudrow, Matt LeBlanc\",\"Plot\":\"Rachel Green, Ross Geller, Monica Geller, Joey Tribbiani, Chandler Bing and Phoebe Buffay are all friends, living off of one another in the heart of New York City. Over the course of ten years, this average group of buddies goes through massive mayhem, family trouble, past and future romances, fights, laughs, tears and surprises as they learn what it really means to be a friend.\",\"Language\":\"English, Dutch, Italian, French\",\"Country\":\"USA\",\"Awards\":\"Won 1 Golden Globe. Another 68 wins & 211 nominations.\",\"Poster\":\"https://images-na.ssl-images-amazon.com/images/M/MV5BMTg4NzEyNzQ5OF5BMl5BanBnXkFtZTYwNTY3NDg4._V1._CR24,0,293,443_SX89_AL_.jpg_V1_SX300.jpg\",\"Ratings\":[{\"Source\":\"Internet Movie Database\",\"Value\":\"8.9/10\"}],\"Metascore\":\"N/A\",\"imdbRating\":\"8.9\",\"imdbVotes\":\"566,255\",\"imdbID\":\"tt0108778\",\"Type\":\"series\",\"totalSeasons\":\"10\",\"Response\":\"True\"}"
        
        let jsonData = jsonString.data(using: String.Encoding.utf8)
        
        XCTAssert(jsonData != nil, "could not decode json string")
        
        let itemsList = APIClient.decodeMovie(data: jsonData!)
        
        XCTAssert(itemsList != nil, "could not decode")
    }
    
}
