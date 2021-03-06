pragma solidity ^0.4.18;

contract MyFirstOption {
  OptionTerms private _optionTerms;
  
  //ValueDate yyyymmdd in the past [maturity=today]
  function MyFirstOption() public payable {
    _optionTerms =  new OptionTerms(-1); //init to Unknown OptionType 
  }
  
  function getOptionTypeString() public constant returns (bytes32) {
      return _optionTerms.getOptionTypeString();
  }
  
  function setOptionTypeString(int callOrPut) public {
      _optionTerms =  new OptionTerms(callOrPut);
  }
}

//==============================================================

contract OptionTerms {
    OptionType public _callOrPut;
    bytes32 public _valueDate;
        
    function OptionTerms(int callOrPut) public {
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
