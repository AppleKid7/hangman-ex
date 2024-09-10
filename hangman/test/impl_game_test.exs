defmodule HangmanImplGameTest do
  use ExUnit.Case

  alias Hangman.Impl.Game, as: Game

  test "new game returns structure" do
    game = Game.new_game()
    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "new game returns correct word" do
    game = Game.new_game("wombat")
    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert game.letters == ["w", "o", "m", "b", "a", "t"]
  end

  test "letters consists of all lower case ASCII characters" do
    game = Game.new_game()
    assert game.letters |> Enum.all?(fn char -> char =~ ~r/^[a-z]$/ end)
  end

  test "state doesn't change if game is won or lost" do
    for state <- [:won, :lost] do
      game = Game.new_game("wombat")
      game = Map.put(game, :game_state, state)
      {new_game, _tally} = Game.make_move(game, "x")
      assert new_game == game
    end
  end

  test "a duplicate letter is reported" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
    {game, _tally} = Game.make_move(game, "y")
    assert game.game_state != :already_used
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "we record letters used" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    {game, _tally} = Game.make_move(game, "y")
    {game, _tally} = Game.make_move(game, "x")
    assert MapSet.equal?(game.used, MapSet.new(["x", "y"]))
  end

  test "we recognize a letter in the word" do
    game = Game.new_game("wombat")
    {game, tally} = Game.make_move(game, "m")
    assert tally.game_state == :good_guess
    {_game, tally} = Game.make_move(game, "t")
    assert tally.game_state == :good_guess
  end

  test "we recognize a letter not in the word" do
    game = Game.new_game("wombat")
    {game, tally} = Game.make_move(game, "x")
    assert tally.game_state == :bad_guess

    {_game, tally} = Game.make_move(game, "t")
    assert tally.game_state == :good_guess

    {_game, tally} = Game.make_move(game, "y")
    assert tally.game_state == :bad_guess
  end

  test "can handle sequence of moves" do
    # hello
    [
      # guess state    turns_left letters              used
      ["a", :bad_guess, 6, ["-", "-", "-", "-", "-"], ["a"]],
      ["a", :already_used, 6, ["-", "-", "-", "-", "-"], ["a"]],
      ["e", :good_guess, 6, ["-", "e", "-", "-", "-"], ["a", "e"]],
      ["x", :bad_guess, 5, ["-", "e", "-", "-", "-"], ["a", "e", "x"]]
    ]
    |> test_sequence_of_moves()
  end

  test "can handle a winning game" do
    # hello
    [
      # guess state    turns_left letters              used
      ["a", :bad_guess, 6, ["-", "-", "-", "-", "-"], ["a"]],
      ["a", :already_used, 6, ["-", "-", "-", "-", "-"], ["a"]],
      ["e", :good_guess, 6, ["-", "e", "-", "-", "-"], ["a", "e"]],
      ["h", :good_guess, 6, ["h", "e", "-", "-", "-"], ["a", "e", "h"]],
      ["l", :good_guess, 6, ["h", "e", "l", "l", "-"], ["a", "e", "h", "l"]],
      ["y", :bad_guess, 5, ["h", "e", "l", "l", "-"], ["a", "e", "h", "l", "y"]],
      ["m", :bad_guess, 4, ["h", "e", "l", "l", "-"], ["a", "e", "h", "l", "m", "y"]],
      ["o", :won, 4, ["h", "e", "l", "l", "o"], ["a", "e", "h", "l", "m", "o", "y"]]
    ]
    |> test_sequence_of_moves()
  end

  test "can handle a losing game" do
    # hello
    [
      # guess state    turns_left letters              used
      ["a", :bad_guess, 6, ["-", "-", "-", "-", "-"], ["a"]],
      ["a", :already_used, 6, ["-", "-", "-", "-", "-"], ["a"]],
      ["e", :good_guess, 6, ["-", "e", "-", "-", "-"], ["a", "e"]],
      ["h", :good_guess, 6, ["h", "e", "-", "-", "-"], ["a", "e", "h"]],
      ["l", :good_guess, 6, ["h", "e", "l", "l", "-"], ["a", "e", "h", "l"]],
      ["y", :bad_guess, 5, ["h", "e", "l", "l", "-"], ["a", "e", "h", "l", "y"]],
      ["m", :bad_guess, 4, ["h", "e", "l", "l", "-"], ["a", "e", "h", "l", "m", "y"]],
      ["x", :bad_guess, 3, ["h", "e", "l", "l", "-"], ["a", "e", "h", "l", "m", "x", "y"]],
      ["p", :bad_guess, 2, ["h", "e", "l", "l", "-"], ["a", "e", "h", "l", "m", "p", "x", "y"]],
      [
        "q",
        :bad_guess,
        1,
        ["h", "e", "l", "l", "-"],
        ["a", "e", "h", "l", "m", "p", "q", "x", "y"]
      ],
      [
        "t",
        :lost,
        0,
        ["h", "e", "l", "l", "o"],
        ["a", "e", "h", "l", "m", "p", "q", "t", "x", "y"]
      ]
    ]
    |> test_sequence_of_moves()
  end

  def test_sequence_of_moves(script) do
    game = Game.new_game("hello")
    Enum.reduce(script, game, &check_one_move/2)
  end

  defp check_one_move([guess, expected_state, turns, letters, used], game) do
    {game, tally} = Game.make_move(game, guess)
    assert tally.game_state == expected_state
    assert tally.turns_left == turns
    assert tally.letters == letters
    assert tally.used == used
    game
  end
end
