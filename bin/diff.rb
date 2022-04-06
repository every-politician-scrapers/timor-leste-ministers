#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/comparison'

# Skip junior ministers for now
# TODO: make sure all are included
class Comparison < EveryPoliticianScraper::NulllessComparison
  SKIP = /^(Vice Minister|Secretary of State|State Secretary)/

  def wikidata
    @wikidata ||= super.delete_if { |row| row[:position] =~ SKIP }
  end

  def external
    @external ||= super.delete_if { |row| row[:position] =~ SKIP }
  end
end

diff = Comparison.new('data/wikidata.csv', 'data/official.csv').diff
puts diff.sort_by { |r| [r.first, r[1].to_s] }.reverse.map(&:to_csv)
