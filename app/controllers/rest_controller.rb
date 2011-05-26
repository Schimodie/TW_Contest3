require 'csv'

class RestController < ApplicationController
  def api
  end

  def show_id
    id = params[:id].to_i
    format = params[:format]

    projects = self.getProjects

    if id <= 0 || id > projects.length
      render :text => 'There is no such index'
    elsif format == 'json'
      render :json => projects[id - 1].to_json
    elsif format == 'xml'
      render :xml => projects[id - 1].to_xml(:root => 'project')
    else
      render :text => 'The format has to be xml or json'
    end

    file = nil
    csv = nil
    projects = nil
  end

  def show_count
    format = params[:format]

    projects = self.getProjects

    if !params[:count].nil?
      count = params[:count].to_i

      if count > projects.length
        count = projects.length
      end
    else
      count = projects.length
    end

    rprojs = projects.reverse
    projects = nil
    len = rprojs.length
    projs = []

    rprojs.each do |rp|
      if rprojs.index(rp) == count
        break
      end
      proj = {}

      proj[:submited_at] = rp[:submited_at]
      proj[:id] = len - rprojs.index(rp)
      proj[:authors] = rp[:authors]

      projs += [proj]
    end

    rprojs = nil

    if format == 'json'
      render :json => projs.to_json
    elsif format == 'xml'
      render :xml => projs.to_xml(:root => 'projects', :children => 'project')
    else
      render :text => 'The format has to be xml or json'
    end

    projs = nil
  end

  def getProjects
    csv = CSV::parse(File.open(Rails.root + 'contest.csv') { |f| f.read })
    csv.shift

    projects = []

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

      projects += [project]
    end

    csv = nil
    projects
  end
end

