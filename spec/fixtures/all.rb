module Fixtures
end

path = File.expand_path("..", __FILE__)
Dir[File.join(path, "**/*.rb")].each do |mod|
  require mod
end

