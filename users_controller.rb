# frozen_string_literal: true
module Api
  class UsersController < ApiController
    def me
      respond_with user
    end

    def show
      failed_op = run User::Show, params: params do |op|
        return respond_with op.model
      end

      unacceptable_entity! failed_op.errors
    end

    def update
      failed_op = run User::Update, params: update_params do |op|
        return respond_with op.model
      end

      unacceptable_entity! failed_op.errors
    end

    def active
      failed_op = run User::Active do |op|
        return respond_with op.model
      end

      unacceptable_entity! failed_op.errors
    end

    def index
      failed_op = run User::Index, params: params do |op|
        return respond_with op.model, op.render_params
      end

      unacceptable_entity! failed_op.errors
    end

    private

    def user
      @_user ||= current_user.tap { |u| authorize u }
    end

    def update_params
      params.merge(id: current_user.id)
    end
  end
end
