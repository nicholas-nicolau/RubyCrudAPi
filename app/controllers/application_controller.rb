class ApplicationController < ActionController::API
    before_action :ensure_format_request

    def ensure_format_request
        case request.method
        when "POST","PATCH","PUT"
            return if request.headers["Accept"] =~ /multipart\/form\-data/
            render json: {"message:":"please send a 'multipart/form-data' header for this method"}, :status => 406

        else
            return if request.headers["Accept"] =~ /application\/json/
            render json: {"message:":"please send a 'application/json' header for this method"}, :status => 406
        end
    end
end
