require 'rails_helper'

RSpec.describe Session, type: :model do
  describe 'validations' do
    let(:coach_hash_id) { '3B6V97csyi1x' }
    let(:existing_session) { create(:session, coach_hash_id: coach_hash_id, start: DateTime.now, duration: 60) }

    it 'is valid when there are no overlapping sessions' do
      new_session = build(:session, coach_hash_id: coach_hash_id, start: existing_session.start + existing_session.duration.minutes, duration: 60)
      expect(new_session).to be_valid
    end

    it 'is invalid when there is an overlapping session' do
      new_session = build(:session, coach_hash_id: coach_hash_id, start: existing_session.start, duration: 60)
      expect(new_session).to be_invalid
      expect(new_session.errors[:base]).to include('Overlapping sessions are not allowed')
    end
  end
end
