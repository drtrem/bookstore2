ActiveAdmin.register Category do

  permit_params :category

  index do
    column
    column :category.page(params[:page]).per(8)
    actions
  end
end
