require 'generators/chat_shuttle/orm_helpers'
module Mongoid
  class ChatShuttleGenerator < Rails::Generators::NamedBase
    include ChatShuttle::OrmHelpers
    source_root File.expand_path('../templates', __FILE__)

    class_option :associate_with, type: :string, default: 'User'

    def create_model
      @associate_with = options[:associate_with]
      #invoke "mongoid:model", ["chat_shuttle::#{name}"], '--no-test-framework' unless model_exists? && behavior == :invoke
      #invoke "mongoid:model", ["chat_shuttle::#{name}"] unless model_exists? && behavior == :invoke

      #copy_file "model.rb", "app/models/chat_shuttle/#{name}.rb"

      create_file "app/models/chat_shuttle/#{name}.rb", <<-FILE
module ChatShuttle
  class Notification
    include Mongoid::Document
    field :message, type: String
    field :image_url, type: String, default: ''
    field :sent_at, type: DateTime
    field :read_at, type: DateTime

    belongs_to :reciver, class_name: "#{@associate_with.camelize}"
    belongs_to :sender, class_name: "#{@associate_with.camelize}"

    validates :sender_id, :reciver_id, presence: true
    validates :message, presence: true, if: "image_url.blank?"
    validates :image_url, presence: true, if: "message.blank?"

    private

    def client
      @client ||= Aws::SNS::Client.new(
        region: Aws.config[:region],
        credentials: Aws.config[:credentials]
      )
    end
  end
end
FILE
    end

=begin
    def inject_field_types
      inject_into_file model_path, fields, after: "include Mongoid::Document\n" if model_exists?
    end

    def add_history_tracker
      ##TODO Ask for yes or no to the user to add history tracker or not
    end

    def fields
      <<RUBY
    field :message, type: String
    field :image_url, type: String, default: ''
    field :sent_at, type: DateTime
    field :read_at, type: DateTime

    validate :message, if: "image_url.blank?"
    validate :image_url, if: "message.blank?"
RUBY
    end
=end
  end
end
