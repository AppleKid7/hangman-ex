defmodule Dictionary do
  @moduledoc """
  Documentation for `Dictionary`.
  """
  alias Dictionary.Impl.WordList, as: WordList
  @opaque t :: WordList.t
  # @word_list "assets/words.txt"
  #   |> File.read!()
  #   |> String.split(~r/\n/, trim: true)

  @doc """
  Dictionary Random Word.

  ## Examples

      iex> Dictionary.random_word()
      "weapon"

  """
  @spec start() :: t
  defdelegate start(), to: WordList, as: :word_list

  @spec random_word(words :: t) :: String.t
  defdelegate random_word(words), to: WordList, as: :random_word

  # def random_word do
  #   @word_list
  #   |> Enum.random()
  # end
end
