package main

import "testing"
import "fmt"

func TestMeterToFeet(t *testing.T) {
  // Arrange
  var meter float64 = 3
  var expected float64 = 0.9144000000000001 

  // Act
  result := MeterToFeet(meter)

  // Assert
  if result != expected {
    fmt.Println("aaa")
    //t.Errorf("Incorrect result. Expect %f, got %f", expected, result)
    s := fmt.Sprintf("Incorrect result. Expect %f, got %f", expected, result)
    t.Error(s)
  }
}
