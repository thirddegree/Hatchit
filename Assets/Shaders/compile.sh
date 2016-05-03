
for file in .* *;
do
    if [[ $file == *.vert ]]
    then
        glslangValidator -V -o "${file%.vert}_VS.spv" "$file" >> compileSPV.log;
    fi

    if [[ $file == *.geom ]]
    then
        glslangValidator -V -o "${file%.geom}_GS.spv" "$file" >> compileSPV.log;
    fi

    if [[ $file == *.tesc ]]
    then    
        glslangValidator -V -o "${file%.tesc}_TCS.spv" "$file" >> compileSPV.log;
    fi

    if [[ $file == *.tese ]]
    then
        glslangValidator -V -o "${file%.tese}_TES.spv" "$file" >> compileSPV.log;
    fi

    if [[ $file == *frag ]]
    then
        glslangValidator -V -o "${file%.frag}_FS.spv" "$file" >> compileSPV.log;
    fi
done
