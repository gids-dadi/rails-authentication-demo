# class Admin < ApplicationRecord
#   devise :database_authenticatable, :registerable,
#          :recoverable, :rememberable, :validatable

#   # Enum
#   enum admin_type: {
#     super_admin: 0,
#     customer: 1,
#     staff_user: 2
#   }

#   # Associations
#   belongs_to :role, optional: true

#   # Callbacks
#   before_save :manage_role

#   def manage_role
#     self.role_id = 1 if customer?
#   end
# end



# class Admin < ApplicationRecord
#   # Include default devise modules. Others available are:
#   # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
#   devise :database_authenticatable, :registerable,
#          :recoverable, :rememberable, :validatable

#   # Associations
#   enum admin_type: {
#     super_admin: 0,
#     customer: 1,
#     staff_user: 2
#   }
# belongs_to :role, optional: true

# before_save :manage_role

# def manage_role

#     self.role_id = 1

# end
# end


# MODEL FILE: app/models/admin.rb
class Admin < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Enum - using integer values to match migration

  enum :admin_type, { super_admin: 0, customer: 1, staff_user: 2 }, prefix: true

  # Associations
  belongs_to :role, optional: true

  # Callbacks
  before_save :manage_role

  private

  def manage_role
    # Only assign role if admin is a customer and doesn't already have a role
    if customer? && role_id.blank?
      # Make sure the role exists before assigning
      customer_role = Role.find_by(id: 1)
      self.role_id = customer_role.id if customer_role
    end
  end
end
