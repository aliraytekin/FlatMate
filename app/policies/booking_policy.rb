class BookingPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.joins(:offer).where(
        'bookings.user_id = :user_id OR offers.user_id = :user_id',
        user_id: user.id
      )
    end
  end

  def show?
    record.user == user || record.offer.user == user
  end

  def new?
    create?
  end

  def create?
    true
  end

  def edit?
    update?
  end

  def update?
    record.user == user
  end

  def payment?
    record.user == user
  end

  def update_status?
    record.offer.user == user
  end

  def cancel?
    record.user == user || record.offer.user == user
  end

  def success?
    record.user == user || record.offer.user == user
  end

  def confirmation?
    record.user == user || record.offer.user == user
  end
end
