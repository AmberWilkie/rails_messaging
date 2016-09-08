require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryGirl.create(:user, name: 'Amber', email: 'theamb@gmail.com', password: 'password') }

  describe 'Factory' do
    it 'is valid' do
      expect(FactoryGirl.create(:user)).to be_valid
    end

  end

  it 'should create a user' do
    expect(subject.save).to eq true
  end

  it 'should have a name' do
    expect(subject.name).to eq 'Amber'
  end

  it 'should have an email' do
    subject.reload
    expect(User.first.email).to eq 'theamb@gmail.com'
  end


  describe 'Users table' do
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :name }
    it { is_expected.to have_db_column :email }
    it { is_expected.to have_db_column :encrypted_password }
  end

  describe 'Validations' do

    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
  end

  describe 'Mailboxer' do
    describe 'methods' do
      it { is_expected.to respond_to :mailboxer_name }
      it { is_expected.to respond_to :mailboxer_email }
      it { is_expected.to respond_to :mailbox }
    end

    describe 'functionality' do
      let!(:thomas) {FactoryGirl.create(:user, name: 'Thomas', email: 'thomas@random.com')}

      before do
        thomas.send_message(subject, 'Hello Amber', 'Yo!')
      end

      it 'adds message to inbox' do
        expect(subject.mailbox.inbox.count).to eq 1
      end

    end

  end

end
