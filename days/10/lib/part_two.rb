# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'dotenv/load'
require 'rgl/adjacency'
require 'rgl/dot'
require_relative '../../../lib/fetch'
require_relative 'part_one'

module DayTen
  module PartTwo
    def self.count_paths(graph, start_nodes, grid)
      width = grid.first.size

      # node_value retrieves the value from the node_id in row-major form
      node_value = lambda { |node_id|
        r, c = PartOne.to_coord(node_id, width)
        grid[r][c]
      }

      paths_memo = {}

      # Use a lambda for recursion
      dfs_count_paths = lambda do |node|
        return paths_memo[node] if paths_memo.key?(node)

        val = node_value.call(node)
        if val == 9
          # Reached a cell with value 9
          paths_memo[node] = 1
          return 1
        end

        total = 0
        graph.adjacent_vertices(node).each do |succ|
          total += dfs_count_paths.call(succ)
        end

        paths_memo[node] = total
        total
      end

      total_paths = 0
      start_nodes.each do |start_node|
        total_paths += dfs_count_paths.call(start_node)
      end

      total_paths
    end

    def self.run(grid)
      graph = PartOne.build_graph_from_grid(grid)
      start_nodes = PartOne.get_start_nodes(grid)
      count_paths(graph, start_nodes, grid)
    end

    # Run the program and output the result
    if __FILE__ == $PROGRAM_NAME
      begin
        input_data = Libs::Fetcher.fetch_data(PartOne.url)
        grid = PartOne.process_data(input_data)
        result = run(grid)
        puts "Result: #{result}"
      rescue StandardError => e
        puts "An error occurred: #{e.message}"
        puts e.backtrace.join("\n")
      end
    end
  end
end
