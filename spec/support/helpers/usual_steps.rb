module UsualStepsHelper


  def as_user(user)
    visit '/#/home'
    navigation.access_login
    login.fill_login_form(user.email, 'password')
    login.confirm_login_form
    expect(page).to have_selector('[data-purpose="user-details"]')
    yield
    clear_storage
  end

  def befriend(user, friend)
    user.friend_request(friend)
    friend.accept_request(user)
    if !Conversation.between(user.id, friend.id).present?
      Conversation.create!(sender_id: user.id, recipient_id: friend.id)
    end
  end



  def clear_storage
    page.execute_script("localStorage.clear()")
  end

end

RSpec.configure { |c| c.include UsualStepsHelper, type: :feature }