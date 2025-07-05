class BookingPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.joins(:offer).where(
        'booking_user_id = :user_id OR offer.user_id = :user_id',
        user_id: user_id
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
end
