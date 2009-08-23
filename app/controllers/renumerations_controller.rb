class RenumerationsController < ApplicationController
  def edit
    @renums = RenumerationContributor.all
    
    if @renums.map(&:percentage).compact.blank?
      @allocation = Vote.round_robin(@renums.length)
    else
      @allocation = @renums.map &:percentage
    end
    
  end
end