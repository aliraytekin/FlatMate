class ReviewPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end

  def new?
    create?
  end

  def create?
    user.bookings.where(offer_id: record.offer.id).exists? if record.offer
  end

  def edit?
    update?
  end

  def update?
    record.booking.user == user
  end

  def destroy?
    record.booking.user == user
  end
end
