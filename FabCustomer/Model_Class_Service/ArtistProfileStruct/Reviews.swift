/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Reviews : Codable {
	var booking_id : String?
	var user_id : String?
	var image : String?
	var rating : String?
	var artist_id : String?
	var name : String?
	var created_at : String?
	var id : String?
	var status : String?
	var comment : String?

	enum CodingKeys: String, CodingKey {

		case booking_id = "booking_id"
		case user_id = "user_id"
		case image = "image"
		case rating = "rating"
		case artist_id = "artist_id"
		case name = "name"
		case created_at = "created_at"
		case id = "id"
		case status = "status"
		case comment = "comment"
	}

	/*init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		booking_id = try values.decodeIfPresent(String.self, forKey: .booking_id)
		user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		rating = try values.decodeIfPresent(String.self, forKey: .rating)
		artist_id = try values.decodeIfPresent(String.self, forKey: .artist_id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		comment = try values.decodeIfPresent(String.self, forKey: .comment)
	}*/

}
