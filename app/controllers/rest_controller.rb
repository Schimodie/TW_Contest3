require 'csv'

class RestController < ApplicationController
  @@projectsFull = []
  @@projects = []
  
  def initialize 
    csv = CSV::parse(File.open(Rails.root + 'contest.csv') { |f| f.read })
    csvFields = csv.shift
    cfLen = csvFields.length

    csv.each do |record|
      project = {}
      authors = {}
      
      authors[:first] = csv[csv.index(record)][2]
      authors[:second] = csv[csv.index(record)][3]

      project[:submited_at] = Time.strptime(csv[csv.index(record)][0], '%m/%d/%Y %H:%M:%S')
      project[:subject] = csv[csv.index(record)][1]
      project[:authors] = authors
      project[:project_url] = csv[csv.index(record)][4]
      project[:details] = csv[csv.index(record)][5]

      @@projectsFull += [project]
    end

    @@projectsFull.each do |pf|
      project = {}

      project[:submited_at] = pf[:submited_at]
      project[:id] = @@projectsFull.index pf
      project[:authors] = pf[:authors]

      @@projects += [project]
    end
  end

  def api
  end

  def show_id
    id = params[:id].to_i
    format = params[:format]

    if format == 'json'
      render :json => @@projectsFull[id]
    elsif format == 'xml'
      render :xml => @@projectsFull[id].to_xml(:root => 'project')
    else
      render :text => 'The format has to be xml or json'
    end
  end
  
  def show_count
    format = params[:format]

    if format == 'json'
      render :json => @@projects
    elsif format == 'xml'
      render :xml => @@projects.to_xml(:root => 'projects', :children => 'project')
    else
      render :text => 'The format has to be xml or json'
    end
  end
end
