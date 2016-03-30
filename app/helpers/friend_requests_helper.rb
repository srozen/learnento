module FriendRequestsHelper
  def friend_request_button
    if !current_user.pending_friends.where(id: @user.id).empty?
      button_tag 'Pending Request', class: 'btn btn-primary disabled', 'data-purpose': 'pending-friend-request-button'
    elsif current_user != @user && !current_user.friends_with?(@user)
      link_to 'Friend Request', {:controller => "friend_requests", :action => "create", :id => @user.id}, class: 'btn btn-primary', 'data-purpose': 'send-friend-request-button', :method => "post"
    end
  end

  def accept_request_button(user)
    link_to 'Accept Request', friend_request_path(user), method: 'put', class: 'btn btn-success', 'data-purpose': 'accept-friend-request-button'
  end

  def decline_request_button(user)
    button_to 'Decline Request', friend_request_path(user), method: 'delete', class: 'btn btn-danger', 'data-purpose': 'decline-friend-request-button'
  end

  def cancel_request_button(user)
    button_to 'Cancel Request', friend_request_path(user), method: 'delete', class: 'btn btn-danger btn-xs', 'data-purpose': 'cancel-friend-request-button'
  end
end
