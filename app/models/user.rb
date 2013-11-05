class User < ActiveRecord::Base
  has_many :karma_points

  attr_accessible :first_name, :last_name, :email, :username, :total_karma_points

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  validates :username,
  :presence => true,
  :length => {:minimum => 2, :maximum => 32},
  :format => {:with => /^\w+$/},
  :uniqueness => {:case_sensitive => false}

  validates :email,
  :presence => true,
  :format => {:with => /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i},
  :uniqueness => {:case_sensitive => false}

  def self.by_karma
    User.order('total_karma_points DESC')
  end

  def self.page(page_number)
    page_number = page_number.to_i
    if page_number < 1 || self.page_too_high?(page_number)
      self.limit(50)
    else
      self.limit(50).offset((page_number-1) * 50) if page_number >= 1
    end
  end

  def total_karma
    self.karma_points.sum(:value)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private
  def self.page_too_high?(page_number)
    page_number > (User.count / 50)
  end
end
