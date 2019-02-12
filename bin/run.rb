require_relative '../config/environment'

def data_retrieved
    response = RestClient.get("https://www.googleapis.com/books/v1/volumes?q=allen")
    usable = JSON.parse(response.body)
    usable
end

# def drop_tables
#     sql = <<-SQL
#     DROP TABLE IF EXISTS ?
#     SQL

# end
puts "MURICA"
binding.pry

0

