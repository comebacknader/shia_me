class Feed < ActiveRecord::Base
  attr_accessible :admin_id, :post, :title

  belongs_to :admin
  belongs_to :feedable, :polymorphic => true

end
