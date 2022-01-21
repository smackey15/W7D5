class Sub < ApplicationRecord
    validates :title, :description, :moderator_id, presence: true
    belongs_to :moderator,
        foreign_key: :moderator_id,
        class_name: :User 

    ###has many Posts once Post is created.
        
end
