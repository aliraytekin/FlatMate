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
    puts "DEBUG record.offer_id: #{record.offer_id}"
    puts "DEBUG user.bookings.exists?: #{user.bookings.where(offer_id: record.offer_id).exists?}"
    user.bookings.where(offer_id: record.offer_id).exists?
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
