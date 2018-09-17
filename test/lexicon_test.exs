defmodule LexiconTest do
  use ExUnit.Case

  doctest Lexicon

  test "new lexicon" do
    lexicon = Lexicon.new()
    assert lexicon.size == 0
    assert lexicon.prefix.is_word == false
    assert lexicon.prefix.children == %{}
    assert lexicon.suffix.is_word == false
    assert lexicon.suffix.children == %{}
  end

  test "poplulated lexicon" do
    words = ["a", "aa", "ab", "cat", "ca", "locking"]
    lexicon = Lexicon.new(words)
    assert lexicon.size == length(words)
    assert Lexicon.has_word?(lexicon, "cat")
    assert Lexicon.has_prefix?(lexicon, "lock")
    assert Lexicon.has_prefix?(lexicon, "locking")
    assert Lexicon.has_suffix?(lexicon, "ing")
    refute Lexicon.has_word?(lexicon, "c")
    refute Lexicon.has_word?(lexicon, "cate")
    refute Lexicon.has_prefix?(lexicon, "draw")
    refute Lexicon.has_suffix?(lexicon, "tion")
    refute Lexicon.has_word?(lexicon, "lockingt")
  end

  test "adding to lexicon" do
    lexicon = Lexicon.new()
    lexicon = Lexicon.add(lexicon, "cat")
    assert lexicon.size == 1
    assert Lexicon.has_word?(lexicon, "cat")
  end
end
