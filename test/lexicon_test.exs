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

  test "word list checking" do
    words = ["a", "aa", "ab", "cat", "ca", "locking"]
    lexicon = Lexicon.new(words)
    assert lexicon.size == length(words)
    assert Lexicon.has_word?(lexicon, "cat")
    assert Lexicon.has_prefix?(lexicon, "lock")
    refute Lexicon.has_word?(lexicon, "ae")
    refute Lexicon.has_prefix?(lexicon, "draw")
  end
end
