pragma solidity ^0.4.18;

contract VanillaOption {
  OptionTerms public _optionTerms;
  
  //ValueDate yyyymmdd in the past [maturity=today]
  function VanillaOption(int callOrPut, bytes32 valueDate) public payable {
    _optionTerms =  new OptionTerms(callOrPut, valueDate);
  }
  
  function getOptionTypeString() public constant returns (bytes32) {
      return _optionTerms.getOptionTypeString();
  }
}

//==============================================================

contract OptionTerms {
    OptionType public _callOrPut;
    bytes32 public _valueDate;
        
    function OptionTerms(int callOrPut, bytes32 valueDate) public {
        _valueDate= valueDate;
        
        if (callOrPut == 1) {
            _callOrPut= new OptionTypeCall();
        }
        else if (callOrPut == 2) {
            _callOrPut= new OptionTypePut();
        }
        else
            _callOrPut= new OptionTypeUnknown();
    }
    
    function getOptionType() public view returns (OptionType) {
        return _callOrPut;
    }
    
    function getOptionTypeString() public constant returns (bytes32) {
        return _callOrPut.getOptionTypeString();
    }
}

//==============================================================

contract OptionType {
    function getOptionTypeString() public constant returns (bytes32);
}

contract OptionTypeCall is OptionType {
    function getOptionTypeString() public view returns (bytes32) {
        return "CALL";
    }
}

contract OptionTypePut is OptionType {
    function getOptionTypeString() public view returns (bytes32) {
        return "PUT";
    }
}

contract OptionTypeUnknown is OptionType {
    function getOptionTypeString() public view returns (bytes32) {
        return "UNKNOWN";
    }
}

//==============================================================
