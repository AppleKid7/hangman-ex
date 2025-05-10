defmodule B1Web.HangmanController do
  use B1Web, :controller
  import Phoenix.Component, only: [to_form: 2]

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def new(conn, _params) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    form = %{"guess" => ""} |> to_form(as: :make_move)
    conn
    |> put_session(:game, game) # Connection is immutable!
    |> render(:game, tally: tally, layout: false, form: form)
  end

  def update(conn, params) do
    guess = params["make_move"]["guess"]
    tally =
      conn 
        |> get_session(:game)
        |> Hangman.make_move(guess)
    form = %{"guess" => ""} |> to_form(as: :make_move)
    put_in(conn.params["make_move"]["guess"], "")
    |> render(:game, tally: tally, layout: false, form: form)
  end
end
