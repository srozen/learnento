module FriendsHelper
  def remove_friend_button(friend)
    button_to 'Delete Friend', friend_path(friend), method: 'delete', class: 'btn btn-danger', 'data-purpose': 'confirm-remove-friend-button'
  end

  def remove_friend_modal(friend)
    render 'friends/delete_modal', friend: friend
  end
end
