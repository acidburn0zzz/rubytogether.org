class NewsController < ApplicationController
  after_action :set_cache_control_headers

  def index
    @posts = Post.all
  end

  def show
    name = sanitize_filename(params[:id])
    render Post.find!(name).id
  end

private

  def sanitize_filename(id)
    id.strip.tap do |name|
      # NOTE: File.basename doesn't work right with Windows paths on Unix
      # get only the filename, not the whole path
      name.sub! /\A.*(\\|\/)/, ''
      # Finally, replace all non alphanumeric, underscore
      # or periods with underscore
      name.gsub! /[^\w\.\-]/, '_'
    end
  end

end
