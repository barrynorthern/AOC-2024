require 'net/http'
require 'uri'
require 'dotenv/load'
require_relative 'fetch'

# Define the URL
url = 'https://adventofcode.com/2024/day/1/input'

# Get lists from the data
def get_lists_from_data(data)
  list_left = []
  list_right = []

  data.each_line do |line|
    # Split the line by three spaces
    numbers = line.strip.split('   ')
    # Add the numbers to the respective lists
    list_left << numbers[0].to_i if numbers[0]
    list_right << numbers[1].to_i if numbers[1]
  end

  [list_left, list_right]
end

# Fetch and process the input
begin
  input_data = Fetcher.fetch_data(url)
  list_left, list_right = get_lists_from_data(input_data)

  # Sort the lists in ascending order
  list_left.sort!
  list_right.sort!

  # Find the total distance between the two lists
  total_distance = list_left.zip(list_right).sum { |left, right| (left - right).abs }

  # Print the results
  puts "Distance between lists: #{total_distance}"
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end
