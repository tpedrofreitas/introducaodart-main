// Implements: deve ser utilizada para criar uma herença de uma classe abstratc interface

class CepNaoEncontradoException implements Exception{
   
   @override
   String toString(){
    return "CEP não encontrado!!!";
   }
}