RSpec.shared_context 'admin logged in' do
  let(:admin) { create(:account, password: 'P@SSw0rD') }

  before do
    post('/auth/admin/login', params: { email: admin.email, password:  'P@SSw0rD' })
  end
end
