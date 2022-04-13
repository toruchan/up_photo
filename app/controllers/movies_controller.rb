class MoviesController < ApplicationController
  before_action :set_movie, only: [:show]
  before_action :set_category, only: [:index]
  before_action :set_similar_movie, only: [:show]
  before_action :set_same_model_movie, only: [:show]
  before_action :set_tag, only: [:index, :show, :tag]
  before_action :authenticate_user!, except: [:index, :show, :tag]

  PER = 9

  def index
    @movies = Movie.where(movie_category_id: params[:format].to_i).page(params[:page]).per(PER)
  end

  def show

  end

  def tag
    @tag = MovieTag.find(params[:tag_id])
    @category = MovieCategory.find_by(id: params[:category_id])
    @movies = Movie.where(id: MovieMovieTag.where(movie_tag_id: @tag.id).pluck(:movie_id)).page(params[:page]).per(PER)
    @breadcrumbs = {}
    @breadcrumbs['tag'] = @tag
    @breadcrumbs['category'] = @category
  end

  def download
    @movie = Movie.find(params[:movie_id])
    filepath = @movie.movie.current_path
    data = open(@movie.movie.url)
    send_data(data.read, filename: @movie.movie_identifier, type: @movie.movie.content_type)
    user = current_user
    @limit = user.download_limit
    @limit.limit_of_movie -= 1
    @limit.save

  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def set_tag
    @tags = MovieTag.all
  end

  def set_category
    @movie_category = MovieCategory.find(params[:format])
  end

  def set_similar_movie
    @similar_movie = Movie.where(movie_category_id: @movie.movie_category_id).where.not(id: @movie.id)
  end

  def set_same_model_movie
    @movies_of_same_model = Movie.where(movie_model_id: @movie.movie_model_id).where.not(id: @movie.id)
  end

end
