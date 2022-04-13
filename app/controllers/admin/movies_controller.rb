# coding: utf-8
class Admin::MoviesController < ApplicationController
  def index
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to admin_movies_path, notice: '動画が追加されました。'
    end
  end

  private

  def movie_params
    params[:movie].permit(
      :movie
    )
  end
end
