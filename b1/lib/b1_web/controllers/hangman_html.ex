defmodule B1Web.HangmanHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `hangman_html` directory for all templates available.
  """
  use B1Web, :html

  embed_templates "hangman_html/*"

  #####################################################################################

  attr :tally, :map, required: true

  def tally_info(assigns) do
    ~H"""
    <table class="tally">
    <tr>
      <th>Turns left:</th>
      <td><%= @tally.turns_left %></td>
    </tr>

    <tr>
      <th>Letters used:</th>
      <td class="spread"><%= @tally.used |> Enum.join(", ") %></td>
    </tr>

    <tr>
      <th>Word so far:</th>
      <td class="spread-sofar"><%= @tally.letters |> Enum.join(" ") %></td>
    </tr>

    </table>
    """
  end

  #####################################################################################

  def continue_or_try_again(conn, status) when status in [ :won, :lost ] do
    path = ~p"/hangman"
    """
    <form action = "#{path}" method="post" style="display: inline;">
      <input type="hidden" name="_csrf_token" value="#{Phoenix.Controller.get_csrf_token()}">
      <button type="submit" class="btn">Try again</button>
    </form>
    """
  end 

  def continue_or_try_again(conn, _) do
    path = ~p"/hangman"
    """
    <form action="#{path}" method="post">
      <input type="hidden" name="_method" value="put">
      <input type="hidden" name="_csrf_token" value="#{Phoenix.Controller.get_csrf_token()}">
      <div class="form-text">
        <input type="text" name="make_move[guess]">
      </div>
      <div>
        <button class="btn" type="submit">Make next guess</button>
      <div>
    </form>
    """
  end

  #####################################################################################

  @status_fields %{
    initializing: { "initializing", "Guess the word, a letter at a time" },
    good_guess:   { "good-guess",   "Good guess!"},
    bad_guess:    { "bad-guess",    "Sorry, that's a bad guess"},
    won:          { "won",          "You won!"},
    lost:         { "lost",         "Sorry, you lost"},
    already_used: { "already-used", "You already used that letter"},
  }

  def move_status(status) do
    { class, msg }  = @status_fields[status]
    "<div class='status #{class}'>#{msg}</div>"
  end

  #####################################################################################
  defdelegate figure_for(turns_left), to: B1Web.HangmanView.Helpers.FigureFor 

end
