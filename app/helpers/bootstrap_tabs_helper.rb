# frozen_string_literal: true

module BootstrapTabsHelper

  def tab_btn_id(namespace, key)
    tab_pane_id(namespace, key) + "-tab"
  end

  def tab_pane_id(namespace, key)
    "#{namespace}-#{key}"
  end

end
