# Run from repo root
# pip install cmake-format

args="--line-width 200 \
      --tab-size 4 \
      --use-tabchars False \
      --dangle-parens True \
      --always-wrap False \
      --enable-markup False \
      --command-case lower \
      --max-pargs-hwrap 3 \
      --autosort True \
      --disabled-codes C0103 C0113"

cmakeformat()
{
    cmake-format -i $1 ${args}
    cmake-lint $1 --suppress-decorations ${args}
}

cmakeformat ./CMakeLists.txt

cmakeformat ./ext/CMakeLists.txt

for f in $(find ./cmake -name '*.cmake'); do
    cmakeformat $f
done

for f in $(find ./src -name 'CMakeLists.txt'); do
    cmakeformat $f
done
