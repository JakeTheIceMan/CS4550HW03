defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.replace(" ", "") 
    |> String.split("+") 
    |> Enum.map(fn(s) -> String.split(s, "-") 
    |> Enum.map(fn(s) -> String.split(s, "*") 
    |> Enum.map(fn(s) -> String.split(s, "/") 
    |> Enum.map(fn(s) -> Float.parse(s) |> elem(0) end)
    |> comp("/") end)
    |> comp("*") end)
    |> comp("-") end)
    |> comp("+")

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end

  def comp(vals, op) do
    case op do
      "+" -> (tl vals) |> Enum.reduce((hd vals), fn(x, acc) -> acc + x end)
      "-" -> (tl vals) |> Enum.reduce((hd vals), fn(x, acc) -> acc - x end)
      "*" -> (tl vals) |> Enum.reduce((hd vals), fn(x, acc) -> acc * x end)
      "/" -> (tl vals) |> Enum.reduce((hd vals), fn(x, acc) -> acc / x end)
    end
  end

  def factor(num) do
    case num do
      1 -> []
      _ -> [nextPrime(num, 2)] ++ factor(round(num / nextPrime(num, 2)))
    end
  end

  def nextPrime(num, prime) do
    case rem(num, prime) do
      0 -> prime
      _ -> nextPrime(num, prime+1)
    end
  end

  def isPalindrome(text) do
    String.replace(text, " ", "") |> String.downcase() == 
    String.replace(text, " ", "") |> String.downcase() |> String.reverse()
  end

end
