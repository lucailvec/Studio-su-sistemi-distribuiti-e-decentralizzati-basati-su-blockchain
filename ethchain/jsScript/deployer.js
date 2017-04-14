//questa classe presenta l'oggetto deployer che permette di predisporre di metodi per eseguire l'upload dei contratit facilemente
var deployer = {

//eth.contract can be used to define a contract class that will 
//comply with the contract interface as described in its ABI definition.
	getIstanceFromAbiAndAddress: function (ABI,addr){
		return eth.contract(JSON.parse(ABI)).at(addr);
	}
	,deployContract: function (_contracts){
		var _code = _contracts.code;
		var _abi = _contracts.info.abiDefinition;
			return deployer.deployAbiAndCode(_abi,_code);
		}
	,deployCompiledByNameAndCompiled: function (_name,_compiled){
		//deployer.deployAbiAndCodeAndParseJSON(compiled.contracts["Digichain.sol:Digichain"].abi,compiled.contracts["Digichain.sol:Digichain"].bin)
		var name =  _name + ".sol:" + _name;
		var contr = _compiled.contracts[name];
		return deployer.deployAbiAndCodeAndParseJSON(contr.abi,contr.bin);
	}deployAbiAndCodeAndParseJSON: function (_abi,_code){
		var jabi = JSON.parse(_abi);
		var jcode = "0x" + _code;
		return deployer.deployAbiAndCode(jabi,jcode);
	}
	,deployAbiAndCode: function (_abi,_code){
		var _objContratt = web3.eth.contract(_abi);

		var contrattoDeployed = _objContratt.new('',{from: eth.coinbase, data: _code, gas: 4000000}, function(e, _contract){
		  if(e)
		  	console.log(e);

		  if(!e) {

		    if(!_contract.address) {
		      console.log("Contract transaction send: TransactionHash: " + _contract.transactionHash + " waiting to be mined...");

		    } else {
		      console.log("Contract mined! Address: " + _contract.address);
		      console.log(_contract);
		    }

		  }
		});
			return contrattoDeployed;
	}
	,getCoinbaseBalance: function (){
		return { "address":eth.coinbase,"balance":  eth.getBalance(eth.coinbase) };
	}
};