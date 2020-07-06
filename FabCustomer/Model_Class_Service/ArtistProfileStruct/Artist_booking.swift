/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Artist_booking : Codable {
	var userImage : String?
	var username : String?
	var rating : String?
	var currency_type : String?
	var booking_time : String?
	var comment : String?
	var price : String?
	var ratingDate : String?
	var booking_date : String?

	enum CodingKeys: String, CodingKey {

		case userImage = "userImage"
		case username = "username"
		case rating = "rating"
		case currency_type = "currency_type"
		case booking_time = "booking_time"
		case comment = "comment"
		case price = "price"
		case ratingDate = "ratingDate"
		case booking_date = "booking_date"
	}

/*	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		userImage = try values.decodeIfPresent(String.self, forKey: .userImage)
		username = try values.decodeIfPresent(String.self, forKey: .username)
		rating = try values.decodeIfPresent(String.self, forKey: .rating)
		currency_type = try values.decodeIfPresent(String.self, forKey: .currency_type)
		booking_time = try values.decodeIfPresent(String.self, forKey: .booking_time)
		comment = try values.decodeIfPresent(String.self, forKey: .comment)
		price = try values.decodeIfPresent(String.self, forKey: .price)
		ratingDate = try values.decodeIfPresent(String.self, forKey: .ratingDate)
		booking_date = try values.decodeIfPresent(String.self, forKey: .booking_date)
	}
*/
}
