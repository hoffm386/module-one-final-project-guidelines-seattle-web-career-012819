def main
  # this will be our point of entry
  greeting = [
    "Hello,",
    "we are debugging our project with",
    "binding.pry!"
  ]
  puts "#{greeting.join("\n\n")}"
  binding.pry
end