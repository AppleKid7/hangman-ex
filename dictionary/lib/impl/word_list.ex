defmodule Dictionary.Impl.WordList do
  alias Dictionary.Type, as: Type

  # @spec is_word_list([any]) :: boolean
  # defp is_word_list(list) when is_list(list) do
  #   Enum.all?(list, &is_binary/1)
  # end

  @type t :: list(String.t)

  @spec word_list() :: t
  def word_list() do
    try do
      "../../assets/words.txt"
      |> Path.expand(__DIR__)
      |> File.read!()
      |> String.split(~r/\n/, trim: true)
    rescue
      _ -> ["onomatopoeia"]
    end
  end

  # @spec random_word(words :: Type.word_list()) :: Type.word
  # def random_word(words) do
  #   case is_word_list(words) do
  #     true -> 
  #       try do
  #         Enum.random(words)
  #       rescue
  #         _ -> "onomatopoeia"
  #       end
  #     false -> "onomatopoeia"
  #   end
  # end

  @spec random_word(t) :: String.t
  def random_word(words) do
    case validate_and_get_random_word(words) do
      {:ok, word} -> word
      {:error, _reason} -> "onomatopoeia"
    end
  end

  @spec validate_and_get_random_word(any()) ::
          {:error, Type.failure_reasons()} | {:ok, String.t}
  def validate_and_get_random_word(words) when is_list(words) do
    if Enum.all?(words, &is_binary/1) do
      case words do
        [] ->
          {:error, :empty_list}

        _ ->
          try do
            {:ok, Enum.random(words)}
          rescue
            _ -> {:error, :random_failed}
          end
      end
    else
      {:error, :invalid_list_elements}
    end
  end

  def validate_and_get_random_word(_), do: {:error, :not_a_list}
end
