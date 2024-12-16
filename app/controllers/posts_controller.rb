class PostsController < ApplicationController
  before_action :set_post, only: %i[ show ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all.published
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post.visited!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params.expect(:id))

      raise ActiveRecord::RecordNotFound unless @post.published?
    end
end
