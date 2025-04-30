defmodule B1Web.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use B1Web, :html

  embed_templates "page_html/*"

  def plural_phrase(1, noun), do: "one #{noun}"
  def plural_phrase(n, noun) when n < 0, do: "<span style='color: red'>&nbsp;#{n} #{noun}s</span>" |> raw() 
  def plural_phrase(n, noun), do: "#{n} #{noun}s"
end
