# Day 8

## original question link

<https://adventofcode.com/2021/day/8>

## solution

part1 
- hard to read question, easy to code
part2 
- compare digit 1 and digit 7 find out new 'a'
- compare digit 2、3、5 (digit 2 contains 'ce', digit 3 contains 'cf', digit 5 contains 'bf'), get new 2'c'、1'b'、1'e'、2'f'
- digit 4 is 'bdcf', so we can get new 'e' and new 'd'
- compare 2'c'、1'b'、1'e'、2'f', 'b' num is 1 we can get new 'b'
- digit 2 contains 'ce', digit 3 contains 'cf', digit 5 contains 'bf', we get new 'e', so we can get new 'c'
- we get new 'b', we get new 'f'
- finally, new 'g' is the last

regard a char as a bit, we can regard digit as number
by doing this, we can turn a string into a number and a number is map to a digit. 

```
for example
'a' = 2^0 = 1, 'b' = 2^1 = 2 ...
digit 1 is "cf", so 
digit 1 -> "cf" -> 'c' + 'f' -> 2^2 + 2^5 -> 36
```
## difficulty  ★★★★☆
