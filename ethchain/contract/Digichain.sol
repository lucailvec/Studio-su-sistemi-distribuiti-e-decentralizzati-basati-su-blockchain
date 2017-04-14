pragma solidity ^0.4.10;


import "Registrazione.sol";

contract check{
    function ch() constant returns (uint){
        return msg.sender.balance;
    }
    function get(address addr) constant returns (uint){
        return addr.balance;
    }
}

contract Digichain {

    struct Opera {
        address owner;
        string titolo;
        uint256 costoBase;//è un costo della gestione che verrà usato dopo nell'escrow
        uint256 costoTempo;
        uint256 reputazione;
    }

	address public manager;

	mapping(address=>Registrazione) public contratti;
	mapping(uint256=>Opera) public opere;
	
	uint public length;
	
	event EventRinunciaContratto(address owner,uint256 idOpera);
	event EventCreazioneContratto(address adrr,address Registrazione,uint256 balance);
	event EventCreazioneOpera(address adrr,uint256 id_opera,uint256 costoBase,uint256 costoTempo);
	event EventErrore(string errore,uint num);
    event EventRivalsa(address contratto);
	function Digichain(){
		manager=msg.sender;
	}

	modifier onlyManager {
		if(manager!=msg.sender) throw;
		_;
	}

	function creaOpera(string tit,uint256 costoB,uint256 costoT) {
		opere[length]=Opera(msg.sender,	tit,costoB,costoT,0);

		EventCreazioneOpera(msg.sender,length,costoB,costoT);
		length=length+1;
		return length-1;
	}   

	function compra(uint256 id) payable 
	{
	if(msg.value< opere[id].costoBase){
	   msg.sender.send(msg.value);
	   return;
	} 
	if(id>=length){
	    msg.sender.send(msg.value);
	    return;
	}
	if(opere[id].owner==msg.sender){ 
	    msg.sender.send(msg.value);
	    return;
	    
	}//non posso acquistare la mia stessa opera e evito il throw che se no prosciga il gas
		Registrazione c = (new Registrazione)(id,msg.sender);//TODO controllare se msg.sender è giusto
		contratti[msg.sender]= c;

		uint256 toSent= msg.value - opere[id].costoBase;
        
		if(c.send(toSent)){
			contratti[msg.sender]= c;
			EventCreazioneContratto(msg.sender,c,c.balance);
		} else{//li ridò indietro se no se sbaglio consumo tutto
		    msg.sender.send(msg.value);
			EventErrore("Problema invio msg!",toSent);
		}
	}


	function rinuncia(){
		Registrazione c= contratti[msg.sender];
		address _owner = c.owner();
		uint256 _idOpera = c.idOpera();
		if(_owner!=msg.sender){//impossibile
		   EventErrore("msg.sender diverso da owner!!",0);
		    throw;
		}
		opere[_idOpera].reputazione+=opere[_idOpera].costoTempo*(now - c.tempoPass())/(1 hours); //manca verifica
		c.rinuncia();
		delete(contratti[_owner]);
		delete(c);
		EventRinunciaContratto(_owner,_idOpera);
	}

	//sono obbligato ad usare queste funzioni esterne perchè per ora non posso retituire struct, vedi FAQ solidity
	function getTimeCost(uint256 _idOpera) external constant returns (uint256) {//external è una funzione esterna invocata tramite messaggio, constant non modifica lo stato
		return opere[_idOpera].costoTempo;
	}

	function getOwner(uint256 _idOpera) external constant returns (address){
		return opere[_idOpera].owner;
	}

	function suicide() onlyManager(){
		selfdestruct(manager);
	}

    function evento(string str,uint n) constant{
        EventErrore(str,n);
    }
    
    function getAmountToRefound(address contr) constant returns (uint){
        Registrazione c =contratti[contr];
        return c.getAmountToRefound();
        /*if(c!= 0)//todo da cambiare
            return c.getAmountToRefound();
        else
            Errore("contratto non trovato",0);
        return 0;*/
    }
    
    function checkBilancioOpera(address _contratto) constant returns (uint){
        
        return contratti[_contratto].balance - getAmountToRefound(_contratto);
    }
    
    function rivalsa(address _contratto){
        if(getAmountToRefound(_contratto)==0){
            //eseguo rivalsa, solo l'autore lo può fare
            EventRivalsa(_contratto);
        }else{
            EventErrore("Non puoi fare la rivalsa se non è scaduto il tempo,rimanente: ",getAmountToRefound(_contratto));
        }
    }
    
    function () payable{}

}

