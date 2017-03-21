defmodule Lexicon do
  @moduledoc """
  A lexicon (word list) implemented in Elixir.
  """

  alias Lexicon.Node

  defstruct [node: %Node{}, size: 0]

  @doc """
  Creates a 'lexicon' from a 'list'.
  """
  def new(list) when is_list(list) do
    new()
    |> add(list)
  end

  @doc """
  Returns a new empty 'lexicon'.
  """
  def new() do
    %Lexicon{}
  end

  @doc """
  Add a word or a word list to the 'lexicon'.
  """
  def add(lexicon = %Lexicon{}, "") do
    lexicon
  end

  def add(lexicon = %Lexicon{}, [word]) do
    lexicon
    |> add(word)
  end

  def add(lexicon = %Lexicon{}, [word | words]) do
    lexicon
    |> add(word)
    |> add(words)
  end

  def add(lexicon = %Lexicon{node: node, size: size}, word) do
    node = word
           |> prepare()
           |> add_helper(node)
    %Lexicon{lexicon | node: node, size: size + 1}
  end

  defp add_helper([], node) do
    %Node{node | is_word: true}
  end

  defp add_helper([letter | letters], node = %Node{nodes: nodes}) do
    child = Map.get(nodes, letter, %Node{})
    child = add_helper(letters, child)

    nodes = Map.put(nodes, letter, child)
    %Node{node | nodes: nodes}
  end

  @doc """
  Checks if word is in the given 'lexicon'.
  """
  def has_word?(%Lexicon{node: node}, word) do
    word = prepare(word)
    contains_helper(node, word, true)
  end

  @doc """
  Checks if prefix is in the given 'lexicon'.
  """
  def has_prefix?(%Lexicon{node: node}, word) do
    word = prepare(word)
    contains_helper(node, word, false)
  end

  defp contains_helper(%Node{is_word: true}, [], _require_word) do
    true
  end

  defp contains_helper(%Node{is_word: false}, [], require_word) do
    false == require_word
  end


  defp contains_helper(%Node{nodes: nodes}, [letter | letters], require_word) do
    case Map.fetch(nodes, letter) do
      {:ok, value} ->
        contains_helper(value, letters, require_word)
      _ ->
        false
    end
  end

  defp prepare(word) do
    word
    |> String.downcase()
    |> String.codepoints()
  end

  defimpl Inspect do
    def inspect(%Lexicon{size: size}, _opts) do
      "%Lexicon{size: #{size}}"
    end
  end
end
