# Iterate over a hash and return the value stored in key "key_string".
# Returns argument passed to "type_expected" if the key doesn't exist. (such as: {}, [], 0, etc.)
def get_key_value(data_hash, key_string, type_expected)
  output = (data_hash[key_string] != nil) ? data_hash[key_string] : type_expected
end

# Iterate over an array and return any items that match the search term.
# Returns an empty array if no matches are found.
def get_array_match(data_array, search_term)
  output = data_array.select { |data| data.to_s.downcase.include?(search_term.to_s.downcase) }
end

# Parse the contents of the "items" key, if it exists, and return its value.
# Returns an empty array if nothing found.
def parse_items(json_hash)
  output = get_key_value( json_hash, "items", [] )
end

# Parse the contents of the "volumeInfo" key, if it exists, and return its value.
# Returns an array containing empty hash(es) if nothing found.
def parse_volumes(data_array)
  output = data_array.map do |data|
    get_key_value( data, "volumeInfo", {} )
  end
end

# Parse the contents of the "saleInfo" key, if it exists, and return its value.
# Returns an array containing empty hash(es) if nothing found.
def parse_sales(data_array)
  output = data_array.map do |data|
    get_key_value( data, "saleInfo", {} )
  end
end