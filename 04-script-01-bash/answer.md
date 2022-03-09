# 1.

| Переменная  | Значение | Обоснование |
| ------------- | ------------- | ------------- |
| `c`  | `a+b`  | присваивается текст |
| `d`  | `1+2`  | присваивается как текст значения a и b |
| `e`  | `3`  | присваивается сумма значений переменных как чисел  |


# 2.

```bash
while ((1==1))
do
    curl https://localhost:4757
    if (($? != 0))
    then
        date >> curl.log
    else
        break
    fi
done
```

# 3.

```bash
#!/bin/bash

ip_arr=(
    192.168.0.1
    173.194.222.113
    87.250.250.242
)

port=80
count=5

for ip in ${ip_arr[@]}
do
    for (( i = 0; i < $count; i++))
    do
        nc -zw1 $ip $port
        if (($? == 0))
        then
            echo "`date '+%Y-%m-%d %T'` ${ip}:${port}    UP" >> log
        else
            echo "`date '+%Y-%m-%d %T'` ${ip}:${port}    DOWN" >> log
        fi
    done
done
```

# 4.

```bash
#!/bin/bash

ip_arr=(
    192.168.0.1
    173.194.222.113
    87.250.250.242
)

port=80
count=5
is_down=0

while (($is_down == 0))
do
    for ip in ${ip_arr[@]}
    do
        if (($is_down == 1))
        then
            break
        fi
        echo $ip
        for (( i = 0; i < $count; i++))
        do
            nc -zw1 $ip $port
            is_down=$?
            if (($is_down == 0))
            then
                echo "`date '+%Y-%m-%d %T'` ${ip}:${port}    UP" >> log
            else
                echo "`date '+%Y-%m-%d %T'` ${ip}:${port}    DOWN" >> error
                break
            fi
        done
    done
done
```

# 5.



