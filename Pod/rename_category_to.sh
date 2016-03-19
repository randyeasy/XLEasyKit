
#!/bin/bash
#path变量指向你的目标目录，找好目标目录并取消下方行的注释

for i in `find . -type f -name *XLE*.*`
do
  echo $i '====>' $i
  sed -i "" 's/xle/XLE/g' $i
done
