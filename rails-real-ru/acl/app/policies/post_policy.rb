# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  # BEGIN
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user
  end

  def new?
    create?
  end

  def update?
    author? || admin?
  end

  def edit?
    update?
  end

  def destroy?
    admin?
  end

  private

  def author?
    record.author == user
  end

  def admin?
    user&.admin?
  end
  # END
end
