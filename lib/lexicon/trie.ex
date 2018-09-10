defmodule Lexicon.Trie do
  @moduledoc false

  defstruct value: nil, is_word: false, children: %{}
end
