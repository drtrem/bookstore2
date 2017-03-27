ActiveAdmin.register Product do

permit_params :title, :author_id, :category_id, :price, :description, :year, :dimensions, :materials, :image_url

index do
  column :title
  column :author_id
  column :category_id
  column :description
  column :year
  column :dimensions
  column :materials
  column :image_url, style: :thumb
  column :price do |product|
    number_to_currency product.price, :unit => "€"
  end
  actions
end

form(:html => { :multipart => true }) do |f|
   f.inputs "Create Product..." do
    f.input :title
    f.input :author_id
    f.input :category_id
    f.input :description
    f.input :year
    f.input :dimensions
    f.input :materials
    f.input :image_url, :as => :file, :hint => f.template.image_tag(f.object.image_url.url(:thumb))
    f.input :price
   end
    f.actions
 end
end