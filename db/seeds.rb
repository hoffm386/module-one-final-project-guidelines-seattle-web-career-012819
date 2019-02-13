# Clear out all items first.
Book.destroy_all
Author.destroy_all
Publisher.destroy_all
BookDeal.destroy_all

# Build a list of things to search for.
search_terms = [
  "allen",
  "hal",
  "beans",
  "bibs"
]

# Generate seeds based on each search term.
search_terms.each do |search|
  generate_seeds_from_search_term( search )
end