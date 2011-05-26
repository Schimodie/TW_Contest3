require 'csv'

class RestController < ApplicationController
  @@projectsFull = []
  #@@projects = []
  
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
      project = nil
      authors = nil
    end

    #@@projectsFull.each do |pf|
    #  project = {}

    #  project[:submited_at] = pf[:submited_at]
    #  project[:id] = 1 + @@projectsFull.index(pf)
    #  project[:authors] = pf[:authors]
    
    #  @@projects += [project]
    #end

    #@@projects = @@projects.sort_by { |k| k[:submited_at] }
    #@@projects = @@projects.reverse
  end

  def api
  end

  def show_id
    id = params[:id].to_i
    format = params[:format]
    i = 0

    

    if id <= 0 || id > @@projectsFull.length
      render :text => 'There is no such index'
    elsif format == 'json'
      render :json => @@projectsFull[id - 1].to_json
    elsif format == 'xml'
      render :xml => @@projectsFull[id - 1].to_xml(:root => 'project')
    else
      render :text => 'The format has to be xml or json'
    end
  end
  
  def show_count
    format = params[:format]

    if !params[:count].nil?
      count = params[:count].to_i

      if count > @@projectsFull.length
        count = @@projectsFull.length
      end
    else
      count = @@projectsFull.length
    end

    rprojs = @@projectsFull.reverse
    len = rprojs.length
    projs = []

    rprojs.each do |pf|
      if rprojs.index(pf) == count
        break
      end

      proj = {}

      proj[:submited_at] = pf[:submited_at]
      proj[:id] = len - rprojs.index(pf)
      proj[:authors] = pf[:authors]

      projs += [proj]
      proj = nil
    end

    if format == 'json'
      render :json => projs.to_json
    elsif format == 'xml'
      render :xml => projs.to_xml(:root => 'projects', :children => 'project')
    else
      render :text => 'The format has to be xml or json'
    end

    projs = nil
    rprojs = nil
  end
end
