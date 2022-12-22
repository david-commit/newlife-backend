class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  require "uri"
  require "net/http"
  
  def pay_mpesa
    ​
    url = URI("https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest")
    ​
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    ​
    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/json"
    request["Authorization"] = "Bearer zL1bWTAGVCgdxPhikfFAtoEx9USP"
    ​
    request.body = {
      BusinessShortCode: 174_379,
      Password:
        "MTc0Mzc5YmZiMjc5ZjlhYTliZGJjZjE1OGU5N2RkNzFhNDY3Y2QyZTBjODkzMDU5YjEwZjc4ZTZiNzJhZGExZWQyYzkxOTIwMjIxMjIxMDAzNDM4",
      Timestamp: "20221221003438",
      TransactionType: "CustomerPayBillOnline",
      Amount: 1,
      PartyA: 254_717_594_017,
      PartyB: 174_379,
      PhoneNumber: 254_717_594_017,
      CallBackURL: "https://mydomain.com/path",
      AccountReference: "CompanyXLTD",
      TransactionDesc: "Payment of X"
    }
    ​
    response = https.request(request)
    puts response.read_body
  end
end
