ActiveAdmin.register Order do

  permit_params :order_number, :card_number, :name_on_card, :mm_yy, :cvv, :state, :subtotal, :cupon_id, :delivery_id

  index do
    column :id
    column :name_on_card
    column :mm_yy
    column("State", :sortable => :state) {|order| status_tag(order.state) }
    column :subtotal do |product|
      number_to_currency product.subtotal, :unit => "€"
    end
    actions
  end

  after_save do |order|
    event = params[:order][:active_admin_requested_event]
    unless event.blank?
      safe_event = (order.aasm.events(permitted: true).map(&:name) & [event.to_sym]).first
      raise "Forbidden event #{event} requested on instance #{your_model.id}" unless safe_event
      order.send("#{safe_event}!")
    end
  end

  form do |f|
    f.input :state, input_html: { disabled: true }, label: 'Current state'
    f.input :active_admin_requested_event, label: 'Change state', as: :select, collection: f.object.aasm.events(permitted: true).map(&:name)
    f.actions
  end

  permit_params :active_admin_requested_event, :subtotal, :state, :id, :update_at
end