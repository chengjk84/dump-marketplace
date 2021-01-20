class Public::CollectionsController < ApplicationController
  def index
    @feeds = []

    personal_collections = current_person.collections

    if personal_collections.present?
      personal_collections.each do |collection|
        @feeds << collection
      end
    end

    friends = current_person.friends
    if friends.present?
      friends.each do |friend|

        collections = friend.collections
        if collections.present?
          collections.each do |collection|
            @feeds << collection
          end
        end

      end
    end

    @collections = @feeds.reverse!
  end

  def create
    @collections = current_person.collections

    if @collections.present?
      @collection = current_person.collections.last

      created_at = @collection.created_at + 24.hours

      if created_at < DateTime.now
        @collection = current_person.collections.build
        @collection.name = "Collection of #{Date.today}"
        @collection.save

        @entry = @collection.entries.build
        @entry.product_id = params[:product_id]

        if @entry.save
          redirect_to :back, notice: '<span class="text-semibold">Well done!</span> Product was added to collection.'
        else
          redirect_to :back, alert: '<span class="text-semibold">Oh snap!</span> Promotion process fail.'
        end

      else
        if @collection.entries.count < 6

          if @collection.entries.find_by_product_id(params[:product_id]).present?
            redirect_to :back, alert: '<span class="text-semibold">Oh snap!</span> Product already in collection.'
          else
            @entry = @collection.entries.build
            @entry.product_id = params[:product_id]

            if @entry.save
              redirect_to :back, notice: '<span class="text-semibold">Well done!</span> Product was added to collection.'
            else
              redirect_to :back, alert: '<span class="text-semibold">Oh snap!</span> Promotion process fail.'
            end
          end

        else
          redirect_to :back, alert: '<span class="text-semibold">Oh snap!</span> Collection entries reach limit of 6.'
        end
      end
    else
      @collection = current_person.collections.build
      @collection.name = "Collection of #{Date.today}"
      @collection.save

      @entry = @collection.entries.build
      @entry.product_id = params[:product_id]

      if @entry.save
        redirect_to :back, notice: '<span class="text-semibold">Well done!</span> Product was added to collection.'
      else
        redirect_to :back, alert: '<span class="text-semibold">Oh snap!</span> Promotion process fail.'
      end
    end
  end
end
