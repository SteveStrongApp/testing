# frozen_string_literal: true
require 'fileutils'
require 'pty'

class Container < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include Model
    include Policy
    include Datalift::Operation::Helpers

    model Container, :create

    contract do
      include Datalift::Contract::Helpers

      # property :user
      property :image_id

      validates :image_id, presence: true, allow_nil: false
      validate :image_exists?
      validate :unique_namespace_name?

      def image_exists?
        return unless image_id
        @image = Image.find(image_id) unless image_id.nil?
        errors.add(:image, 'does not exist') unless @image
      end

      def unique_namespace_name?
        return unless image_id
        @image = Image.find(image_id)
        return unless @image[:name] && @image[:namespace]
        container = Container.where(name: @image[:name]).where(namespace: @image[:namespace])
        errors.add(:base, 'container name already taken') if container.exists?
      end
    end

    def process(params)
      validate params do
        container = Container.create(image_id: params[:image_id])
        Container::Start.run id: container.id
      end
    end
  end
end
