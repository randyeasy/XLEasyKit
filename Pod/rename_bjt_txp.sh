
#!/bin/bash
#path变量指向你的目标目录，找好目标目录并取消下方行的注释

for i in `find . -type f -name *TX*.*`
do       
  name=`echo $i | sed 's/TX/XLE/g'`
  mv $i  $name
  echo $i '====>' $name
  sed -i "" 's/TX/XLE/g' $name
  sed -i "" 's/tx/xle/g' $name
done
