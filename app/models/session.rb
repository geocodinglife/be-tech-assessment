class Session < ApplicationRecord
  validate :no_overlapping_sessions

  private

  def no_overlapping_sessions
    if Session.exists?(['(start BETWEEN ? AND ? OR (start + duration * 60) BETWEEN ? AND ?) AND coach_hash_id = ?',
                        start, start + duration.minutes, start, start + duration.minutes, coach_hash_id])
      errors.add(:base, 'Overlapping sessions are not allowed')
    end
  end
end
