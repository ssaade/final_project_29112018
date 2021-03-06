  class SlotsController < ApplicationController
  before_action :current_user_must_be_slot_user, :only => [:edit_form, :update_row, :destroy_row]

  def current_user_must_be_slot_user
    slot = Slot.find(params["id_to_display"] || params["prefill_with_id"] || params["id_to_modify"] || params["id_to_remove"])

    unless current_user == slot.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def home
    render("slot_templates/home.html.erb")
  end

  def index
    @q = current_user.slots.ransack(params[:q])
    @slots = @q.result(:distinct => true).includes(:user, :sent_matches, :received_matches).page(params[:page]).per(10).order(:start_time)
 
    render("slot_templates/index.html.erb")
  end

  def show
    @match = Match.new
    @slot = Slot.find(params.fetch("id_to_display"))

    render("slot_templates/show.html.erb")
  end

  def new_form
    @slot = Slot.new
  
    render("slot_templates/new_form.html.erb")
  end

  def create_row
    @slot = Slot.new
    @slot.user_id = params.fetch("user_id")
    @slot.start_time = DateTime.strptime(params.fetch("start_time"), "%m/%d/%Y %l:%M %P")
    @slot.end_time = DateTime.strptime(params.fetch("end_time"), "%m/%d/%Y %l:%M %P")
    
    if @slot.valid?
      @slot.save
      
      slot_list = Slot.all
      
      slot_list.each do |candidate_slot|
        
        
        if candidate_slot.user_id != current_user.id && candidate_slot.start_time.to_date == @slot.start_time.to_date
          
            @match = Match.new
            
            @match.sender_slot_id = @slot.id
            @match.recipient_slot_id = candidate_slot.id
            
            if @slot.start_time > candidate_slot.start_time
              @match.start_time = @slot.start_time
            else
              @match.start_time = candidate_slot.start_time            
            end
            
            if @slot.end_time < candidate_slot.end_time
              @match.end_time = @slot.end_time
            else
              @match.end_time = candidate_slot.end_time            
            end
            
            @match.save
          
        end
      end

      redirect_to "/slots", notice: "Slot created successfully!"
    else
      render("slot_templates/new_form_with_errors.html.erb")
    end
  end

  def edit_form
    @slot = Slot.find(params.fetch("prefill_with_id"))
    
    render("slot_templates/edit_form.html.erb")
  end

  def update_row
    @slot = Slot.find(params.fetch("id_to_modify"))
    
    @slot.start_time = DateTime.strptime(params.fetch("start_time"), "%m/%d/%Y %l:%M %P")
    @slot.end_time = DateTime.strptime(params.fetch("end_time"), "%m/%d/%Y %l:%M %P")

    if @slot.valid?
      @slot.save
      
    #Remove all matches that have this current slot
    Match.where(sender_slot_id: @slot.id).delete_all
    Match.where(recipient_slot_id: @slot.id).delete_all
    
    slot_list = Slot.all
      
      slot_list.each do |candidate_slot|
        
        if candidate_slot.user_id != current_user.id && candidate_slot.start_time.to_date == @slot.start_time.to_date
          
            @match = Match.new
            
            @match.sender_slot_id = @slot.id
            @match.recipient_slot_id = candidate_slot.id
            
            if @slot.start_time > candidate_slot.start_time
              @match.start_time = @slot.start_time
            else
              @match.start_time = candidate_slot.start_time            
            end
            
            if @slot.end_time < candidate_slot.end_time
              @match.end_time = @slot.end_time
            else
              @match.end_time = candidate_slot.end_time            
            end
            
            @match.save
          
        end
      end

      redirect_to("/slots/#{@slot.id}", :notice => "Slot updated successfully.")
    else
      render("slot_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row_from_user
    @slot = Slot.find(params.fetch("id_to_remove"))

    @slot.destroy

    redirect_to("/users/#{@slot.user_id}", notice: "Slot deleted successfully.")
  end

  def destroy_row
    @slot = Slot.find(params.fetch("id_to_remove"))
    
    #Also destroy all matches that have this current slot
    Match.where(sender_slot_id: @slot.id).delete_all
    Match.where(recipient_slot_id: @slot.id).delete_all

    @slot.destroy

    redirect_to("/slots", :notice => "Slot deleted successfully.")
  end
  
  end
