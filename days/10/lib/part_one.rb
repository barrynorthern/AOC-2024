# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'dotenv/load'
require 'rgl/adjacency'
require 'rgl/dot'
require_relative '../../../lib/fetch'

module DayTen
  module PartOne
    # Define the URL
    def self.url
      'https://adventofcode.com/2024/day/10/input'
    end

    # Process data
    def self.process_data(data)
      data.split("\n").map(&:strip).map(&:chars).map { |row| row.map(&:to_i) }
    end

    def self.to_node_id(r, c, w)
      (r * w) + c
    end

    def self.to_coord(index, w)
      index.divmod(w)
    end

    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/PerceivedComplexity
    def self.build_graph_from_grid(grid)
      height = grid.size
      width  = grid.first.size

      # Create a directed graph using RGL
      graph = RGL::DirectedAdjacencyGraph.new

      # Add all nodes (not strictly necessary with RGL since edges add nodes implicitly,
      # but can be done for clarity)
      (0...height).each do |r|
        (0...width).each do |c|
          graph.add_vertex(to_node_id(r, c, width))
        end
      end

      directions = [[-1, 0], [1, 0], [0, -1], [0, 1]] # up, down, left, right

      (0...height).each do |r|
        (0...width).each do |c|
          current_value = grid[r][c]
          current_node = to_node_id(r, c, width)

          directions.each do |dr, dc|
            nr = r + dr
            nc = c + dc
            next unless nr.between?(0, height - 1) && nc.between?(0, width - 1)

            neighbor_value = grid[nr][nc]

            graph.add_edge(current_node, to_node_id(nr, nc, width)) if neighbor_value == current_value + 1
          end
        end
      end

      graph
    end
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity

    def self.total_trail_scores(graph, start_nodes, grid)
      width = grid.first.size

      node_value = lambda { |node_id|
        r, c = to_coord(node_id, width)
        grid[r][c]
      }

      # Instead of storing counts, store a set of reachable 9-nodes
      trails_memo = {}

      dfs_get_reachable_9s = lambda do |node|
        return trails_memo[node] if trails_memo.key?(node)

        val = node_value.call(node)
        if val == 9
          # This node is a 9, so the set of reachable 9-nodes is just itself
          # Use a Set for convenience
          trails_memo[node] = Set.new([node])
          return trails_memo[node]
        end

        reachable_9s = Set.new
        graph.adjacent_vertices(node).each do |succ|
          reachable_9s.merge(dfs_get_reachable_9s.call(succ))
        end

        trails_memo[node] = reachable_9s
        reachable_9s
      end

      total_scores = 0
      start_nodes.each do |start_node|
        # For each start node, get the set of reachable 9-nodes and count them
        reachable_9s = dfs_get_reachable_9s.call(start_node)
        total_scores += reachable_9s.size
      end

      total_scores
    end

    def self.get_start_nodes(grid)
      start_nodes = []
      height = grid.size
      width  = grid.first.size
      (0...height).each do |r|
        (0...width).each do |c|
          val = grid[r][c]
          start_nodes << to_node_id(r, c, width) if val.zero?
        end
      end
      start_nodes
    end

    def self.run(grid)
      graph = build_graph_from_grid(grid)
      start_nodes = get_start_nodes(grid)
      total_trail_scores(graph, start_nodes, grid)
    end

    # Run the program and output the result
    if __FILE__ == $PROGRAM_NAME
      begin
        input_data = Libs::Fetcher.fetch_data(url)
        grid = process_data(input_data)
        result = run(grid)
        puts "Result: #{result}"
      rescue StandardError => e
        puts "An error occurred: #{e.message}"
        puts e.backtrace.join("\n")
      end
    end
  end
end
