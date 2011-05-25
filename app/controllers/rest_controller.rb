require 'csv'

class RestController < ApplicationController
  def initialize 
    csv = CSV::parse(File.open(Rails.root + 'contest.csv') { |f| f.read })
    csvFields = csv.shift
    @objects = []
  
    csv.each do |record|
      @objects += [record]
    end
  end

  def api
  end
end
