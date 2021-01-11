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
如果test判断条件成立，就退出并返回成功状态码0
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

数值比较需要使用文本形式的比较符号，
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



* 双方括号

可以避免转义
```sh
var1=test # t-116
var2=Test # T-84
num2=200
if [[ $var1 > $var2 ]] 
then
	echo "$var1 > $var2"
else 
	echo "$var1 <= $var2"
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
# for...in循环默认以空格或制表符（tab）或换行符（Enter）分隔，由系统环境变量IFS定义
```

### 修改IFS
```bash
oldIFS=$IFS
#修改IFS值，以逗号为分隔符
IFS=$','
list=a,b,c,d,e
list2="a b c d e"
for var in $list
do
    echo $var
done
for var2 in $list2
do
    echo $var2
done
#还原IFS的值
IFS=$oldIFS
```

### C风格的for循环
```sh
for (( i = 0; i <= 10; i++ ))
do
  echo $i
done
```

### while循环
```sh
# 基本格式
while test command
do
  other commands
done

flag=0
while test $flag -le 10
do
  echo $flag
  flag=$[$flag + 1]
done

# 变形如下
flag=0
while [ $flag -le 10 ]
do
  echo $flag
  flag=$[$flag + 1]
done
```

### 控制循环

#### break用于跳出当前循环
```sh
for (( flag=0; flag <= 10; flag++ ))
do
  if (( $flag == 5 ))
  then
    break
  fi
  echo $flag
done
```

#### break用于跳出内层循环
```sh
flag=0
while (( $flag < 10 ))
do
  for (( innerFlag=0; innerFlag < 5; innerFlag++ ))
  do
    if (( $innerFlag == 2 ))
    then
        break
    fi
    echo "innerFlag=$innerFlag"
  done
  echo "outerFlag=$flag"
done
```

以上代码当innerFlag为2时就会跳出内层for循环，由于外层flag一直为0，while没有终止条件，因此会死循环，不停输出：
...
innerFlag=0
innerFlag=1
outerFlag=0
...

可以在break后接数字，表示退出几层循环
```sh
flag=0
while (( $flag < 10 ))
do
  for (( innerFlag=0; innerFlag < 5; innerFlag++ ))
  do
    if (( $innerFlag == 2 ))
    then
        # 2表示外面一层循环
        break 2
    fi
    echo "innerFlag=$innerFlag"
  done
  echo "outerFlag=$flag"
done
```

### 命令行参数处理
#### 根据参数位置获取参数
```sh
#!/bin/bash
echo "file name: $0"
# $0获取当前shell的名称，包含路径 base获取单纯的文件名
echo "base file name: $(basename $0)"
echo "param1: $1"
echo "param2: ${2}"
```

$?执行上一个指令的返回值

#### 获取参数总数
${}内不能再写$符号，因此用了!符号
```sh
#!/bin/bash
for (( index=0; index <= $#; index++ ))
do
    echo ${!index}
done

# $* 将所有参数当做一个单词保存
# $@ 将所有参数当作同一个字符串中多个独立的单词
var1=$*
var2=$@
echo "var1: $var1"
echo "var2: $var2"
countvar1=1
countvar2=1
for param in "$*"
do
    echo "first loop param$countvar1: $param"
    countvar1=$[ $countvar1 + 1 ]
done
echo "countvar1: $countvar1"

for param in "$@"
do
    echo "second param$countvar2: $param"
    countvar2=$[ $countvar2 + 1 ]
done
echo "countvar2: $countvar2"
```

### 获得用户输入
```sh
#!/bin/bash
echo -n "yes or no(y/n)?"
read choice
echo "your choice: $choice"
```
如果不指定read后面的变量名，则放到特殊环境变量REPLY中
```sh
echo -n "yes or no(y/n)?"
read
echo "your choice: $REPLY"
```

#### 多个输入
```sh
#!/bin/bash
# read -p 等价于 echo -n read
read -p "what's your name?" first last
echo first: $first
echo last: $last
# 指定超时时间
#/bin/bash
if read -t 5 -p "Please enter your name: " name
then
	echo "Hello $name"
else
	echo "Sorry, timeout! "
fi

```

### echo
* -n 表示不换行输出
```sh
echo 'foo'; echo 'bar'
echo -n 'foo'; echo 'bar'
```

* 保留原格式
```sh
echo `ifconfig`
echo "`ifconfig`"
```

* -e 输出转义字符
```sh
echo -e 'foo\tbar'
# \b 删除前一个字符 \b\b删除前两个字符
# \b后面没有任何字符时，并没有被转义为退格键
echo -e '123\b'
echo -e '123\b4567'
```

## 后续计划
* 重复工作流程化

* 命令标准化

git add git commit git push git merge等流程统一

* 命令校验

* 简单化

提供常用功能，比如暂存，回滚，查看日志，删除分支等，一个命令完成

比如在git add, git ci可以对前置状态，备注信息等做校验