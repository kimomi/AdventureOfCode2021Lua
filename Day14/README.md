# Day 14

## original question link

<https://adventofcode.com/2021/day/14>

## solution

1. In part 1

 we can just use table to save all element like : {a, b, c, d, a, b}.

 and count all element: a:2, b:2, c:1, d:1

2. In part 2

if we update table as part 1, it's obviously that the count is too much to save!

so, we should find how to descript the table using small memory but we can get all element num and upating element num is also correct.

The solution is using element pair! If we know element pair num, we can also know element num, and upating it is easy.

if we find out save element pairs count rather than element array, part2 is solved too.
for array {a, b, c, d, a, b}, we cant get pair: ab:2,bc:1,cd:1,da:1

## difficulty  ★★★★☆
