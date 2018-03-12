module ChatShuttle
  ## TODO: This model name should be dynamic
  class Notification
    include Mongoid::Document
    field :message, type: String
    field :image_url, type: String, default: ''
    field :sent_at, type: DateTime
    field :read_at, type: DateTime

    belongs_to :reciver, class_name: associate_with ## TODO This has to be dynamic
    belongs_to :sender, class_name: associate_with

    validates :sender_id, :reciver_id, presence: true
    validates :message, presence: true, if: "image_url.blank?"
    validates :image_url, presence: true, if: "message.blank?"
  end
end
