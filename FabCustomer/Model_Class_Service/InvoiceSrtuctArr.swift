/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct InvoiceSrtuctArr : Codable {
	let total_amount : String?
	let category_amount : String?
	let booking_id : String?
	let discount_amount : String?
	let flag : String?
	let userName : String?
	let address : String?
	let final_amount : String?
	let commission_type : String?
	let tax : String?
	let userImage : String?
	let referral_percentage : String?
	let payment_status : String?
	let flat_type : String?
	let booking_date : String?
	let categoryName : String?
	let user_id : String?
	let currency_type : String?
	let id : String?
	let referral_amount : String?
	let updated_at : String?
	let artist_amount : String?
	let invoice_id : String?
	let artist_id : String?
	let artistImage : String?
	let artistName : String?
	let coupon_code : String?
	let payment_type : String?
	let to_referral_user_id : String?
	let working_min : String?
	let created_at : String?

	enum CodingKeys: String, CodingKey {

		case total_amount = "total_amount"
		case category_amount = "category_amount"
		case booking_id = "booking_id"
		case discount_amount = "discount_amount"
		case flag = "flag"
		case userName = "userName"
		case address = "address"
		case final_amount = "final_amount"
		case commission_type = "commission_type"
		case tax = "tax"
		case userImage = "userImage"
		case referral_percentage = "referral_percentage"
		case payment_status = "payment_status"
		case flat_type = "flat_type"
		case booking_date = "booking_date"
		case categoryName = "categoryName"
		case user_id = "user_id"
		case currency_type = "currency_type"
		case id = "id"
		case referral_amount = "referral_amount"
		case updated_at = "updated_at"
		case artist_amount = "artist_amount"
		case invoice_id = "invoice_id"
		case artist_id = "artist_id"
		case artistImage = "artistImage"
		case artistName = "ArtistName"
		case coupon_code = "coupon_code"
		case payment_type = "payment_type"
		case to_referral_user_id = "to_referral_user_id"
		case working_min = "working_min"
		case created_at = "created_at"
	}


}
