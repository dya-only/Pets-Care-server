class CafeController < ApplicationController
  def add
    @id = params[:id]
    @name = params[:name]
    @latitude = params[:latitude]
    @longitude = params[:longitude]

    @user = User.find_by(id: @id)
    @likes = eval(@user.likes)

    @cnt = 0
    @likes.each do |x|
      if x[:latitude] == @latitude && x[:longitude] == @longitude
        @cnt += 1
      end
    end

    if @cnt == 0
      @likes.push({ name: @name, latitude: @latitude, longitude: @longitude })
      @user.likes = @likes.to_s
      @user.save

      render json: { message: @user }, status: :ok

    else
      render json: { message: '이미 저장된 카페입니다.' }, status: :already_reported
    end

  end

  def remove
    @id = params[:id]

  end

  def getLikes
    @id = params[:id]
    @user = User.find_by(id: @id)
    @likes = eval(@user.likes)

    render json: @likes
  end
end