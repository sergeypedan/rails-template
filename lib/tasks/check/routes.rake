# frozen_string_literal: true

desc "Checks unused routes"
# Extracted from traceroute gem + checking the presence of views as well
# https://gist.github.com/strzibny/4ccbda7dcf67ef6719dcb047014e1ea7

namespace :check do
  task routes: :environment do
    # require_relative './config/environment.rb'

    class Traceroute
      def initialize(app)
        @app = app
      end

      def load_everything!
        @app.eager_load!
        ::Rails::InfoController    rescue NameError
        ::Rails::WelcomeController rescue NameError
        ::Rails::MailersController rescue NameError
        @app.reload_routes!

        Rails::Engine.subclasses.each(&:eager_load!)
      end

      def views
        Dir.glob("#{Rails.root}/app/views/**/*").each do |view|
          view.gsub!(/(.*\/[^\/\.]+)[^\/]+/, '\\1')
        end
      end

      def unused_routes
        (routed_actions - defined_action_methods).reject do |path|
          views.include? "#{Rails.root}/app/views/#{path.gsub('#', '/') }"
        end
      end

      def defined_action_methods
        ActionController::Base.descendants.map { |controller|
          controller.action_methods.reject { |a| (a =~ /\A(_conditional)?_callback_/) || (a == '_layout_from_proc') }.map do |action|
            "#{controller.controller_path}##{action}"
          end
        }.flatten.reject { |r| r.start_with? 'rails/' }
      end

      def routed_actions
        routes.map { |r|
          if r.requirements[:controller].blank? && r.requirements[:action].blank? && (r.path == '/:controller(/:action(/:id(.:format)))')
            %Q["#{r.path}"  This is a legacy wild controller route that's not recommended for RESTful applications.]
          else
            "#{r.requirements[:controller]}##{r.requirements[:action]}"
          end
        }.reject { |r| r.start_with? 'rails/' }
      end

      private

      def routes
        routes = @app.routes.routes.reject { |r| r.name.nil? && r.requirements.blank? }
        routes.reject! { |r| r.app.is_a?(ActionDispatch::Routing::Mapper::Constraints) && r.app.app.respond_to?(:call) }
        routes.reject! { |r| r.app.is_a?(ActionDispatch::Routing::Redirect) }

        if @app.config.respond_to?(:assets)
          exclusion_regexp = %r{^#{@app.config.assets.prefix}}

          routes.reject! do |route|
            path = (defined?(ActionDispatch::Journey::Route) || defined?(Journey::Route)) ? route.path.spec.to_s : route.path
            path =~ exclusion_regexp
          end
        end
        routes
      end
    end

    traceroute = Traceroute.new Rails.application
    traceroute.load_everything!
    unused_routes = traceroute.unused_routes

    puts "Unused routes (#{unused_routes.count}):"
    unused_routes.each { |route| puts "  #{route}" }

    unless unused_routes.empty? || ENV['FAIL_ON_ERROR'].blank?
      fail "Unused routes detected."
    end
  end
end


