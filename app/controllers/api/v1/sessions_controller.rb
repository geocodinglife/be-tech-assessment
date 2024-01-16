# app/controllers/api/v1/sessions_controller.rb
module Api
  module V1
    class SessionsController < ApplicationController
      def create
        session = Session.new(session_params)

        if session.save
          render json: { status: 'Session created successfully' }, status: :created
        else
          render json: { errors: session.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def session_params
        params.require(:session).permit(:coach_hash_id, :client_hash_id, :start, :duration)
      end
    end
  end
end
