# frozen_string_literal: true

# https://github.com/ctran/annotate_models#options
# NOTE: only doing this in development as some production environments (Heroku) are sensitive to local FS writes, and besides -- it's just not proper to have a dev-mode tool do its thing in production.
# You can override any of these by setting an environment variable of the same name

if Rails.env.development?
  require 'annotate'

  task :set_annotation_options do
    # You can override any of these by setting an environment variable of the same name.
    Annotate.set_defaults(
      'additional_file_patterns'  => [],
      'classified_sort'           => true,
      'exclude_controllers'       => true,
      'exclude_factories'         => true,
      'exclude_fixtures'          => true,
      'exclude_helpers'           => true,
      'exclude_scaffolds'         => true,
      'exclude_serializers'       => true,
      'exclude_sti_subclasses'    => false,
      'exclude_tests'             => true,
      'force'                     => false,
      'format_bare'               => true,
      'format_markdown'           => false,
      'format_rdoc'               => false,
      'hide_default_column_types' => 'json,jsonb,hstore',
      'hide_limit_column_types'   => 'integer,bigint,boolean',
      'ignore_columns'            => 'created_at|updated_at', # regex
      'ignore_model_sub_dir'      => false,
      'ignore_routes'             => nil,
      'ignore_unknown_models'     => false,
      'include_version'           => true,
      'model_dir'                 => 'app/models',
      'models'                    => true,
      'position_in_class'         => 'after',
      'position_in_factory'       => 'before',
      'position_in_fixture'       => 'before',
      'position_in_routes'        => 'before',
      'position_in_serializer'    => 'before',
      'position_in_test'          => 'before',
      'require'                   => '',
      'root_dir'                  => '',
      'routes'                    => false,
      'show_complete_foreign_keys' => false,
      'show_foreign_keys'         => true,
      'show_indexes'              => true,
      'simple_indexes'            => false,
      'skip_on_db_migrate'        => false,
      'sort'                      => true,
      'trace'                     => false,
      'with_comment'              => false,
      'wrapper_close'             => nil,
      'wrapper_open'              => nil
    )
  end

  Annotate.load_tasks
end
