module FriendsHelper
  def remove_friend_button(friend)
    button_to 'Delete Friend', friend_path(friend), method: 'delete', class: 'btn btn-danger', 'data-purpose': 'remove-friend-button'
  end
end
