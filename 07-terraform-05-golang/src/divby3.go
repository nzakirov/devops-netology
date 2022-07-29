package main

import "fmt"

func main() {
  fmt.Println("Числа делящиеся  на 3:", "\n", Divby3())
}

func Divby3() []int{
  arr := [] int{}
  for i := 3; i <= 100; i++ {
    if i % 3 == 0 {
      arr = append(arr, i)
    }
  }
  return arr
}
