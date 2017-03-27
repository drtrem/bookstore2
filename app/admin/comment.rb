ActiveAdmin.register Comment do

  permit_params :product_id, :created_at, :commenter, :state, :rate, :body


  filter :state, as: :select, collection: ['true', 'false']
  filter :created_at
  filter :product_id
  filter :rate
  filter :commenter
  filter :body

  actions :all, except: [:edit]

  index :as => ActiveAdmin::Views::IndexAsTable do
    selectable_column
    column :product_id do |review|
      review.product_id
    end
    column :created_at, sortable: :created_at do |review|
      review.created_at
    end
    column :commenter, sortable: :commenter do |review|
      review.commenter
    end
    column :state, sortable: :state do |review|
      review.state
    end
    column :rate, sortable: :rate do |review|
      review.rate
    end
    column :body, sortable: false do |review|
      truncate(review.body, length: 100)
    end
    actions defaults: true do |review|
      link_to('Approve', admin_comment_path(review, params.permit(:state).merge(state: 'true')), html_options = {'data-method' => 'put'}) +
      ' ' +
      link_to('Reject', admin_comment_path(review, params.permit(:state).merge(state: 'false')), html_options = {'data-method' => 'put'})
    end
  end

  controller do
    def update
      review = Comment.find(params[:id])
      review.update_attributes(state: params['state']) if params['state'].present?
      redirect_back(fallback_location: admin_comments_path)
    end
  end
end