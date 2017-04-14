var digichain = {
	init: function (){
		return null;
	}
	,getMax: function (){

	}

//  event EventRinunciaContratto(address owner,uint256 idOpera);
	,getEventRinunciaContratto: function (_digichain){
		return _digichain.EventRinunciaContratto({},'',function(error,r){
			if(!error)
			console.log("Rinuncia del contratto posseduto da " + r.args.owner + " sull'opera " +  r.args.idOpera);
			else
				consol.log(error);
			});
	}

//  event EventCreazioneContratto(address adrr,address Registrazione,uint256 balance);
	,getEventCreazioneContratto: function (_digichain){
		return _digichain.EventCreazioneContratto({},'',function(error,r){
			if(!error)
			console.log("Creato nuovo contratto : (" + r.args.adrr + " | " +  r.args.Registrazione +") versati : " + r.args.balance);
			else
				consol.log(error);
			});
	}

//	  event EventCreazioneOpera(address adrr,uint256 id_opera,uint256 costoBase,uint256 costoTempo);
	,getEventCreazioneOpera: function (_digichain){
		return _digichain.EventCreazioneOpera({},'',function(error,r){
			if(!error)
			console.log("Opera creata : (" + r.args.adrr + " | " +  r.args.id_opera + ") costoBase : " + r.args.costoBase + " costo al minuto : " + r.args.costoTempo);
			else
				consol.log(error);
			});
	}
	//  event EventErrore(string errore,uint num);
	,getEventErrore: function (_digichain){
		return _digichain.EventErrore({},'',function(error,r){
			if(!error)
			console.log("Evento info : (" + r.args.errore + " " +  r.args.num );
			else
				consol.log(error);
			});
	}

}


