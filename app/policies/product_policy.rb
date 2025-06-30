# app/policies/product_policy.rb
class ProductPolicy < ApplicationPolicy
  def index?
    user.role == 'owner'
  end
  
  def create?
    user.role == 'owner'
  end
  
  def update?
    user.role == 'owner' && record.user_id == user.id
  end
  
  def destroy?
    user.role == 'owner'
  end
end