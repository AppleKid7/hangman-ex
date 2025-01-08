defmodule Dictionary do
  @moduledoc """
  Documentation for `Dictionary`.
  """
  # alias Dictionary.Impl.WordList, as: WordList
  # @opaque t :: WordList.t
  alias Dictionary.Runtime.Server, as: Server
  @opaque t :: Server.t
  # @word_list "assets/words.txt"
  #   |> File.read!()
  #   |> String.split(~r/\n/, trim: true)

  @doc """
  Dictionary Random Word.

  ## Examples

      iex> Dictionary.random_word()
      "weapon"

  """
  @spec random_word() :: String.t
  defdelegate random_word(), to: Server

  # def random_word do
  #   @word_list
  #   |> Enum.random()
  # end
end
