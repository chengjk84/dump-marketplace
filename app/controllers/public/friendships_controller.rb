class Public::FriendshipsController < ApplicationController
  def index
    @friends = current_person.friends
  end

  def create
    @friendship = current_person.friendships.build(:friend_id => params[:friend_id])

    if @friendship.save
      friend = Person.find(params[:friend_id])
      redirect_to :back, notice: '<span class="text-semibold">Friend Added!</span> Now you can start see collection feed from your friend.'
    else
      flash[:notice] = "Unable to add friend."
      redirect_to root_url
    end
  end

  def destroy
    @friendship = current_person.friendships.find_by_friend_id(params[:id])
    @friendship.destroy
    redirect_to :back, notice: '<span class="text-semibold">Friend Removed!</span> Now you will stop seeing collection feed from your friend.'
  end
end
