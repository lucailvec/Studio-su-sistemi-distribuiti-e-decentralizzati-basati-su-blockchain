var globalRegistrar =
	{ 	
		getGlobalRegistrar: function (){
		gRegister = eth.contract(globalRegistrar.code.abi).at(globalRegistrar.addressDeployed);
				console.log("Oggetto settato!");
				return gRegister;
			
		}
        ,watchEventNewContract:function(_istance){
            return _istance.EventNewContract({},'',function(e,r){
            if(!e)
             console.log("Nuova entry : <" + r.args.name + " | " +  r.args._address +"> da l'account : " + r.args._owner);
            else{
                console.log(e);
            }
            }  );
        }
		,addressDeployed: "0x4f2f2510fd4f07a72d0ac0c720d7f5c8ff808d6e"

		,code: {
		 "abi":[{
    constant: false,
    inputs: [{
        name: "_newName",
        type: "string"
    }, {
        name: "_contr",
        type: "address"
    }, {
        name: "_pastName",
        type: "string"
    }],
    name: "change",
    outputs: [],
    payable: false,
    type: "function"
}, {
    constant: false,
    inputs: [{
        name: "_name",
        type: "string"
    }, {
        name: "_contr",
        type: "address"
    }],
    name: "add",
    outputs: [],
    payable: false,
    type: "function"
}, {
    constant: true,
    inputs: [{
        name: "",
        type: "bytes32"
    }],
    name: "hashMap",
    outputs: [{
        name: "owner",
        type: "address"
    }, {
        name: "contr",
        type: "address"
    }],
    payable: false,
    type: "function"
}, {
    constant: true,
    inputs: [{
        name: "_str",
        type: "string"
    }],
    name: "getAddressContract",
    outputs: [{
        name: "addressContract",
        type: "address"
    }],
    payable: false,
    type: "function"
}, {
    constant: true,
    inputs: [{
        name: "_str",
        type: "string"
    }],
    name: "getOwnerOfContract",
    outputs: [{
        name: "addressOwner",
        type: "address"
    }],
    payable: false,
    type: "function"
}, {
    anonymous: false,
    inputs: [{
        indexed: false,
        name: "name",
        type: "string"
    }, {
        indexed: false,
        name: "_address",
        type: "address"
    }, {
        indexed: false,
        name: "_owner",
        type: "address"
    }],
    name: "EventNewContract",
    type: "event"
}, {
    anonymous: false,
    inputs: [{
        indexed: false,
        name: "from",
        type: "string"
    }, {
        indexed: false,
        name: "to",
        type: "string"
    }, {
        indexed: false,
        name: "contrAddress",
        type: "address"
    }, {
        indexed: false,
        name: "_owner",
        type: "address"
    }],
    name: "EventChanged",
    type: "event"
}],
"unlinked_binary": "0x6060604052341561000c57fe5b5b61066a8061001c6000396000f30060606040526000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680632bffc7ed1461005c578063aa475f9f146100d5578063d1d895cb1461016c578063e7dc4d1f146101d7575bfe5b341561006457fe5b6100d3600480803590602001908201803590602001908080601f0160208091040260200160405190810160405280939291908181526020018383808284378201915050505050509190803573ffffffffffffffffffffffffffffffffffffffff16906020019091905050610242565b005b34156100dd57fe5b6100f7600480803560001916906020019091905050610364565b604051808373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020018273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019250505060405180910390f35b341561017457fe5b610195600480803590602001908201803590602001919091929050506103c8565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b34156101df57fe5b6102006004808035906020019082018035906020019190919290505061045a565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b61024c82826104ec565b507fc763c5fa21df7ecfa291270a6af3a86d20f242bc58a9774ec2bcc4f7cf64a67082823360405180806020018473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020018373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001828103825285818151815260200191508051906020019080838360008314610324575b80518252602083111561032457602082019150602081019050602083039250610300565b505050905090810190601f1680156103505780820380516001836020036101000a031916815260200191505b5094505050505060405180910390a15b5050565b60006020528060005260406000206000915090508060000160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff16908060010160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff16905082565b6000600060028484600060405160200152604051808383808284378201915050925050506020604051808303816000866161da5a03f1151561040657fe5b505060405180519050905060006000826000191660001916815260200190815260200160002060010160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1691505b5092915050565b6000600060028484600060405160200152604051808383808284378201915050925050506020604051808303816000866161da5a03f1151561049857fe5b505060405180519050905060006000826000191660001916815260200190815260200160002060000160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1691505b5092915050565b600060006002846000604051602001526040518082805190602001908083835b6020831061052f578051825260208201915060208101905060208303925061050c565b6001836020036101000a0380198251168184511680821785525050505050509050019150506020604051808303816000866161da5a03f1151561056e57fe5b50506040518051905090503360006000836000191660001916815260200190815260200160002060000160006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055508260006000836000191660001916815260200190815260200160002060010160006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055508091505b50929150505600a165627a7a723058208facbbc86919401e8ca7fda0c645a808c79d80398fae0d4d1f4fadfa3e1fdb140029",
		  "networks": {},
		  "schema_version": "0.0.5",
		  "updated_at": 1490442539216
		}
	};