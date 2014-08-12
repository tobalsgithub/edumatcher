class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :reviewable, polymorphic: true

  validates_presence_of :user, presence: true
  validates_presence_of :reviewable, presence: true

  def as_json(options)
    json = super(:include => [:reviewable] )
    if self.reviewable_type == "Expert"
      json["reviewable_title"] = self.reviewable.user.fullname
    else
      json["reviewable_title"] = "This needs to be set"
    end
    json
  end
end
