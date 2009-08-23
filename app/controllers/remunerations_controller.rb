class RemunerationsController < ApplicationController
  def edit
    @remuns = RemunerationContributor.all
    
    if @remuns.map(&:percentage).compact.blank?
      @allocation = Vote.round_robin(@remuns.length)
    else
      @allocation = @remuns.map &:percentage
    end
    
  end
end