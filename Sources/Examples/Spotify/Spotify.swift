// Copyright 2019 Google LLC. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation
import Dispatch
import OAuth2

class SpotifySession {
  
  var connection : Connection
  
  init(tokenProvider: TokenProvider) throws{
    connection = try Connection(provider:tokenProvider)
  }
  
  func getUser() throws {
    let sem = DispatchSemaphore(value: 0)
    var responseData : Data?
    try connection.performRequest(
      method:"GET",
      urlString:"https://api.spotify.com/v1/me") {(data, response, error) in
        responseData = data
        sem.signal()
    }
    _ = sem.wait(timeout: DispatchTime.distantFuture)
    if let data = responseData {
      let response = String(data: data, encoding: .utf8)!
      print(response)
    }
  }
  
  func getTracks() throws {
    let sem = DispatchSemaphore(value: 0)
    var responseData : Data?
    try connection.performRequest(
      method:"GET",
      urlString:"https://api.spotify.com/v1/me/tracks") {(data, response, error) in
        responseData = data
        sem.signal()
    }
    _ = sem.wait(timeout: DispatchTime.distantFuture)
    if let data = responseData {
      let response = String(data: data, encoding: .utf8)!
      print(response)
    }
  }
}
