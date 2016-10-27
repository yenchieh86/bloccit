class User < ActiveRecord::Base
    
    # to register an inline callback directly after the 'before_save' callback
    # ' { self.email = email.downcase } ' is the code that will run when 'before_save' been called
    before_save { set_name }
    before_save { self.email = email.downcase if email.present? }
    
    # use 'validates' function to ensure that 'name' is present and has a minimum and minimum length
    validates :name, length: { minimum: 1, maximum: 100 }, presence: true
    
    # use 2 validations to validate password
    # 1: to ensure that new user has a valid password
    # 2: to ensure that the password is more than 6 characters long
    # 'allow_blank: true' is use to skip the validation if there's no updated password given (won't force to change password when user want to change other attributes)
    validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
    validates :password, length: { minimum: 6 }, allow_blank: true
    
    # make sure email is present, unique, case insensitive, has minimum maximum length, and a properly formatted email address
    validates :email,
              presence: true,
              uniqueness: { case_sensitive: false },
              length: { minimum: 3, maximum: 254 }
              
    # it abstracts away much of the complexity of obfuscating user passwords using hashing algorighms which we would otherwise be inclined to write to securely save password
    # it need a 'password_digest'attribute on the model it is applied to .
    # it creates two virtual attributes 'password' and 'password_confirmation' that we use to set and save the password
    # need to install 'BCrypt for 'has_secure_password'
    has_secure_password
    
    # 'BCrypt' is a module that encapsulates complex hashing algorithms 
    # 'BCrypt' takes a plain text password and turns it into an unrecognizable string of characters using a hashing algorithm such as MD5. 
    # use 'BCrypt' is more save than hashing algorithms, because it can't be reverse even someone has access to the password
    
    def set_name
        if name 
            array = name.split(' ')
            new_array = []
            array.each do |a|
                new_array << a.capitalize
            end
            self.name = new_array.join(' ')
        end
    end
    
end
