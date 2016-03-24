module FriendshipsHelper

  def friend_request_button
    if current_user.pending_friends.nil? || !current_user.pending_friends.where(id: @user.id).empty?
      button_tag 'Pending Request', class: 'btn btn-primary disabled', 'data-purpose': 'pending-friend-request-button'
    elsif current_user != @user && !current_user.friends_with?(@user)
      link_to 'Friend Request', {:controller => "friendships", :action => "create", :id => @user.id}, class: 'btn btn-primary', 'data-purpose': 'send-friend-request-button', :method => "post"
    end
  end
end
