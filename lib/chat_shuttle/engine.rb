module ChatShuttle
  class Engine < ::Rails::Engine
    isolate_namespace ChatShuttle
    config.generators.api_only = true
  end
end
