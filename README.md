# Lexicon

A lexicon (word list) implemented in Elixir. This project was inspired by the
[Lexicon class](http://stanford.edu/~stepp/cppdoc/Lexicon-class.html) found in
the [Stanford C++ libraries](http://stanford.edu/~stepp/cppdoc/).

## Installation

To use Lexicon in your Mix projects, first add Lexicon as a dependency:

```elixir
def deps do
  [{:lexicon, "~> 0.1.3"}]
end
```

After adding Lexicon as a dependency, run `mix deps.get` to install it.

## Usage

```elixir
lexicon = Lexicon.new(["cat", "dog"])
lexicon = Lexicon.add("elephant")
true == Lexicon.has_word?(lexicon, "cat")
false == Lexicon.has_prefix?(lexicon, "a")
```
