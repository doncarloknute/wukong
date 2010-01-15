#!/usr/bin/env ruby
# run like so:
# $> ruby normalize.rb --run=local --input data/sizes --output data/normalized_sizes
require 'rubygems'
require 'wukong'

module Normalize
  class Mapper < Wukong::Streamer::RecordStreamer
    def process(code,model,time,country,j1,j2,j3, n1,n2,c1, venue,n3,n4, *sizes)
      sizes.map!(&:to_i)
      sum = sizes.sum.to_f
      normalized = sizes.map{|x| 100 * x/sum }
      s = normalized.join(",")
      yield [country, s]
    end
  end
end

Wukong::Script.new(Normalize::Mapper, nil).run
