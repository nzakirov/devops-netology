# Домашнее задание к занятию "7.5. Основы golang"

<details><summary></summary>

> С `golang` в рамках курса, мы будем работать не много, поэтому можно использовать любой IDE. 
> Но рекомендуем ознакомиться с [GoLand](https://www.jetbrains.com/ru-ru/go/).  

</details>

## Задача 1. Установите golang.

<details><summary></summary>

> 1. Воспользуйтесь инструкций с официального сайта: [https://golang.org/](https://golang.org/).
> 2. Так же для тестирования кода можно использовать песочницу: [https://play.golang.org/](https://play.golang.org/).

</details>

```
❯ sudo tar -C /usr/local -xzf go1.18.4.linux-amd64.tar.gz
```

```
❯ go version
go version go1.18.4 linux/amd64
❯ echo $GOPATH
/home/znail/go

```
## Задача 2. Знакомство с gotour.

<details><summary></summary>

> У Golang есть обучающая интерактивная консоль [https://tour.golang.org/](https://tour.golang.org/). 
> Рекомендуется изучить максимальное количество примеров. В консоли уже написан необходимый код, осталось только с ним ознакомиться и поэкспериментировать как написано в инструкции в левой части экрана.  

</details>

## Задача 3. Написание кода. 

<details><summary></summary>

> Цель этого задания закрепить знания о базовом синтаксисе языка. Можно использовать редактор кода на своем компьютере, либо использовать песочницу: [https://play.golang.org/](https://play.golang.org/).

</details>

<details><summary>1.</summary>

> Напишите программу для перевода метров в футы (1 фут = 0.3048 метр). Можно запросить исходные данные у пользователя, а можно статически задать в коде. Для взаимодействия с пользователем можно использовать функцию `Scanf`:
    
>  ```
>    package main
>    
>    import "fmt"
>    
>    func main() {
>        fmt.Print("Enter a number: ")
>        var input float64
>        fmt.Scanf("%f", &input)
>    
>        output := input * 2
>    
>        fmt.Println(output)    
>    }
>    ```

</details>

```golang
package main

import "fmt"

func main() {
  fmt.Print("Enter a value in meters: ")
  var input float64
  fmt.Scanf("%f", &input)

  output := MeterToFeet(input)

  fmt.Println(input, "meters =", output, "feet")
}

func MeterToFeet(meters float64) float64 {
  return meters * 0.3048
}
``` 
 
```
❯ go run metertofoot.go                                                                               ─╯
Enter a value in meters: 3
3 meters = 0.9144000000000001 feet
```

<details><summary>2.</summary>

> Напишите программу, которая найдет наименьший элемент в любом заданном списке, например:
>    ```
>    x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
>    ```

</details>

```golang

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
```

```
❯ go run minlist.go                                                                                   ─╯
Минимальный элемент: 9
```

<details><summary>3.</summary>

> Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3. То есть `(3, 6, 9, …)`.

</details>

```golang

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
```

```
❯ go run divby3.go                                                                                    ─╯
Числа делящиеся  на 3: 
 [3 6 9 12 15 18 21 24 27 30 33 36 39 42 45 48 51 54 57 60 63 66 69 72 75 78 81 84 87 90 93 96 99]
```

## Задача 4. Протестировать код (не обязательно).

<details><summary></summary>

> Создайте тесты для функций из предыдущего задания. 

</details>

Протестируем функцию  из 3.1. Для этого создаем файл `metertofoot_test.go` :

```golang

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
```

Запускаем тестирование:

```
❯ go test metertofoot.go metertofoot_test.go                                                          ─╯
ok  	command-line-arguments	0.003s
```
