defmodule B2Web.Live.Game do

  use B2Web, :live_view

  def mount(_params, _session, socket) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    socket = socket |> assign(%{ game: game, tally: tally })
    { :ok, socket }
  end

  def render(assigns) do
    ~H"""
    <div class="game-holder">
      <.live_component module={__MODULE__.Figure} tally={@tally} id="1") />
      <.live_component module={__MODULE__.Alphabet} tally={@tally} id="2") />
      <.live_component module={__MODULE__.WordSoFar} tally={@tally} id="3") />
    </div>
    """
  end

end
