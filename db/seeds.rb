def access_regions
  response = RestClient.get("https://api.got.show/api/regions/")
  JSON.parse(response.body)
  # binding.pry
  # jj["data"]["children"].each_with_index do |post, index|
  # puts "#{index}. " + post["data"]["title"]
end

def seed_regions
  Region.destroy_all
  access_regions.each do |region_hash|
    Region.create(name: region_hash["name"])
  end
end

seed_regions

def access_houses
  response = RestClient.get("https://api.got.show/api/houses/")
  JSON.parse(response.body)
end

def seed_houses
  House.destroy_all
  access_houses.each do |house_hash|
    region_id = Region.find_by(name: house_hash["region"])&.id #in case region doesn't exist
    if region_id
      House.create(region_id: region_id,
                  name: house_hash["name"],
                  coat_of_arms: house_hash["coatOfArms"],
                  ancestral_weapon: house_hash["ancestralWeapon"])
    end
  end
end

seed_houses
