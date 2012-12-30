class Feed < ActiveRecord::Base
  attr_accessible :admin_id, :feedable_id, :feedable_type, :post, :title

  belongs_to :admin
  belongs_to :feedable, :polymorphic => true

end
