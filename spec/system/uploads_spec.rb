# frozen_string_literal: true

RSpec.describe 'Uploads', type: :system do
  let!(:author) { Author.create!(email: 'some_email@example.com', age: 30) }

  it 'uploads a test file' do
    visit "/admin/authors/#{author.id}/edit"

    expect(author.avatar).not_to be_attached
    expect(page).to have_css('#author_avatar_input .jfu_upload_input[type="file"]')
    expect(page).not_to have_css('#author_avatar_input .jfu_done')
    attach_file('author[avatar]', 'spec/fixtures/thinking-cat.jpg')
    expect(page).to have_css('#author_avatar_input .jfu_done')
    expect(author.reload.avatar).to be_attached
  end
end
