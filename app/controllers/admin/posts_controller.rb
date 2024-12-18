module Admin
  class PostsController < ApplicationController
    before_action :set_post, only: %i[ show edit update destroy publish unpublish ]

    # GET /posts or /posts.json
    def index
      @posts = Post.all
    end

    # GET /posts/1 or /posts/1.json
    def show
    end

    # GET /posts/new
    def new
      @post = Post.new
    end

    # GET /posts/1/edit
    def edit
    end

    # POST /posts or /posts.json
    def create
      @post = Post.new(post_params)

      respond_to do |format|
        if @post.save
          format.html {
            redirect_to admin_post_path(@post), notice: "Post was successfully created."
          }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /posts/1 or /posts/1.json
    def update
      respond_to do |format|
        if @post.update(post_params)
          format.html {
            redirect_to admin_post_path(@post), notice: "Post was successfully updated."
          }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /posts/1 or /posts/1.json
    def destroy
      @post.destroy!

      respond_to do |format|
        format.html {
          redirect_to admin_posts_path, status: :see_other, notice: "Post got destroyed."
        }
      end
    end

    def publish
      if @post.published? || @post.publish
        redirect_to admin_posts_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def unpublish
      @post.unpublish if @post.published?

      redirect_to admin_posts_path
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params.expect(:id))
      end

      # Only allow a list of trusted parameters through.
      def post_params
        params.expect(post: %i[title summary body])
      end
  end
end
