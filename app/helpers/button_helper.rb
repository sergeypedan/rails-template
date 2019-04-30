module ButtonHelper

  def button_symbolize(word)
    output = word.downcase.pluralize
  end

  def new_resource_path(record)
    path = button_symbolize(record.class.name.tableize)
    "/admin/#{path}/new"
  end

  def edit_resource_path(record)
    path = button_symbolize(record.class.name.tableize)
    "/admin/#{path}/#{record.id}/edit"
  end



  def new_btn(record, wording="Создать", classes='')
    link_to fa_icon('plus', text: wording), new_resource_path(record), class: "btn btn-primary #{classes}" if current_user_is_admin?
  end



  def save_btn(classes = '')
    button_tag fa_icon('cloud-upload', text: 'Сохранить'), type: :submit, class: "btn btn-primary #{classes}", data: { disable_with: 'Сохраняем...' }
  end



  def edit_btn(record, classes = '')
    link_to "Редактировать", edit_resource_path(record), class: "btn btn-secondary btn-sm #{classes}" if current_user_is_admin?
  end

  def edit_link(record, classes = '')
    link_to fa_icon("pencil", text: "Редактировать", style: "color: hsl(51, 80%, 72%)"), edit_resource_path(record), class: "btn btn-link #{classes}" if current_user_is_admin?
  end

  def edit_btn_small(record, classes = '')
    link_to fa_icon("pencil"), edit_resource_path(record), class: "btn btn-primary btn-sm" if current_user_is_admin?
  end

  def edit_pencil(record, classes = '')
    link_to fa_icon("pencil"), edit_resource_path(record)
  end





  def price_btn(link, price, classes = "")
    link_to link, class: "btn #{classes}", itemprop: "price", content: price do
      fa_icon "shopping-cart", text: number_to_currency(price)
    end
  end

  def buy_price_btn(link, price, classes = "")
    button_label =  if price > 0
                      ("Купить: " + number_to_currency(price)).html_safe
                    else
                      "Бесплатно!"
                    end

    link_to link, class: "btn #{classes}", itemprop: "price", content: price do
      fa_icon "shopping-cart", text: button_label
    end
  end




  def delete_btn(record, classes = "")
    delete_checker = ::CanDeleteRecord.new(record)

    if delete_checker.can?
      link_to "Удалить", [:admin, record], method: :delete, data: { confirm: 'Точно удаляем?' }, class: ["btn", "btn-outline-danger", classes]
    else
      message = "Запись нельзя удалить, т. к. #{delete_checker.error_messages.first}"
      data    = { toggle: "tooltip", original_title: message }
      link_to "Удалить нельзя", "#", class: ["btn", "btn-outline-danger", classes, "disabled"], disabled: true, data: data
    end
  end

  def delete_can(record, classes = "")
    delete_checker = ::CanDeleteRecord.new(record)

    if delete_checker.can?
      link_to fa_icon("trash"), [:admin, record], method: :delete, title: "Удалить", data: { confirm: 'Точно удаляем?' }, class: ["btn", "btn-outline-danger", "btn-sm", classes]
    else
      message = "Запись нельзя удалить, т. к. #{delete_checker.error_messages.first}"
      data    = { toggle: "tooltip", original_title: message }
      tag.button fa_icon("trash", style: "color: hsl(0, 0%, 70%)"), class: "btn btn-outline-danger btn-sm", style: "cursor: not-allowed; border-color: hsl(0, 0%, 70%)", data: data
    end
  end

end
