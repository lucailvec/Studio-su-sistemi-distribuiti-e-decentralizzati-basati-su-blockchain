#!/bin/bash
#solc --add-std --optimize --combined-json abi,bin prova.sol > prova.js
cd contract; 
echo "START COMPILING";
echo var compiled= > ../build/compiled.js
((ls ) | xargs echo $1) | xargs solc --add-std --optimize --combined-json abi,bin $1 >> ../build/compiled.js 2> ../compiled.log; 
echo "END COMPILING";
cd ..