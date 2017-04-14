pragma solidity ^0.4.10;

library Lib{
    struct Opera {
        address owner;
        string titolo;
        uint256 costoBase;//è un costo della gestione che verrà usato dopo nell'escrow
        uint256 costoTempo;
    }
}
