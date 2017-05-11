# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  first_surname        :string
#  second_surname       :string
#  names                :string
#  tipo_de_documento_id :integer
#  document_number      :string
#  expedition_date      :date
#  uid                  :string
#  approved             :boolean
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  document_photo_id    :integer
#  email                :string
#  password_hash        :string
#  password_salt        :string
#  role_type            :integer
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relations' do
    it { should have_many(:causes) }
    it { should have_many(:polls) }
    it { should have_many(:voted_polls) }
    it { should have_many(:votes) }
    it { should have_many(:debate_votes) }
    it { should belong_to(:tipo_de_documento) }
  end

  describe 'enums' do
    it { should define_enum_for(:role_type) }
  end

  describe 'validations' do
    describe 'not an admin validations' do
      let(:user) { User.new(role_type: 0, uid: '', document_number: '') }
      it 'should validate presence' do
        user.valid?
        expect(user.errors[:uid]).to include('no puede estar en blanco')
        expect(user.errors[:document_number]).to include('no puede estar en blanco')
        expect(user.errors[:tipo_de_documento]).to include('no puede estar en blanco')
      end
      let(:pre_invalid_user) { FactoryGirl.create(:user, uid: '1', document_number: 'abc') }
      let(:invalid_user) { User.new(role_type: 0, uid: pre_invalid_user.uid, document_number: 'abc') }
      it 'should validate numericality' do
        invalid_user.valid?
        expect(invalid_user.errors[:document_number]).to include('no es un número')
      end
      it 'should validate uniqueness' do
        invalid_user.valid?
        expect(invalid_user.errors[:uid]).to include('ya ha sido tomado')
        expect(invalid_user.errors[:document_number]).to include('ya ha sido tomado')
      end
    end
    describe 'admin validations' do
      let(:invalid_admin) { User.new(role_type: 2, uid: '', email: nil) }
      it 'should validate email' do
        invalid_admin.valid?
        expect(invalid_admin.errors[:email].empty?).to be false
      end
      it 'should validate password' do
        invalid_admin.valid?
        expect(invalid_admin.errors[:contraseña].empty?).to be false
      end
    end
    it { should validate_presence_of(:first_surname) }
    it { should validate_presence_of(:second_surname) }
    it { should validate_presence_of(:names) }
    it { should validate_presence_of(:role_type) }

    describe '#first_surname' do
      it { should_not allow_value('surname123').for(:first_surname) }
    end
    describe '#second_surname' do
      it { should_not allow_value('surname123').for(:second_surname) }
    end
    describe '#names' do
      it { should_not allow_value('name123').for(:second_surname) }
    end
  end

  describe 'User#full_name' do
    let(:user) { FactoryGirl.build(:user, names: 'John', first_surname: 'Dummy', second_surname: 'Doe') }
    context 'when user has names, first_surname y second_surname' do
      it 'returns user full name' do
        expect(user.full_name).to eq('John Dummy Doe')
      end
    end
  end

  describe 'User#already_voted?' do
    let(:user) { FactoryGirl.create(:user) }
    let(:voted_poll) { FactoryGirl.create(:poll_with_votes) }
    let(:non_voted_poll) { FactoryGirl.create(:poll) }
    context 'when user has already voted for a poll' do
      it 'returns true' do
        user.votes << voted_poll.votes.first
        expect(user.already_voted?(voted_poll)).to be true
      end
    end
    context 'when user has not voted for a poll' do
      it 'returns false' do
        expect(user.already_voted?(non_voted_poll)).to be false
      end
    end
  end

  describe 'User#debate_already_voted?' do
    let(:user) { FactoryGirl.create(:user) }
    let(:voted_debate) { FactoryGirl.create(:debate_with_debate_votes) }
    let(:non_voted_debate) { FactoryGirl.create(:debate_with_debate_votes) }
    context 'when user has already votes for in a debate' do
      it 'returns true' do
        debate_votes = voted_debate.debate_votes
        debate_votes.first.update(user: user)
        expect(user.debate_already_voted?(voted_debate)).to be true
      end
    end
    context 'when user has not voted for in a debate' do
      it 'returns false' do
        expect(user.debate_already_voted?(:non_voted_debate)).to be false
      end
    end
  end

  describe 'User.get_admin()' do
    let(:admin_user) { FactoryGirl.create(:user, role_type: 2) }
    let(:non_admin_user) { FactoryGirl.create(:user, role_type: 0) }
    context 'when user is an admin' do
      it 'returns the user' do
        params =  { email: admin_user.email, password: admin_user.password }
        expect(User.get_admin(params)).to eq(admin_user)
      end
    end
    context 'when user is not an admin' do
      it 'returns nil' do
        params =  { email: non_admin_user.email, password: non_admin_user.password }
        expect(User.get_admin(params)).to eq(nil)
      end
    end
  end
end
