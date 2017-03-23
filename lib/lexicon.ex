defmodule Lexicon do
  @moduledoc """
  A lexicon (word list) implemented in Elixir.
  """

  alias Lexicon.Trie

  defstruct [trie: %Trie{}, size: 0]

  @doc """
  Returns a new empty `lexicon`.

  ## Examples

      iex> Lexicon.new()
      #Lexicon<size: 0>

  """
  def new() do
    %Lexicon{}
  end

  @doc """
  Creates a `lexicon` from an enumerable collection of words.

  ## Examples

      iex> Lexicon.new([])
      #Lexicon<size: 0>
      iex> Lexicon.new(["cat", "dog"])
      #Lexicon<size: 2>

  """
  def new(enumerable) do
    lexicon = new()
    Enum.reduce(enumerable, lexicon, fn(x, acc) -> add(acc, x) end)
  end

  @doc """
  Adds a word to the `lexicon`.

  ## Examples

      iex> lexicon = Lexicon.new(["cat", "dog"])
      #Lexicon<size: 2>
      iex> Lexicon.add(lexicon, "elephant")
      #Lexicon<size: 3>

  """
  def add(lexicon, word)

  def add(lexicon = %Lexicon{}, "") do
    lexicon
  end

  def add(lexicon = %Lexicon{trie: trie, size: size}, word) do
    trie = word
           |> prepare()
           |> add_helper(trie)
    %Lexicon{lexicon | trie: trie, size: size + 1}
  end

  defp add_helper([], trie) do
    %Trie{trie | is_word: true}
  end

  defp add_helper([letter | letters], trie = %Trie{children: children}) do
    child = Map.get(children, letter, %Trie{value: letter})
    child = add_helper(letters, child)

    children = Map.put(children, letter, child)
    %Trie{trie | children: children}
  end

  @doc """
  Checks if word is in the given `lexicon`.

  ## Examples

      iex> lexicon = Lexicon.new(["cat", "dog"])
      iex> Lexicon.has_word?(lexicon, "cat")
      true
      iex> Lexicon.has_word?(lexicon, "ca")
      false

  """
  def has_word?(%Lexicon{trie: trie}, word) do
    word = prepare(word)
    contains_helper(trie, word, true)
  end

  @doc """
  Checks if prefix is in the given `lexicon`.

  ## Examples

      iex> lexicon = Lexicon.new(["cat", "dog"])
      iex> Lexicon.has_prefix?(lexicon, "ca")
      true
      iex> Lexicon.has_prefix?(lexicon, "cat")
      true
      iex> Lexicon.has_prefix?(lexicon, "ba")
      false

  """
  def has_prefix?(%Lexicon{trie: trie}, word) do
    word = prepare(word)
    contains_helper(trie, word, false)
  end

  defp contains_helper(%Trie{is_word: true}, [], _require_word) do
    true
  end

  defp contains_helper(%Trie{is_word: false}, [], require_word) do
    false == require_word
  end


  defp contains_helper(%Trie{children: children}, [letter | letters], require_word) do
    case Map.fetch(children, letter) do
      {:ok, trie} ->
        contains_helper(trie, letters, require_word)
      _ ->
        false
    end
  end

  defp prepare(word) do
    word
    |> String.downcase()
    |> String.graphemes()
  end

  defimpl Inspect do
    def inspect(%Lexicon{size: size}, _opts) do
      "#Lexicon<size: #{size}>"
    end
  end
end
