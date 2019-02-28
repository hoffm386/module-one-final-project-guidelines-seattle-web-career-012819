# Clear out all items first.
Book.destroy_all
Author.destroy_all
Publisher.destroy_all
BookDeal.destroy_all

# Build a list of things to search for.
search_terms = [
  "fiction",
  "allen",
  "hal",
  "beans",
  "bibs",
  "cat",
  "dog",
  "MATURE"
]

# Generate seeds based on each search term.
search_terms.each do |search|
  seed_batch = SeedBatch.new(search)
  seed_batch.generate_seeds_from_search_term
end
