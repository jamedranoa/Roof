describe User do

  it { should ensure_length_of(:password).is_at_least(6) }
  it { should validate_presence_of(:fname) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }

end
