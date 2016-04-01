module FriendRequestsHelper
  def friend_request_button(user)
    if !current_user.pending_friends.where(id: user.id).empty?
      button_tag 'Pending Request', class: 'btn btn-primary disabled', 'data-purpose': 'pending-friend-request-button'
    elsif current_user != user && !current_user.friends_with?(user)
      render 'users/request_modal', user: user
    end
  end

  def display_request_message(user)
    simple_format current_user.friendships.find_by(friend_id: user.id).message
  end

  def accept_request_button(user)
    link_to friend_request_path(user), method: 'put', class: 'btn btn-success btn-xs', 'data-purpose': 'accept-friend-request-button' do
      '<span class="fa fa-check"></span> Accept'.html_safe
    end
  end

  def decline_request_button(user)
    link_to friend_request_path(user), method: 'delete', class: 'btn btn-danger btn-xs', 'data-purpose': 'decline-friend-request-button' do
      '<span class="fa fa-times"></span> Decline'.html_safe
    end
  end

  def cancel_request_button(user)
    button_to 'Cancel Request', friend_request_path(user), method: 'delete', class: 'btn btn-danger btn-xs', 'data-purpose': 'cancel-friend-request-button'
  end
end
