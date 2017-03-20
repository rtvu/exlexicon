defmodule LexiconTest do
  use ExUnit.Case

  doctest ExLexicon.Lexicon

  alias ExLexicon.Lexicon
  alias ExLexicon.Lexicon.Node

  test "new lexicon" do
    lexicon = Lexicon.new()
    assert lexicon.size == 0
    assert lexicon.node.is_word == false
    assert lexicon.node.nodes == %{}
  end

  test "simple word list" do
    lexicon = Lexicon.new(["a", "aa", "ab", "cat", "ca"])
  end
end
