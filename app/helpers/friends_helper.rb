module FriendsHelper
  def remove_friend_button(friend)
    link_to 'Delete Friend', friend_path(friend), method: 'delete', class: 'btn btn-danger', 'data-purpose': 'confirm-remove-friend-button'
  end

  def block_friend_button(friend)
    button_to 'Block Friend', friend_path(friend, block: 'true'), method: 'put', class: 'btn btn-warning', 'data-purpose': 'confirm-block-friend-button'
  end

  def unblock_friend_button(friend)
    button_to 'Unblock Friend', friend_path(friend, block: 'false'), method: 'put', class: 'btn btn-xs btn-success', 'data-purpose': 'unblock-friend-button'
  end

  def remove_friend_modal(friend)
    render 'friends/delete_modal', friend: friend
  end

  def block_friend_modal(friend)
    render 'friends/block_modal', friend: friend
  end

  def blocked_friends_collapse(blocked_friends)
    render 'friends/blocked_collapse', blocked_friends: blocked_friends
  end
end
