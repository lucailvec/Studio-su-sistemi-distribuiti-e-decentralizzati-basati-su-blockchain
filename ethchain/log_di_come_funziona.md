loadscript("../testDeploy.js");
//per testare l'import 
getCoinbaseBalance();

//scrivo il codice di un contratto:
source = "contract test{ 
	address public addr; 
	event settedNumber(uint numero);
	function double(uint n)returns (uint){ 
	addr=msg.sender;
	settedNumber(n); 
	return 2*n; 
	}
}"
source = "contract test{ address public addr; event settedNumber(uint numero);function double(uint n)returns (uint){ addr=msg.sender;settedNumber(n); return 2*n; }}"
//compilo e salvo il riusultato della compilazione
compiled = eth.compile.solidity(source)

//prendo il singolo contenuto del contratto (compiled["<stdin>:NOME"])
//e
//lo passo al codice di deploy e prendo il riusultato

//ATTENZIONE il seguente deploy fa solo il deploy di contratti che nella funzione di init non accettano niente come input da argomento


//eseguo sblocca() per poter usufruire da web3 del nostro account salvato nel keystore
sblocca()
test=deployTest(compiled["<stdin>:test"])

//ora test 
test.addr()
test.double.call("2")
test.double.call("4")
test.addr()

res=test.double.call("2",function(e,r){
//console.log(e);
//console.log(JSON.stringify(r));
return r;
}
)

var event = test.settedNumber({}, '', function(error, result){
if (!error)
console.log("Numero inviato: " + result.args.numero + ".\n" );
});

//TEST FUNZIONA



//registrar code

> sblocca()
undefined
> gbl = deployer.deployAbiAndCode(globalRegistrar.code.abi,globalRegistrar.code.unlinked_binary)
Contract transaction send: TransactionHash: 0x4d17bcc5d936405eb0cd015abb7fa437461bfc813301556d60d0474489bf5132 waiting to be mined...


//event EventNewContract(string name,address _address,address _owner);
var eventGlb = glb.EventNewContract({},'',function(e,r){
if(!error)
console.log("Nuova entry : <" + r.args.name + " | " +  r.args._address +"> da : " + r.args._owner);
})



> eth.getTransaction("0xfe24a2323734639ba890ed0d0be5afc82d82e6d33a7434d9e18d075da6d1bf93")
{
  blockHash: "0x64c1c7f40b5a50b0623eddc5c0eee25935f6e193da6caf65030808147a621e0f",
  blockNumber: 4253,
  from: "0x2a54983e9b648684676c4f78638654177cd4be6a",
  gas: 90000,
  gasPrice: 20000000000,
  hash: "0xfe24a2323734639ba890ed0d0be5afc82d82e6d33a7434d9e18d075da6d1bf93",
  input: "0x2bffc7ed00000000000000000000000000000000000000000000000000000000000000400000000000000000000000002a54983e9b648684676c4f78638654177cd4be6a000000000000000000000000000000000000000000000000000000000000000a6c75636176656363686900000000000000000000000000000000000000000000",
  nonce: 25,
  r: "0x871f0bf7c1ae5f1a98e8f61bad09744fb0dc0dc75f2666b69ec8abb1c01f519c",
  s: "0x68c14891ef65bb64fe8f0c13ae9c7ca79c09e433303133cc6dde5b0e11702eee",
  to: "0x006d7d37c3706865ef62b5e5d56b879841693062",
  transactionIndex: 0,
  v: "0x1c",
  value: 0
}



> gbl.getAddressContract("lucavecchi")
"0x2a54983e9b648684676c4f78638654177cd4be6a"
> gbl.getAddressContract("prof")
> gbl.getAddressContract("digichain")

//PER COMPILARE DA solc: 
eseguire il comando compileContracts.sh che compilerà tutti i file nella cartella contract e porrà il risultato nella cartella build

nella cartella build il file compiled.js dovrà essere importato nell' ambiente attraverso il compando loadScript("");

c'è l' oggetto "compiled" contine gli oggetti compilati divisi per :
  nome:
    abi:
    bin:
per compilare usare il metodo get

//event per la creazione event CreazioneOpera(address adrr,uint id_opera,uint costoBase,uint costoTempo);
var eventDigichain = digichain.CreazioneOpera({},'',function(e,r){
console.log(e);
if(!e)
console.log("Nuova opera : " + r.args.addr + "  id: " +  r.args.id_opera +" con " + r.args.costoBase + " costoTempo: " + r.args.costoTempo);
})

//ATTENZIONE la computazione non dava nessun problema, debug.traceTransaction non dava nessun errore (come mai ?) si concludeva con {} e non con "out of gas" o qualche errore simile.

> digichain.creaOpera("ciao","2","2",{from: eth.coinbase,gas: 3000000})
"0x4acae2d2ec9947c4bbe5f1ade92c98ba1d859d6ebcbd2436ea9b923f834611da"
> eth.getTransaction("0x4acae2d2ec9947c4bbe5f1ade92c98ba1d859d6ebcbd2436ea9b923f834611da")
{
  blockHash: "0xa86bc87c7352227729f069430c60a935ded232cef08410751ad62a6ed61b0bad",
  blockNumber: 5722,
  from: "0x438dfd4dfd26a42961d878a1e27eb9f40abb0d19",
  gas: 3000000,
  gasPrice: 20000000000,
  hash: "0x4acae2d2ec9947c4bbe5f1ade92c98ba1d859d6ebcbd2436ea9b923f834611da",
  input: "0x9b92483200000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000046369616f00000000000000000000000000000000000000000000000000000000",
  nonce: 21,
  r: "0xaa479ee1ca83a0b426c382fae58afc3b595d0c92c56ee4adb1df49320d952988",
  s: "0x34a413cbc6c6db5906fae2148e7710c456cbe82e3ba18b7948396c317e512512",
  to: "0xad3376b45124ae4b805c5204d71d58e2c69a9c84",
  transactionIndex: 0,
  v: "0x1c",
  value: 0
}
> digichain.length()
1
> digichain.getOwner(1)
"0x0000000000000000000000000000000000000000"
> digichain.getOwner(0)
"0x438dfd4dfd26a42961d878a1e27eb9f40abb0d19"



//DIGICHAIN how to 

#importo il globalregistrar

glb = glb.globalRegistrar()

#una volta importato possono testare la sua esecuzione con 

glb.getAddressContract("lucavecchi")
glb.getAddressContract("prof")


## Se non è già stato fatto il deploy del contratto eseguo l'operazione (1) se no vado direttamente alla (2)

# (1) eseguo il deploy tramite l'oggetto deployer dopo aver attivato il mining

> miner.start(1)
> eth.mining
> digichain = deployer.deployCompiledByNameAndCompiled("Digichain",compiled)

#una volta che ho minato carico del global registrar l'address del contratto

> sblocca()
> glb.add.sendTransaction("digichain",digichain.address,{from: eth.coinbase})

#testo la registrazione tramite

> glb.getAddressContract("digichain")
"0x6713b8233bcd748c5338a26cde0d1bba9765edbe"



# (2) si suppone che il contratto digichain sia stato già distribuito

#creo un opera (ATTENZIONE: a seguito di un bug può capitare che via debug.traceTransaction() non dia out of gas ma semplicemente {})
> digichain.creaOpera("ciao mondo(opera)","0","1000000",{from: eth.coinbase,gas:3000000})
> digichain.length()
1
> digichain.opere(0)
["0x438dfd4dfd26a42961d878a1e27eb9f40abb0d19", "ciao mondo(opera)", 0, 1000000]

#
> digichain = deployer.getIstanceFromAbiAndAddress(compiled.contracts["Digichain.sol:Digichain"].abi,glb.getAddressContract("digichain"))

#l'istanza di eth.contract potrà essere invocata con l'abi che gli abbiamo passato come parametro.

> digichain.compra.sendTransaction("0",{from:eth.coinbase, value: 1000000*5})

> digichain.getAmountToRefound(eth.coinbase)
> digichain.rinuncia.sendTransaction({from: eth.coinbase,gas: 4000000})


//EVENTI

#per osservare i log degli indirizzi : 
var filter = web3.eth.filter({ address: glb.getAddressContract("digichain"), fromBlock: 0, toBlock: "latest" });
var i = 0;
filter.watch(function (error, result) {
  console.log("RESULT: Filter " + i++ + ": " + JSON.stringify(result));
});
filter.stopWatching();


  event EventRinunciaContratto(address owner,uint256 idOpera);
  event EventCreazioneContratto(address adrr,address Registrazione,uint256 balance);
  event EventCreazioneOpera(address adrr,uint256 id_opera,uint256 costoBase,uint256 costoTempo);
  event EventErrore(string errore,uint num);

//event EventRinunciaContratto(address owner,uint256 idOpera);


var eventRinunciaContratto = glb.EventRinunciaContratto({},'',function(e,r){
if(!error)
console.log("Nuova entry : <" + r.args.name + " | " +  r.args._address +"> da : " + r.args._owner);
})
