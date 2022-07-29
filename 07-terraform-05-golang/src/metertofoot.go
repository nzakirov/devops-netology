package main

import "fmt"

func main() {
  fmt.Print("Enter a value in meters: ")
  var input float64
  fmt.Scanf("%f", &input)

  output := meterToFeet(input)

  fmt.Println(input, "meters =", output, "feet")
}

func meterToFeet(meters float64) float64 {
  return meters * 0.3048
}
