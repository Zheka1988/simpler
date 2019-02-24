require 'yaml'
require 'singleton'
require 'sequel'
require_relative 'router'
require_relative 'controller'

module Simpler
  class Application

    include Singleton

    attr_reader :db

    def initialize
      @router = Router.new
      @db = nil
    end

    def bootstrap!
      setup_database
      require_app
      require_routes
    end

    def call(env)
      route = @router.route_for(env)
      return page_not_found unless route
      
      env['simpler.params'] ||= {}
      env['simpler.params'].merge!(route.params(env))
      
      controller = route.controller.new(env)
      action = route.action
      make_response(controller, action)
    end

    def routes(&block)
      @router.instance_eval(&block)
    end

    private

    def require_app
      Dir["#{Simpler.root}/app/**/*.rb"].each { |file| require file }
    end

    def require_routes
      require Simpler.root.join('config/routes')
    end

    def setup_database
      database_config = YAML.load_file(Simpler.root.join('config/database.yml'))
      database_config['database'] = Simpler.root.join(database_config['database'])
      @db = Sequel.connect(database_config)
    end

    def make_response(controller, action)
      controller.make_response(action)
    end

    def page_not_found
      [404, {'Content-Type' => 'text/plain'}, ["404 Not Found\n"]]
    end

  end
end
