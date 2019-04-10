Trestle.resource(:items) do
  remove_action :destroy

  menu do
    item :items, icon: "fa fa-star"
  end

  table do
    column :id
    column :category
    column :title
    column :price
    column :published
    column :created_at, align: :center
    column :updated_at, align: :center
    actions do |toolbar, instance, admin|
      if instance.active?
        toolbar.link 'Delete', admin.path(:deactivate, id: instance.id), class: 'btn btn-danger'
      else
        toolbar.link 'Restore', admin.path(:activate, id: instance.id), class: 'btn btn-success'
      end
    end
  end

  scopes do
    scope :active, default: true, label: 'All'
    scope :drafts
    scope :published
    scope :deleted
  end

  form do |item|
    row do
      col(xs: 6) { text_field :title }
      col(xs: 6) { text_field :price }
    end
    select :category_id, Category.order(:name).all
    text_area :description
    text_field :comments
    check_box :published
    select(:main_image_id, item.image_selection) if item.images.any?
    active_storage_field :images
  end

  controller do
    def activate
      if item = admin.find_instance(params)
        item.activate
        flash[:message] = "Item successfully restored"
      end
      redirect_to admin.path(:index)
    end
    def deactivate
      if item = admin.find_instance(params)
        item.deactivate
        flash[:message] = "Item successfully deleted"
      end
      redirect_to admin.path(:index)
    end
  end

  routes do
    get :deactivate, on: :member
    get :activate, on: :member
  end
end
