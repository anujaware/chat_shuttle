require 'generators/chat_shuttle/orm_helpers'
module Mongoid
  class ChatShuttleGenerator < Rails::Generators::NamedBase
    include ChatShuttle::OrmHelpers
    source_root File.expand_path('../templates', __FILE__)

    def generate_model
      invoke "mongoid:model", [name] unless model_exists? && behavior == :invoke
    end

    def inject_field_types
      inject_into_file model_path, migration_data, after: "include Mongoid::Document\n" if model_exists?
    end

    def add_history_tracker
      ##TODO Ask for yes or no to the user to add history tracker or not
    end

    def fields
      <<RUBY
      include Mongoid::Timestamp

      field :message, type: String
      field :image_url, type: String, default: ''
      field :sent_at, type: DateTime
      field :read_at, type: DateTime

      validate :message, if: "image_url.blank?"
      validate :image_url, if: "message.blank?"
RUBY
    end
  end
end
