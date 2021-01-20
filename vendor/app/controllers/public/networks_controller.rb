class Public::NetworksController < ApplicationController
  def index
    @first = current_person.sponsee

    @second = []
    @first.each do |first|
      first.sponsee.each do |f|
        @second << f
      end
    end

    @third = []
    @second.each do |second|
      second.sponsee.each do |s|
        @third << s
      end
    end

    @forth = []
    if current_person.get_membership == "Standard"
      @third.each do |third|
        third.sponsee.each do |s|
          @forth << s
        end
      end

      @fifth = []
      if current_person.get_membership == "Premium"
        @fifth.each do |fifth|
          fifth.sponsee.each do |s|
            @fifth << s
          end
        end
      end

    else
      @forth = nil
    end

  end
end
