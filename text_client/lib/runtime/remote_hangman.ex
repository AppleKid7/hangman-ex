defmodule TextClient.Runtime.RemoteHangman do

  @remote_server :"hangman@LAPTOP-F9I0DG2J"
  
  def connect() do
    :rpc.call(@remote_server, Hangman, :new_game, [])
  end
end
