ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1
  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Recent Orders' do
          table_for Order.last(10) do
            column('State') { |order| status_tag(order.state) }
            column('Customer', &:user_id)
            column('Total') { |order| number_to_currency order.subtotal, unit: '€' }
          end
        end
      end

      column do
        panel 'Recent Customers' do
          table_for User.order('id desc').limit(10).each do |_customer|
            column(:email, &:email)
            column(:first_name, &:first_name)
            column(:last_name, &:last_name)
          end
        end
      end
    end

    columns do
      column do
        div do
          br
          text_node %(<iframe src="https://rpm.newrelic.com/public/charts/6VooNO2hKWB" width="500" height="300" scrolling="no" frameborder="no"></iframe>).html_safe
        end
      end
    end
  end
end
