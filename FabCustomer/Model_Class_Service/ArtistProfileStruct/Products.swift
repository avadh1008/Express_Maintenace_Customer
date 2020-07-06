/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Products : Codable {
	var product_image : String?
	var currency_type : String?
	var product_name : String?
	var id : String?
	var price : String?
	var updated_at : String?
	var user_id : String?
	var created_at : String?

	enum CodingKeys: String, CodingKey {

		case product_image = "product_image"
		case currency_type = "currency_type"
		case product_name = "product_name"
		case id = "id"
		case price = "price"
		case updated_at = "updated_at"
		case user_id = "user_id"
		case created_at = "created_at"
	}

/*	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		product_image = try values.decodeIfPresent(String.self, forKey: .product_image)
		currency_type = try values.decodeIfPresent(String.self, forKey: .currency_type)
		product_name = try values.decodeIfPresent(String.self, forKey: .product_name)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		price = try values.decodeIfPresent(String.self, forKey: .price)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
	}
*/
}
