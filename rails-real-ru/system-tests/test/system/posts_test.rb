# frozen_string_literal: true

require 'application_system_test_case'

# BEGIN
class PostsTest < ApplicationSystemTestCase
  test 'Should show posts' do
    visit posts_path

    assert_selector 'h1', text: 'Posts'
  end

  test 'Should show post' do
    post = posts(:one)
    visit post_path(post)

    assert_selector 'h1', text: post.title
    assert_selector 'p', text: post.body
  end

  test 'Should create post' do
    visit posts_path

    click_on 'New Post'
    fill_in 'Title', with: posts(:one).title
    fill_in 'Body', with: posts(:one).body
    click_on 'Create Post'
    assert_text 'Post was successfully created'
  end

  test 'Should update post' do
    visit posts_path

    updated_title = 'Updated title'

    click_on 'Edit', match: :first
    fill_in 'Title', with: updated_title
    click_on 'Update Post'
    assert_text 'Post was successfully updated'
    assert_selector 'h1', text: 'Updated title'
  end

  test 'Should destroy post' do
    visit posts_path

    page.accept_confirm do
      click_on 'Destroy', match: :first
    end
    assert_text 'Post was successfully destroyed'
    assert_selector 'td', count: 4
  end
end
# END
