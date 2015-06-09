require 'bundler/setup'

require 'pry'

require_relative './miqrow/api_client'
require_relative './miqrow/app_controller'

module MiqRow
  VERSION = '0.1'
end

QML.run do |app|
  app.load_path Pathname(__FILE__) + '../miqrow/qml/main.qml'
end
