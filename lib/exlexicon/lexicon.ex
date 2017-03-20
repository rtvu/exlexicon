defmodule ExLexicon.Lexicon do
  @moduledoc """
  A lexicon (word list) implemented in Elixir.
  """

  alias ExLexicon.Lexicon
  alias ExLexicon.Lexicon.Node

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
    node = String.downcase(word)
           |> String.codepoints()
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
  def has_word?(lexicon, word) do

  end
  @doc """
  Checks if prefix is in the given 'lexicon'.
  """
end
