class WorkingHoursController < ApplicationController

    def index
        @artist = Artist.find(params[:artist_id])
        @working_hours = @artist.working_hours
    end

    def new
        @artist = Artist.find(params[:artist_id])
        @working_hours = WorkingHour.new
    end

    def create
        @working_hours = WorkingHour.new
        @holidays = @working_hours.holidays = []
        hours_params
        @working_hours.artist_id = params[:artist_id]
        @working_hours.save
        @artist = Artist.find(params[:artist_id])
        if @working_hours.save
            redirect_to artist_path(@artist)
          else
            render :new
        end
    end

    def edit
        @holidays = WorkingHour.find(params[:id]).holidays
        @holidays.sort if @holidays
        @holidays = @holidays.join(", ") if @holidays
        @artist = WorkingHour.find(params[:id]).artist
        @working_hours = WorkingHour.find(params[:id])
        
    end

    def update
        @working_hours = WorkingHour.find(params[:id])
        @artist = @working_hours.artist
        @working_hours.holidays = []
        hours_params
        @working_hours.save
        redirect_to artist_path(@artist.id)
        
    end

    def destroy
        @working_hours = WorkingHour.find(params[:id])
        @artist = @working_hours.artist
        @working_hours.destroy
        redirect_to artist_path(@artist.id)
    end
    
    private
    
    def hours_params
        params[:working_hour]['mondaystart_time(4i)'].present? ? @working_hours.mondaystart_time = "#{params[:working_hour]['mondaystart_time(4i)']}:#{params[:working_hour]['mondaystart_time(5i)']}" : @working_hours.mondaystart_time = nil
        params[:working_hour]['mondayend_time(4i)'].present? ? @working_hours.mondayend_time = "#{params[:working_hour]['mondayend_time(4i)']}:#{params[:working_hour]['mondayend_time(5i)']}" : @working_hours.mondayend_time = nil
        params[:working_hour]['tuesdaystart_time(4i)'].present? ? @working_hours.tuesdaystart_time = "#{params[:working_hour]['tuesdaystart_time(4i)']}:#{params[:working_hour]['tuesdaystart_time(5i)']}" : @working_hours.tuesdaystart_time = nil
        params[:working_hour]['tuesdaystart_time(4i)'].present? ? @working_hours.tuesdayend_time = "#{params[:working_hour]['tuesdayend_time(4i)']}:#{params[:working_hour]['tuesdayend_time(5i)']}" : @working_hours.tuesdayend_time = nil
        params[:working_hour]['wednesdaystart_time(4i)'].present? ? @working_hours.wednesdaystart_time = "#{params[:working_hour]['wednesdaystart_time(4i)']}:#{params[:working_hour]['wednesdaystart_time(5i)']}" : @working_hours.wednesdaystart_time = nil
        params[:working_hour]['wednesdaystart_time(4i)'].present? ? @working_hours.wednesdayend_time = "#{params[:working_hour]['wednesdayend_time(4i)']}:#{params[:working_hour]['wednesdayend_time(5i)']}" : @working_hours.wednesdayend_time = nil
        params[:working_hour]['thursdaystart_time(4i)'].present? ? @working_hours.thursdaystart_time = "#{params[:working_hour]['thursdaystart_time(4i)']}:#{params[:working_hour]['thursdaystart_time(5i)']}" : @working_hours.thursdaystart_time = nil 
        params[:working_hour]['thursdaystart_time(4i)'].present? ? @working_hours.thursdayend_time = "#{params[:working_hour]['thursdayend_time(4i)']}:#{params[:working_hour]['thursdayend_time(5i)']}" : @working_hours.thursdayend_time = nil 
        params[:working_hour]['fridaystart_time(4i)'].present? ? @working_hours.fridaystart_time = "#{params[:working_hour]['fridaystart_time(4i)']}:#{params[:working_hour]['fridaystart_time(5i)']}" : @working_hours.fridaystart_time = nil 
        params[:working_hour]['fridaystart_time(4i)'].present? ? @working_hours.fridayend_time = "#{params[:working_hour]['fridayend_time(4i)']}:#{params[:working_hour]['fridayend_time(5i)']}" : @working_hours.fridayend_time = nil 
        params[:working_hour]['saturdaystart_time(4i)'].present? ? @working_hours.saturdaystart_time = "#{params[:working_hour]['saturdaystart_time(4i)']}:#{params[:working_hour]['saturdaystart_time(5i)']}" : @working_hours.saturdaystart_time = nil 
        params[:working_hour]['saturdaystart_time(4i)'].present? ? @working_hours.saturdayend_time = "#{params[:working_hour]['saturdayend_time(4i)']}:#{params[:working_hour]['saturdayend_time(5i)']}" :  @working_hours.saturdayend_time = nil 
        params[:working_hour]['sundaystart_time(4i)'].present? ? @working_hours.sundaystart_time = "#{params[:working_hour]['sundaystart_time(4i)']}:#{params[:working_hour]['sundaystart_time(5i)']}" : @working_hours.sundaystart_time = nil 
        params[:working_hour]['sundaystart_time(4i)'].present? ? @working_hours.sundayend_time = "#{params[:working_hour]['sundayend_time(4i)']}:#{params[:working_hour]['sundayend_time(5i)']}" : @working_hours.sundayend_time = nil
        params[:working_hour]['holidays'].present? ? params[:working_hour]['holidays'].split(",").each {|x| @working_hours.holidays.push(x) if x.present? && x != "Invalid Date"}: @working_hours.holidays = []
        
    end

end
