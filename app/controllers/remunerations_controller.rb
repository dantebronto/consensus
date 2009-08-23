class RemunerationsController < ApplicationController
  def show
    render :text => params[:name]
  end
  
  def edit
    @remuns = RemunerationContributor.all
    @allocation = @remuns.map &:percentage
    @allocation = Vote.round_robin(@remuns.length) if @allocation.compact.blank?    
  end
  
  def update
    @remuns = RemunerationContributor.all
    @remuns.each { |re| re.update_attribute(:percentage, params[:options][re.id.to_s]) } if params[:options]
    
    flash[:notice] = "schedule updated"
    redirect_to :action => 'edit'
  end
end