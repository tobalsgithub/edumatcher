class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :timeoutable

  has_one :expert
  has_one :educator
  has_many :reviews

  def as_json(options)
    json = super(:include => [:expert, :educator])
    json["is_expert"] = is_expert?
    json["is_educator"] = is_educator?
    json
  end

  def is_expert?
    self.expert != nil
  end

  def is_educator?
    self.educator != nil
  end
end
