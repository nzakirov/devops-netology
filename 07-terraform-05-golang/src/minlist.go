package main

import "fmt"

func main() {
  x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
  fmt.Printf("Минимальный элемент: %d\n", Minarr(x))
}

func Minarr(xarr []int) int{
  min := xarr[0]
  for _, val := range xarr {
    if min > val {
      min = val
    }
  }
  return min
}
