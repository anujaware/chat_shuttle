module ChatShuttle
  module OrmHelpers
    def model_exists?
      File.exist?(File.join(destination_root, model_path))
    end

    def model_path
      @model_path ||= File.join("app", "models", "chat_shuttle", "#{file_path}.rb")
    end
  end
end
