require 'to_json_fix'

class HospController < ApplicationController
  before_action :authorize_request

  def add
    @id = params[:id]
    @name = params[:name]
    @latitude = params[:latitude]
    @longitude = params[:longitude]

    @user = User.find_by(id: @id)
    @likes = JSON.parse(@user.likes)

    @cnt = 0
    @likes.each do |like|
      if like['latitude'] == @latitude && like['longitude'] == @longitude
        @cnt += 1
        break
      end
    end

    if @cnt == 0
      @likes.push({ name: @name, latitude: @latitude, longitude: @longitude })
      @user.likes = @likes.to_json
      @user.save

      render json: { success: true, result: @user }

    else
      if @likes.length() >= 10
        render json: { success: false, error: '사용 가능한 좋아요 수를 넘었습니다.' }
      else
        render json: { success: false, error: '이미 저장된 병원입니다.' }
      end
    end
  end

  def remove
    @id = params[:id]
    @latitude = params[:latitude]
    @longitude = params[:longitude]

    @user = User.find_by(id: @id)
    @likes = JSON.parse(@user.likes)

    @cnt = 0; @index = 0
    @likes.each_with_index do |like, index|
      if like['latitude'] == @latitude && like['longitude'] == @longitude
        @cnt += 1
        @index = index
        break
      end
    end

    if @cnt > 0
      render json: { success: true, result: @likes[@index] }
      @likes.delete_at(@index)

      @user.likes = @likes.to_json
      @user.save
    else
      render json: { success: false, error: '삭제할 개체를 찾지 못하였습니다.' }
    end
  end
  
  def find
    @id = params[:id]
    @latitude = params[:latitude]
    @longitude = params[:longitude]

    @user = User.find_by(id: @id)
    @likes = JSON.parse(@user.likes)

    @cnt = 0
    @likes.each do |like|
      if like['latitude'] == @latitude && like['longitude'] == @longitude
        @cnt += 1
      end
    end

    if @cnt > 0
      render json: { success: true }
    else
      render json: { success: false }
    end
  end
end