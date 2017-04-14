geth --identity Node1 --etherbase 2a54983e9b648684676c4f78638654177cd4be6a --networkid 1234  --maxpeers 4 --datadir="chain/01"  -verbosity 6 --ipcdisable --port 30301 --rpc --rpcapi "db,eth,net,web3,personal" --rpcport 8101 --rpccorsdomain "*"  --nat "any"  --autodag --preload "jsScript/function.js,jsScript/deployer.js,build/compiled.js,jsScript/GlobalRegistrarInit.js" --gasprice 20000 --solc /usr/bin/solc console  2>> ./chain/01/00.log
