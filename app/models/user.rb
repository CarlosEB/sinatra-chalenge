class User < ActiveRecord::Base
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    include ActiveModel::Validations

    validates :email, 
              :format => { :with => VALID_EMAIL_REGEX, :message => "Enter a valid Email address !"},
              :uniqueness => {:case_sensitive => false, :message => "Email already exists!"}
    
    validates :name, presence: true
    
    
    has_many :user_statistics, class_name: 'UserStatistic', foreign_key: "email"
end
