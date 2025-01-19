defmodule Hangman.Impl.Game do
  alias Hangman.Type, as: Type

  @type t :: %__MODULE__{
          turns_left: non_neg_integer,
          game_state: Type.state(),
          letters: [String.t()],
          used: MapSet.t(String.t())
        }

  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  #########################################################

  @spec new_game :: t
  def new_game do
    Dictionary.random_word() |> new_game()
  end
  # def new_game do
  #   Dictionary.start()
  #   |> Dictionary.random_word()
  #   |> new_game()
  # end

  @spec new_game(word :: binary) :: t
  def new_game(word) when is_binary(word) do
    %__MODULE__{
      letters: word |> String.codepoints()
    }
  end

  #########################################################

  @spec make_move(t, String.t()) :: {t, Type.tally()}
  def make_move(game = %{game_state: state}, _guess)
      when state in [:won, :lost] do
    game
    |> return_with_tally()
  end

  def make_move(game, guess) do
    accept_guess(game, guess, MapSet.member?(game.used, guess))
    |> return_with_tally()
  end

  #########################################################

  @spec accept_guess(t, String.t(), boolean) :: t
  defp accept_guess(game, guess, _already_used = true)
       when is_binary(guess) and byte_size(guess) == 1 and guess >= "a" and guess <= "z" do
    %{game | game_state: :already_used}
  end

  defp accept_guess(game, guess, _already_used)
       when is_binary(guess) do
    %{game | used: MapSet.put(game.used, guess)}
    |> score_guess(Enum.member?(game.letters, guess))
  end

  #########################################################

  @spec score_guess(t, boolean) :: t
  defp score_guess(game, _good_guess = true) do
    new_state = maybe_won(MapSet.subset?(MapSet.new(game.letters), game.used))
    %{game | game_state: new_state}
  end

  defp score_guess(game = %{turns_left: 1}, _bad_guess) do
    %{game | game_state: :lost, turns_left: 0}
  end

  defp score_guess(game, _bad_guess) do
    %{game | game_state: :bad_guess, turns_left: game.turns_left - 1}
  end

  #########################################################
  @spec return_with_tally(t) :: {t, Type.tally()}
  defp return_with_tally(game) do
    {game, tally(game)}
  end

  @spec tally(t) :: Type.tally()
  def tally(game) do
    %{
      turns_left: game.turns_left,
      game_state: game.game_state,
      letters: reveal_guessed_letters(game),
      used: game.used |> MapSet.to_list() |> Enum.sort()
    }
  end

  # @spec reveal_guessed_letters(t) :: [String.t]
  defp reveal_guessed_letters(game = %{game_state: :lost}) do
    game.letters
  end

  defp reveal_guessed_letters(game) do
    game.letters
    |> Enum.map(fn letter -> MapSet.member?(game.used, letter) |> maybe_reveal_letter(letter) end)
  end

  @spec maybe_reveal_letter(boolean, String.t()) :: String.t()
  defp maybe_reveal_letter(true, letter) when is_binary(letter) and byte_size(letter) == 1,
    do: letter

  defp maybe_reveal_letter(do_reveal, letter)
       when is_binary(letter) and byte_size(letter) == 1 and is_boolean(do_reveal),
       do: "-"

  defp maybe_won(true), do: :won
  defp maybe_won(_), do: :good_guess
end
