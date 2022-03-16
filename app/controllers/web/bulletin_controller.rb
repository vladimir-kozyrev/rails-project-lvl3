module Web
  class BulletinController < ApplicationController
    def index
      @bulletins = Bulletin.all.order(created_at: :desc)
    end
  end
end
