class HashtagsController < ApplicationController 
  def index
    @hashtags = Hashtag.all
    
  end
end