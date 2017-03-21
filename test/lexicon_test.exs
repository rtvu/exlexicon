defmodule LexiconTest do
  use ExUnit.Case

  doctest Lexicon

  test "new lexicon" do
    lexicon = Lexicon.new()
    assert lexicon.size == 0
    assert lexicon.trie.is_word == false
    assert lexicon.trie.children == %{}
  end

  test "poplulated lexicon" do
    words = ["a", "aa", "ab", "cat", "ca", "locking"]
    lexicon = Lexicon.new(words)
    assert lexicon.size == length(words)
    assert Lexicon.has_word?(lexicon, "cat")
    assert Lexicon.has_prefix?(lexicon, "lock")
    assert Lexicon.has_prefix?(lexicon, "locking")
    refute Lexicon.has_word?(lexicon, "c")
    refute Lexicon.has_word?(lexicon, "cate")
    refute Lexicon.has_prefix?(lexicon, "draw")
    refute Lexicon.has_word?(lexicon, "lockingt")
  end
end
