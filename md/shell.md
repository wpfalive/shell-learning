# shell

## 什么是shell编程
对linux命令的逻辑化处理

## 为什么
解放双手，处理重复工作
```sh
git add .
git ci -m '修复...问题'
# git ci -a -m '修复...问题'
git push
git co dev
git merge -
# 有冲突解决冲突
git push
git co -
```

## 基本语法
```sh
#!/bin/bash
echo hello world!
```

### 变量
```sh
#!/bin/bash
# 系统变量
echo $PATH
#自定义变量
#注意：=左右没有空格
hello='hello world'
echo $hello

#将linux命令执行结果保存到变量
path=$(pwd)
files=`ls -al`
echo current path:$path
echo files: $files
```

### 基本数据类型运算
| 符号 | 语义| 描述 |
| :-----| :----| :----: |
| + | 加 | 10+10, 结果为20 |
| - | 减 | ... |
| * | 乘 | ... |
| / | 除 | ... |
| % | 取余 | ... |
| == | 相等 | 相等返回1，反之返回0 |
| != | 不等 | ... |
| > | 大于 | 等于返回1，反之返回0 |
| >= | 大于等于 | ... |
| < | 小于 | ... |
| <= | 小于等于 | ... |

### 整数运算
* expr

```sh
expr 10 + 3 # 13

expr 10+3 # 10+3 运算符前后必须有空格

expr 10 \* 3 # 30 反斜杠转义

```

* $[]
```sh
# 不能有空格，否则报错
num1=10
num2=3
echo "num1 + num2=$[$num1 + $num2]"
echo "num1 + num2=$[$num1+$num2]"
echo "num1 > num2=$[$num1 > $num2]"

#expr 需要注意的事项 这里都可以忽略
```

### 浮点运算

```sh
# variable=$(echo "options; expression" | bc)
# shell中 浮点运算一般用bash内置计算器-bc
num=$(echo "scale=2; 10 / 3" | bc)
```

### 条件选择

```sh
if command
then
  commands
fi
# 如果command正常退出，状态码为0，否则为其他值
# 如果状态码为0，则commands将被执行

if command; then
  commands
fi

if command
then
  commands
else
  commands
fi

if command1
then
  commands
elif
  command2
then
  commands
fi
```
上述只能根据退出状态码判断，表达式怎么处理？

* 表达式
```sh
num1=100
num2=200
# test $num1 > $num2 结果错误
# test $num2 \> $num2 结果正确
if test $num1 -eq $num2
then
	echo num1等于num2
else
	echo num2不等于num2
fi
```
test只能判断：

* 数值比较
* 字符串比较
* 文件比较


数值比较

| 符号 | 描述 |
| :-----|:----: |
| n1 -eq n2 | 相等 |
| n1 -ge n2 | 大于等于 |
| n1 -gt n2 | 大于 |
| n1 -le n2 | 小于等于 |
| n1 -lt n2 | 小于 |
| n1 -ne n2 | 不等于 |


双括号允许比较过程中使用高级数学表达式，括号里面两边都需要空格

* 双括号

```sh
num1=100
num2=200
if (( num1 > num2 )) 
then
	echo "num1 > num2"
else 
	echo "num1 <= num2"
fi
```
字符串比较
| 符号 | 描述 |
| :-----|:----: |
| str1 = str2 | 判断str1是否与str2相同 |
| str1 != str2 | 判断str1是否与str2不相同 |
| str1 < str2 | 判断str1是否比str2小(根据ASCII) |
| str1 > str2 | 判断str1是否比str2大(根据ASCII) |
| -n str1 | 判断str1的长度是否非0 |
| -z str1 | 判断str1的长度是否为0 |

> 在使用大于（>）或小于（<）符号时，需要转义

* 方括号
避免转义
```sh
num1=100
num2=200
if (( num1 > num2 )) 
then
	echo "num1 > num2"
else 
	echo "num1 <= num2"
fi
```

### for
```sh
for item in list
do commands
done

for str in a b c d e
do
  echo $str
done

list="a,b,c,d,e"
for str in $list
do
  echo $str
done
```



