class ApplicationController < ActionController::API
    include Response
    
    rescue_from ActiveRecord::RecordNotFound do |e|
        json_response({error: e.message}, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e| 
        json_response({error: e.message}, :unprocessable_entity)
    end

    rescue_from StandardError do |e|
        json_response({error: e.message}, :unprocessable_entity)
    end


end
