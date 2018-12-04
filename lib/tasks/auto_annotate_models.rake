# frozen_string_literal: true

# https://github.com/ctran/annotate_models#options
# NOTE: only doing this in development as some production environments (Heroku) are sensitive to local FS writes, and besides -- it's just not proper to have a dev-mode tool do its thing in production.
# You can override any of these by setting an environment variable of the same name

if Rails.env.development?
  require 'annotate'

  task :set_annotation_options do
    Annotate.set_defaults(
      'exclude_controllers'        => true,
      'exclude_factories'          => true,
      'exclude_fixtures'           => true,
      'exclude_helpers'            => true,
      'exclude_scaffolds'          => true,
      'exclude_serializers'        => true,
      'exclude_sti_subclasses'     => false,
      'exclude_tests'              => true,
      'force'                      => false,
      'format_bare'                => true,
      'format_markdown'            => false,
      'format_rdoc'                => false,
      'hide_default_column_types'  => 'json,jsonb,hstore',
      'hide_limit_column_types'    => nil,
      'ignore_columns'             => 'created_at|updated_at', # regex
      'ignore_model_sub_dir'       => false,
      'ignore_routes'              => nil,
      'ignore_unknown_models'      => true,
      'include_version'            => false,
      'model_dir'                  => 'app/models',
      'position_in_class'          => 'after',
      'position_in_factory'        => 'after',
      'position_in_fixture'        => 'after',
      'position_in_routes'         => 'after',
      'position_in_serializer'     => 'after',
      'position_in_test'           => 'after',
      'require'                    => '',
      'root_dir'                   => '',
      'routes'                     => false,
      'show_complete_foreign_keys' => false,
      'show_foreign_keys'          => true,
      'show_indexes'               => false,
      'simple_indexes'             => false,
      'skip_on_db_migrate'         => false,
      'sort'                       => true,
      'trace'                      => false,
      'with_comment'               => true,
      'wrapper_close'              => nil,
      'wrapper_open'               => nil
    )
  end

  Annotate.load_tasks
end
