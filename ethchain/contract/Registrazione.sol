pragma solidity ^0.4.10;

import "Digichain.sol";

//il Registrazione ha un bilancio che "virtualmente" decresce man mano che si detiene il diritto.
contract Registrazione{
uint public tempoPass;
uint public idOpera;
address public owner;//compratore del diritto
address public daoOwner;


function Registrazione(uint _idOpera,address compratore){
	tempoPass = now;
	idOpera=_idOpera;
	owner=compratore;
	daoOwner=msg.sender;
}

function rinuncia() {
	if (daoOwner!=msg.sender)throw;
	
    Digichain lista = Digichain(daoOwner);
    
	address ownerOfOpera = lista.getOwner(idOpera);
	uint spent = getSpent(lista.getTimeCost(idOpera),(now-tempoPass));

	if(spent>=this.balance){//ho speso troppo 
	    //alertare l'owner
	    ownerOfOpera.send(this.balance);
	    lista.evento("SpentExceded. pagato unicamente creatore:",amountToRefound);
	}
	else {
	    uint amountToRefound = this.balance - spent;
	    owner.send(amountToRefound);
	    lista.evento("Somma ridata indietro:",amountToRefound);
	    ownerOfOpera.send(spent);
	    lista.evento("Somma pagata al creatore:",spent);
	}

	suicideMe();



}

    function getAmountToRefound() external constant returns (uint){
        Digichain lista = Digichain(daoOwner);
        uint spent = getSpent(lista.getTimeCost(idOpera),(now-tempoPass));
        if(spent>=this.balance){
            return 0;
        }
        else
            return this.balance -spent;
    }
    
    function getSpent(uint costoMinuti,uint intervallo) internal returns (uint){
        return costoMinuti*(intervallo)/60;
    }
	//aggiungere sempre quest funzione se no send non va 
	function() payable { }

	function suicideMe() internal{//dovrebbe essere sempre vuoto
		selfdestruct(owner);
	}


}
