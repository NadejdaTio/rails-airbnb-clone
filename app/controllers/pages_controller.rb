class PagesController < ApplicationController
  def home
    @selections = Game.all.shuffle[0...3]
  end
end
